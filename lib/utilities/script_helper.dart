import 'dart:io';

import 'package:collection/collection.dart';
import 'package:wick_apps/utilities/string_formatter.dart';

import '../models/model_information.dart';

class WickUtilityScriptHelper {
  /// Adds a warning comment to the output.
  static StringBuffer addGeneratedFileWarningComment(StringBuffer output) {
    output.writeln('// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY');
    output.writeln('// Generate this file by running `dart run :generate`');
    return output;
  }

  /// Removes nullable markers and generic type parameters.
  static String extractBaseType(String type) {
    return type
        .replaceAll('?', '')
        .replaceAll(RegExp(r'<.*>'), '')
        .replaceAll(RegExp(r'\(.*\)'), '')
        .replaceAll(RegExp(r'.* '), '')
        .trim();
  }

  /// Returns true if the type is Not a primitive or common Flutter/Dart type.
  static bool isCustomType(String type) {
    const builtInTypes = {
      'String',
      'int',
      'double',
      'bool',
      'num',
      'List',
      'Map',
      'Set',
      'DateTime',
      'Duration',
      'Object',
      'dynamic',
      'void',
      'Null',
      'Widget',
      'BuildContext',
      'Color',
      'Key',
    };
    return !builtInTypes.contains(type);
  }

  /// Get the import path for a type.
  static String? findImportForType(String typeName, Directory directory) {
    final files = directory.listSync(recursive: true);
    for (final item in files) {
      if (item is File && item.path.endsWith('.dart')) {
        final content = item.readAsStringSync();
        final enumPattern = RegExp(r'\benum\s+' + typeName + r'\b');
        final classPattern = RegExp(r'\bclass\s+' + typeName + r'\b');
        if (enumPattern.hasMatch(content) || classPattern.hasMatch(content)) {
          return item.path.replaceAll('${directory.path}/', '');
        }
      }
    }
    return null;
  }

  /// Get information about all models in a directory.
  static List<WickModelModelInformation> getModelInformation(
    Directory directory,
  ) {
    List<WickModelModelInformation> models = [];
    directory.listSync(recursive: true).forEach((file) {
      if (file is File && file.path.endsWith('.dart')) {
        final String fileContent = file.readAsStringSync();
        final RegExp classPattern = RegExp(
          r'(?:abstract\s+)?class\s+(?!_)(\w+)(?:\s+extends\s+(\w+))?',
        );
        final Iterable<RegExpMatch> classMatches = classPattern.allMatches(
          fileContent,
        );
        if (classMatches.isNotEmpty) {
          final String fileImportPath = file.path.replaceAll(
            '${directory.path}/',
            '',
          );
          for (final RegExpMatch classMatch in classMatches) {
            final String className = classMatch.group(1)!;
            final String? parentClassName = classMatch.group(2);
            final String classDeclaration = fileContent.substring(
              classMatch.start,
              classMatch.end,
            );
            final bool isAbstract = classDeclaration.startsWith('abstract');
            final int classStart = classMatch.end;
            final String classBody = fileContent.substring(classStart);
            final RegExp constructorPattern = RegExp(
              r'(\w+)\s*\(\s*\{([^}]*)\}',
            );
            final RegExpMatch? constructorMatch = constructorPattern.firstMatch(
              classBody,
            );
            final Set<String> constructorParameters = {};
            if (constructorMatch != null) {
              final String constructorParameter = constructorMatch.group(2)!;
              final RegExp constructorParameterPattern = RegExp(
                r'(?:required\s+)?this\.(\w+)|super\.(\w+)',
              );
              for (final RegExpMatch constructorParameterMatch
                  in constructorParameterPattern.allMatches(
                    constructorParameter,
                  )) {
                final constructorParameterName =
                    constructorParameterMatch.group(1) ??
                    constructorParameterMatch.group(2);
                if (constructorParameterName != null) {
                  constructorParameters.add(constructorParameterName);
                }
              }
            }
            final RegExp attributePattern = RegExp(
              r'final\s+((?:[\w<>]+\s+)?Function(?:\(.*?\))?|[\w<>?,\s]+(?:\(.*?\))?)\s+(\w+);',
              multiLine: true,
            );
            final Iterable<RegExpMatch> attributeMatches = attributePattern
                .allMatches(classBody);
            final Map<String, String> attributes = {};
            final Set<String> attributeTypeDependencyImportPaths = {};
            for (final RegExpMatch attributeMatch in attributeMatches) {
              final String attributeType = attributeMatch.group(1)!;
              final String attributeName = attributeMatch.group(2)!;
              attributes[attributeName] = attributeType;
              final String attributeBaseType = extractBaseType(attributeType);
              if (isCustomType(attributeBaseType)) {
                final typeImport = findImportForType(
                  attributeBaseType,
                  directory,
                );
                if (typeImport != null) {
                  attributeTypeDependencyImportPaths.add(typeImport);
                }
              }
              final RegExpMatch? genericMatch = RegExp(
                r'<(.+)>',
              ).firstMatch(attributeType);
              if (genericMatch != null) {
                final String genericType = genericMatch.group(1)!;
                final Iterable<String> genericTypes = genericType
                    .split(',')
                    .map((t) => t.trim());
                String updatedAttributeType = attributeType;
                for (final String genericType in genericTypes) {
                  final String cleanType =
                      WickUtilityScriptHelper.extractBaseType(genericType);
                  if (WickUtilityScriptHelper.isCustomType(cleanType)) {
                    final String? typeImport =
                        WickUtilityScriptHelper.findImportForType(
                          cleanType,
                          directory,
                        );
                    if (typeImport == null) {
                      updatedAttributeType = updatedAttributeType.replaceAll(
                        RegExp(r'<\s*' + RegExp.escape(genericType) + r'\s*>'),
                        '<dynamic>',
                      );
                    } else {
                      attributeTypeDependencyImportPaths.add(typeImport);
                    }
                  }
                }
                if (updatedAttributeType != attributeType) {
                  attributes[attributeName] = updatedAttributeType;
                }
              }
            }
            if (attributes.isNotEmpty &&
                className != "WickUtilityScriptHelper") {
              models.add(
                WickModelModelInformation(
                  modelName: className,
                  importPath: fileImportPath,
                  attributes: attributes,
                  isAbstract: isAbstract,
                  parentModelName:
                      parentClassName != 'Object' ? parentClassName : null,
                  attributeTypeDependencyImportPaths:
                      attributeTypeDependencyImportPaths,
                  constructorParameters: constructorParameters,
                ),
              );
            }
          }
        }
      }
    });
    for (final WickModelModelInformation model in models) {
      String currentModelName = model.modelName;
      final Set<String> visitedModelNames = {};
      while (!visitedModelNames.contains(currentModelName)) {
        visitedModelNames.add(currentModelName);
        final WickModelModelInformation? parentModel = models.firstWhereOrNull(
          (modelB) => modelB.modelName == model.parentModelName,
        );
        if (parentModel != null) {
          parentModel.attributes.forEach((key, value) {
            model.attributes.putIfAbsent(key, () => value);
          });
          currentModelName = parentModel.modelName;
        }
      }
    }
    return models;
  }

