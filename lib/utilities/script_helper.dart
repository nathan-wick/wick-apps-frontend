import 'dart:io';

class WickUtilityScriptHelper {
  /// Adds a warning comment to the output.
  static StringBuffer addGeneratedFileWarningComment(StringBuffer output) {
    output.writeln('// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY');
    output.writeln('// Generate this file by running `dart run :generate`');
    return output;
  }

  /// Removes nullable markers and generic type parameters.
  static String extractBaseType(String type) {
    return type.replaceAll('?', '').replaceAll(RegExp(r'<.*>'), '').trim();
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
          return item.path.replaceAll('lib/', '');
        }
      }
    }
    return null;
  }
}
