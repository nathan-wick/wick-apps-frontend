import '../utilities/type_converter.dart';
import 'base.dart';

class PreferencesModel extends BaseModel {
  final int userId;
  final String brightness;
  final String dateFormat;
  final String primaryColor;

  PreferencesModel({
    required this.userId,
    required this.brightness,
    required this.dateFormat,
    required this.primaryColor,
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
