import 'dart:io';

import 'package:wick_apps/utilities/script_helper.dart';

void main() {
  final libraryDirectory = Directory('lib');
  final enumsFound = <String, List<String>>{};
  libraryDirectory.listSync(recursive: true).forEach((item) {
    if (item is File && item.path.endsWith('.dart')) {
      final content = item.readAsStringSync();
      final enumPattern = RegExp(r'enum\s+(\w+)\s*{');
      final matches = enumPattern.allMatches(content);
      if (matches.isNotEmpty) {
        final importPath = item.path.replaceAll('lib/', '');
        enumsFound[importPath] = matches.map((m) => m.group(1)!).toList();
      }
    }
  });
  final output = WickUtilityScriptHelper.addGeneratedFileWarningComment(
    StringBuffer(),
  );
  output.writeln();
  for (String path in enumsFound.keys) {
    output.writeln("import 'package:wick_apps/$path';");
  }
  output.writeln();
  output.writeln('class WickUtilityEnumRegistry {');
  output.writeln('  static final Map<Type, List<Enum>> registry = {');
  enumsFound.forEach((path, enumNames) {
    for (final enumName in enumNames) {
      output.writeln('    $enumName: $enumName.values,');
    }
  });
  output.writeln('  };');
  output.writeln('}');
  const outputFileLocation = 'lib/utilities/enum_registry.generated.dart';
  final outputFile = File(outputFileLocation);
  outputFile.createSync(recursive: true);
  outputFile.writeAsStringSync(output.toString());
}
