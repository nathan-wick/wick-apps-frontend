import '../enums/brightness.dart';
import '../enums/color.dart';
import '../enums/date_format.dart';
import '../utilities/type_converter.dart';
import 'base.dart';

class PreferencesModel extends BaseModel {
  final int userId;
  final WickBrightness brightness;
  final DateFormat dateFormat;
  final WickColor primaryColor;

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
      brightness:
          TypeConverter.toBrightness(json['brightness']) ??
          WickBrightness.system,
      dateFormat:
          TypeConverter.toDateFormat(json['dateFormat']) ??
          DateFormat.yearMonthDay,
      primaryColor:
          TypeConverter.toColor(json['primaryColor']) ?? WickColor.blue,
    );
  }
}