  /// Deletes all generated files in a directory.
  static void deleteGeneratedFiles(Directory directory) {
    if (directory.existsSync()) {
      directory.listSync().forEach((item) {
        if (item is File && item.path.endsWith('.generated.dart')) {
          item.deleteSync();
        }
      });
    }
  }

  /// Generates model attributes enums to a directory.
  static void generateModelAttributesEnums(
    Directory directory,
    List<WickModelModelInformation> models,
  ) {
    directory.createSync(recursive: true);
    for (WickModelModelInformation model in models) {
      final String strippedModelName = model.modelName
          .replaceAll('WickModel', '')
          .replaceAll('Wick', '');
      final String enumName = 'WickEnumModelAttribute$strippedModelName';
      final String enumFileName = WickUtilityStringFormatter.toSnakeCase(
        strippedModelName,
      );
      final String enumFilePath =
          '${directory.path}/$enumFileName.generated.dart';
      final StringBuffer enumOutput =
          WickUtilityScriptHelper.addGeneratedFileWarningComment(
            StringBuffer(),
          );
      enumOutput.writeln();
      enumOutput.writeln("import 'package:flutter/foundation.dart';");
      enumOutput.writeln("import 'package:flutter/material.dart';");
      enumOutput.writeln(
        "import 'package:wick_apps/enums/model_attributes/base.dart';",
      );
      final Set<String> customTypeImports = {};
      for (final attributeType in model.attributes.values) {
        final String baseType = extractBaseType(attributeType);
        if (isCustomType(baseType)) {
          final String? typeImport = findImportForType(
            baseType,
            Directory('lib'),
          );
          if (typeImport != null) {
            customTypeImports.add("import 'package:wick_apps/$typeImport';");
          }
        }
      }
      for (final import in customTypeImports) {
        enumOutput.writeln(import);
      }
      enumOutput.writeln();
      enumOutput.writeln(
        '/// Attributes and their types for ${model.modelName}.',
      );
      enumOutput.writeln(
        'enum $enumName implements WickEnumModelAttributeBase {',
      );
      final attributeEntries = model.attributes.entries.toList();
      for (
        int attributeIndex = 0;
        attributeIndex < attributeEntries.length;
        attributeIndex++
      ) {
        final attributeEntry = attributeEntries[attributeIndex];
        enumOutput.write(
          '  ${attributeEntry.key}(${extractBaseType(attributeEntry.value)})',
        );
        if (attributeIndex < attributeEntries.length - 1) {
          enumOutput.writeln(',');
        } else {
          enumOutput.writeln(';');
        }
      }
      enumOutput.writeln();
      enumOutput.writeln('  const $enumName(this.attributeType);');
      enumOutput.writeln();
      enumOutput.writeln('  @override');
      enumOutput.writeln('  final Type attributeType;');
      enumOutput.writeln('}');
      final enumFile = File(enumFilePath);
      enumFile.createSync(recursive: true);
      enumFile.writeAsStringSync(enumOutput.toString());
    }
  }

