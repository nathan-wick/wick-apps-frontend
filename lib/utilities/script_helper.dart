import 'dart:io';

class WickUtilityScriptHelper {
  static void handleExit(ProcessResult result) {
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  static StringBuffer addGeneratedFileWarningComment(StringBuffer output) {
    output.writeln('// THIS FILE IS AUTO-GENERATED - DO NOT EDIT MANUALLY');
    output.writeln('// Generate this file by running `dart run :generate`');
    return output;
  }
}
