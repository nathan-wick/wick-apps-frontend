import '../utilities/type_converter.dart';
import 'base.dart';

class PreferencesModel extends BaseModel {
  PreferencesModel({
    required int userId,
    required String brightness,
    required String dateFormat,
    required String primaryColor,
  }) : super({
         'userId': userId,
         'brightness': brightness,
         'dateFormat': dateFormat,
         'primaryColor': primaryColor,
       });

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    return PreferencesModel(
      userId: TypeConverter.toInt(json['userId']) ?? 0,
      brightness: TypeConverter.describe(json['brightness']) ?? '',
      dateFormat: TypeConverter.describe(json['dateFormat']) ?? '',
      primaryColor: TypeConverter.describe(json['primaryColor']) ?? '',
    );
  }
}
