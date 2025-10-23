import 'dart:io';

import 'package:wick_apps/models/model_information.dart';
import 'package:wick_apps/utilities/script_helper.dart';
import 'package:wick_apps/utilities/string_formatter.dart';

void main() {
  final libraryDirectory = Directory('lib');
  final modelsFound = <String, WickModelModelInformation>{};
  final modelInheritance = <String, String>{};
  final additionalImports = <String>{};
  final abstractClasses = <String>{};
  final constructorParameters = <String, Set<String>>{};
  libraryDirectory.listSync(recursive: true).forEach((item) {
    if (item is File && item.path.endsWith('.dart')) {
      final content = item.readAsStringSync();
      final modelPattern = RegExp(
        r'(?:abstract\s+)?class\s+(\w+)(?:\s+extends\s+(\w+))?',
      );
      final matches = modelPattern.allMatches(content);
      if (matches.isNotEmpty) {
        final importPath = item.path.replaceAll('lib/', '');
        for (final match in matches) {
          final className = match.group(1)!;
          final parentClass = match.group(2);
          final classDeclaration = content.substring(match.start, match.end);
          final isAbstract = classDeclaration.startsWith('abstract');
          if (isAbstract) {
            abstractClasses.add(className);
          }
          if (parentClass != null && parentClass != 'Object') {
            modelInheritance[className] = parentClass;
          }
          final attributes = <String, String>{};
          final classStart = match.end;
          final classBody = content.substring(classStart);
          final constructorPattern = RegExp(r'(\w+)\s*\(\s*\{([^}]*)\}');
          final constructorMatch = constructorPattern.firstMatch(classBody);
          final parameters = <String>{};
          if (constructorMatch != null) {
            final parameterString = constructorMatch.group(2)!;
            final parameterPattern = RegExp(
              r'(?:required\s+)?this\.(\w+)|super\.(\w+)',
            );
            for (final parameterMatch in parameterPattern.allMatches(
              parameterString,
            )) {
              final parameterName =
                  parameterMatch.group(1) ?? parameterMatch.group(2);
              if (parameterName != null) {
                parameters.add(parameterName);
              }
            }
          }
          constructorParameters[className] = parameters;
          final fieldPattern = RegExp(
            r'final\s+((?:[\w<>]+\s+)?Function(?:\(.*?\))?|[\w<>?,\s]+(?:\(.*?\))?)\s+(\w+);',
            multiLine: true,
          );
          final fieldMatches = fieldPattern.allMatches(classBody);
          for (final fieldMatch in fieldMatches) {
            final type = fieldMatch.group(1)!;
            final name = fieldMatch.group(2)!;
            attributes[name] = type;
            final baseType = WickUtilityScriptHelper.extractBaseType(type);
            if (WickUtilityScriptHelper.isCustomType(baseType)) {
              final typeImport = WickUtilityScriptHelper.findImportForType(
                baseType,
                libraryDirectory,
              );
              if (typeImport != null) {
                additionalImports.add(typeImport);
              }
            }
            final genericMatch = RegExp(r'<(.+)>').firstMatch(type);
            if (genericMatch != null) {
              final genericType = genericMatch.group(1)!;
              final genericTypes = genericType.split(',').map((t) => t.trim());
              String updatedType = type;
              for (final genericType in genericTypes) {
                final cleanType = WickUtilityScriptHelper.extractBaseType(
                  genericType,
                );
                if (WickUtilityScriptHelper.isCustomType(cleanType)) {
                  final typeImport = WickUtilityScriptHelper.findImportForType(
                    cleanType,
                    libraryDirectory,
                  );
                  if (typeImport == null) {
                    updatedType = updatedType.replaceAll(
                      RegExp(r'<\s*' + RegExp.escape(genericType) + r'\s*>'),
                      '<dynamic>',
                    );
                  } else {
                    additionalImports.add(typeImport);
                  }
                }
              }
              if (updatedType != type) {
                attributes[name] = updatedType;
              }
            }
          }
          if (attributes.isNotEmpty) {
            modelsFound[className] = WickModelModelInformation(
              className: className,
              importPath: importPath,
              attributes: attributes,
            );
          }
        }
      }
    }
  });
  final enumsDirectory = Directory('lib/enums/model_attributes');
  if (enumsDirectory.existsSync()) {
    enumsDirectory.listSync().forEach((item) {
      if (item is File && item.path.endsWith('.generated.dart')) {
        item.deleteSync();
      }
    });
  }
  enumsDirectory.createSync(recursive: true);
  modelsFound.forEach((className, info) {
    String cleanClassName = className
        .replaceAll('Wick', '')
        .replaceAll('Model', '');
    final enumName = 'WickEnumModelAttribute$cleanClassName';
    final enumFileName = WickUtilityStringFormatter.toSnakeCase(cleanClassName);
    final enumFilePath =
        'lib/enums/model_attributes/$enumFileName.generated.dart';
    final enumOutput = WickUtilityScriptHelper.addGeneratedFileWarningComment(
      StringBuffer(),
    );
    enumOutput.writeln();
    enumOutput.writeln('/// Attributes and their types for $className.');
    enumOutput.writeln('enum $enumName {');
    final attributeKeys = info.attributes.keys.toList();
    for (int i = 0; i < attributeKeys.length; i++) {
      final attributeName = attributeKeys[i];
      enumOutput.write('  $attributeName');
      if (i < attributeKeys.length - 1) {
        enumOutput.writeln(',');
      } else {
        enumOutput.writeln(';');
      }
    }
    enumOutput.writeln('}');
    final enumFile = File(enumFilePath);
    enumFile.createSync(recursive: true);
    enumFile.writeAsStringSync(enumOutput.toString());
  });
  final output = WickUtilityScriptHelper.addGeneratedFileWarningComment(
    StringBuffer(),
  );
  output.writeln();
  output.writeln("import 'dart:typed_data';");
  output.writeln();
  output.writeln("import 'package:flutter/material.dart';");
  output.writeln("import 'package:wick_apps/utilities/type_converter.dart';");
  final allImports = <String>{
    ...modelsFound.values.map((m) => m.importPath),
    ...additionalImports,
  };
  for (final import in allImports) {
    output.writeln("import 'package:wick_apps/$import';");
  }
  for (final className in modelsFound.keys) {
    String cleanClassName = className
        .replaceAll('Wick', '')
        .replaceAll('Model', '');
    final enumFileName = WickUtilityStringFormatter.toSnakeCase(cleanClassName);
    output.writeln(
      "import 'package:wick_apps/enums/model_attributes/$enumFileName.generated.dart';",
    );
  }
  output.writeln();
  output.writeln('class WickUtilityModelRegistry {');
  output.writeln('  static final Map<Type, Type> attributes = {');
  modelsFound.forEach((className, info) {
    String cleanClassName = className
        .replaceAll('Wick', '')
        .replaceAll('Model', '');
    final enumName = 'WickEnumModelAttribute$cleanClassName';
    output.writeln('    $className: $enumName,');
  });
  output.writeln('  };');
  output.writeln();
  output.writeln(
    '  static final Map<Type, Function(Map<String, dynamic>)> constructors = {',
  );
  modelsFound.forEach((className, info) {
    if (abstractClasses.contains(className)) {
      return;
    }
    final allAttributes = <String, String>{};
    String? currentClass = className;
    final visited = <String>{};
    while (currentClass != null && !visited.contains(currentClass)) {
      visited.add(currentClass);
      final currentModel = modelsFound[currentClass];
      if (currentModel != null) {
        currentModel.attributes.forEach((key, value) {
          allAttributes.putIfAbsent(key, () => value);
        });
      }
      currentClass = modelInheritance[currentClass];
    }
    final classParameters = constructorParameters[className] ?? <String>{};
    final constructorAttributes = <String, String>{};
    for (final entry in allAttributes.entries) {
      if (classParameters.contains(entry.key)) {
        constructorAttributes[entry.key] = entry.value;
      }
    }
    output.writeln('    $className: (attributes) => $className(');
    final entries = constructorAttributes.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      output.write(
        '      ${entry.key}: WickUtilityTypeConverter.convert<${entry
            .value}>(attributes[\'${entry.key}\'])',
      );
      if (i < entries.length - 1) {
        output.writeln(',');
      } else {
        output.writeln();
      }
    }
    output.writeln('    ),');
  });
  output.writeln('  };');
  output.writeln();
  output.writeln(
    '  static final Map<Type, Map<String, Function(dynamic)>> attributeGetters = {',
  );
  modelsFound.forEach((className, information) {
    if (abstractClasses.contains(className)) {
      return;
    }
    final allAttributes = <String, String>{};
    String? currentClass = className;
    final visited = <String>{};
    while (currentClass != null && !visited.contains(currentClass)) {
      visited.add(currentClass);
      final currentModel = modelsFound[currentClass];
      if (currentModel != null) {
        currentModel.attributes.forEach((key, value) {
          allAttributes.putIfAbsent(key, () => value);
        });
      }
      currentClass = modelInheritance[currentClass];
    }
    output.writeln('    $className: {');
    final entries = allAttributes.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      output.write(
        '      \'${entry.key}\': (model) => (model as $className).${entry.key}',
      );
      if (i < entries.length - 1) {
        output.writeln(',');
      } else {
        output.writeln();
      }
    }
    output.writeln('    },');
  });
  output.writeln('  };');
  output.writeln('}');
  const outputFileLocation = 'lib/utilities/model_registry.generated.dart';
  final outputFile = File(outputFileLocation);
  outputFile.createSync(recursive: true);
  outputFile.writeAsStringSync(output.toString());
}