  /// Generates model registry to a directory.
  static void generateModelRegistry(
    Directory directory,
    List<WickModelModelInformation> models,
  ) {
    final output = WickUtilityScriptHelper.addGeneratedFileWarningComment(
      StringBuffer(),
    );
    output.writeln();
    output.writeln("import 'package:wick_apps/utilities/type_converter.dart';");
    for (final WickModelModelInformation model in models) {
      output.writeln("import 'package:wick_apps/${model.importPath}';");
      String strippedModelName = model.modelName
          .replaceAll('WickModel', '')
          .replaceAll('Wick', '');
      final String enumFileName = WickUtilityStringFormatter.toSnakeCase(
        strippedModelName,
      );
      // TODO Use relative path
      output.writeln(
        "import 'package:wick_apps/enums/model_attributes/$enumFileName.generated.dart';",
      );
    }
    output.writeln();
    output.writeln('class WickUtilityModelRegistry {');
    output.writeln('  static final Map<Type, Type> attributes = {');
    for (final WickModelModelInformation model in models) {
      String strippedModelName = model.modelName
          .replaceAll('WickModel', '')
          .replaceAll('Wick', '');
      final String enumModelAttributesName =
          'WickEnumModelAttribute$strippedModelName';
      output.writeln('    ${model.modelName}: $enumModelAttributesName,');
    }
    output.writeln('  };');
    output.writeln();
    output.writeln(
      '  static final Map<Type, Function(Map<String, dynamic>)> constructors = {',
    );
    for (final WickModelModelInformation model in models.where(
      (model) => !model.isAbstract,
    )) {
      output.writeln(
        '    ${model.modelName}: (attributes) => ${model.modelName}(',
      );
      final List<String> constructorAttributes =
          model.attributes.entries
              .where(
                (attribute) =>
                    model.constructorParameters.contains(attribute.key),
              )
              .map((attribute) => attribute.key)
              .toList();
      for (
        int constructorAttributeIndex = 0;
        constructorAttributeIndex < constructorAttributes.length;
        constructorAttributeIndex++
      ) {
        final String constructorAttribute =
            constructorAttributes[constructorAttributeIndex];
        output.write(
          '      $constructorAttribute: WickUtilityTypeConverter.convert(attributes[\'$constructorAttribute\'])',
        );
        if (constructorAttributeIndex < constructorAttributes.length - 1) {
          output.writeln(',');
        } else {
          output.writeln();
        }
      }
      output.writeln('    ),');
    }
    output.writeln('  };');
    output.writeln();
    output.writeln(
      '  static final Map<Type, Map<String, Function(dynamic)>> attributeGetters = {',
    );
    for (final WickModelModelInformation model in models.where(
      (model) => !model.isAbstract,
    )) {
      output.writeln('    ${model.modelName}: {');
      final List<String> attributes = model.attributes.keys.toList();
      for (
        int attributeIndex = 0;
        attributeIndex < attributes.length;
        attributeIndex++
      ) {
        final String attribute = attributes[attributeIndex];
        output.write('      \'$attribute\': (model) => model.$attribute');
        if (attributeIndex < attributes.length - 1) {
          output.writeln(',');
        } else {
          output.writeln();
        }
      }
      output.writeln('    },');
    }
    output.writeln('  };');
    output.writeln('}');
    // TODO Use relative path
    const outputFileLocation = 'lib/utilities/model_registry.generated.dart';
    final outputFile = File(outputFileLocation);
    outputFile.createSync(recursive: true);
    outputFile.writeAsStringSync(output.toString());
  }
}
