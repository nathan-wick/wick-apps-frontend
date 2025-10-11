import 'dart:io';

import 'package:wick_apps/utilities/script_helper.dart';

void main() {
  final libraryDirectory = Directory('lib');
  final exportsByFolder = <String, List<String>>{};
  for (FileSystemEntity entity in libraryDirectory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final relativePath = entity.path.replaceFirst('lib/', '');
      final folder =
          relativePath.contains('/') ? relativePath.split('/').first : 'root';
      exportsByFolder.putIfAbsent(folder, () => []).add(relativePath);
    }
  }
  for (String key in exportsByFolder.keys) {
    exportsByFolder[key]!.sort();
  }
  final output = WickUtilityScriptHelper.addGeneratedFileWarningComment(
    StringBuffer(),
  );
  output.writeln('library;\n');
  for (String folder in exportsByFolder.keys.toList()..sort()) {
    final files = exportsByFolder[folder]!;
    output.writeln('// ${folder[0].toUpperCase()}${folder.substring(1)}');
    for (String file in files) {
      output.writeln("export '$file';");
    }
  }
  const outputPath = 'lib/wick_apps.generated.dart';
  final outputFile = File(outputPath);
  outputFile.createSync(recursive: true);
  outputFile.writeAsStringSync(output.toString());
}
