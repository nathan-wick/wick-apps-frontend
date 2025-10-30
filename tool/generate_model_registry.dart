import 'dart:io';

import 'package:wick_apps/models/model_information.dart';
import 'package:wick_apps/utilities/script_helper.dart';

void main() {
  final Directory libraryDirectory = Directory('lib');
  final List<WickModelModelInformation> models =
      WickUtilityScriptHelper.getModelInformation(libraryDirectory);
  final Directory enumsModelAttributesDirectory = Directory(
    'lib/enums/model_attributes',
  );
  WickUtilityScriptHelper.deleteGeneratedFiles(enumsModelAttributesDirectory);
  WickUtilityScriptHelper.generateModelAttributesEnums(
    enumsModelAttributesDirectory,
    models,
  );
  WickUtilityScriptHelper.generateModelRegistry(libraryDirectory, models);
}
