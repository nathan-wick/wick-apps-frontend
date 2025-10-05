import 'dart:io';

import 'package:wick_apps/utilities/script_helper.dart';

Future<void> main() async {
  final ProcessResult result = await Process.run('dart', [
    'run',
    'tool/generate_enum_registry.dart',
  ]);
  WickUtilityScriptHelper.handleExit(result);
}
