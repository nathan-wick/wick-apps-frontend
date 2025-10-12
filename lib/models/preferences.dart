import '../enums/brightness.dart';
import '../enums/color.dart';
import '../enums/date_format.dart';
import '../utilities/type_converter.dart';
import 'base.dart';

class WickModelPreferences extends WickModelBase<WickModelPreferences> {
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
         'dateFormat': dateFormat,
         'primaryColor': primaryColor,
       });

  factory WickModelPreferences.fromJson(Map<String, dynamic> json) {
    return WickModelPreferences(
      userId: WickUtilityTypeConverter.toInt(json['userId']) ?? 0,
      brightness:
          WickUtilityTypeConverter.toEnum<WickEnumBrightness>(
            json['brightness'],
          ) ??
          WickEnumBrightness.system,
      dateFormat:
          WickUtilityTypeConverter.toEnum<WickEnumDateFormat>(
            json['dateFormat'],
          ) ??
          WickEnumDateFormat.yearMonthDay,
      primaryColor:
          WickUtilityTypeConverter.toEnum<WickEnumColor>(
            json['primaryColor'],
          ) ??
          WickEnumColor.blue,
    );
  }

  @override
  WickModelPreferences newInstance(Map<String, dynamic> newAttributes) =>
      WickModelPreferences.fromJson(newAttributes);
}
