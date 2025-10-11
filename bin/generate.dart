import 'dart:io';

Future<void> main() async {
  await Process.run('dart', ['run', 'tool/generate_enum_registry.dart']);
  await Process.run('dart', ['run', 'tool/generate_library_file.dart']);
}
