import '../enums/brightness.dart';
import '../enums/color.dart';
import '../enums/date_format.dart';
import '../utilities/type_converter.dart';
import 'base.dart';

class WickModelPreferences extends WickModelBase {
  final int userId;
  final WickEnumBrightness brightness;
  final WickEnumDateFormat dateFormat;
  final WickEnumColor primaryColor;

  WickModelPreferences({
    required this.userId,
    required this.brightness,
    required this.dateFormat,
    required this.primaryColor,
  }) : super({
         'userId': userId,
         'brightness': brightness,
         'WickEnumDateFormat': WickEnumDateFormat,
         'primaryColor': primaryColor,
       });

  factory WickModelPreferences.fromJson(Map<String, dynamic> json) {
    return WickModelPreferences(
      userId: WickUtilityTypeConverter.toInt(json['userId']) ?? 0,
      brightness:
          WickUtilityTypeConverter.toBrightness(json['brightness']) ??
          WickEnumBrightness.system,
      dateFormat:
          WickUtilityTypeConverter.toWickEnumDateFormat(
            json['WickEnumDateFormat'],
          ) ??
          WickEnumDateFormat.yearMonthDay,
      primaryColor:
          WickUtilityTypeConverter.toColor(json['primaryColor']) ??
          WickEnumColor.blue,
    );
  }
}
