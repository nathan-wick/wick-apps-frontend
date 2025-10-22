import '../enums/brightness.dart';
import '../enums/color.dart';
import '../enums/date_format.dart';
import 'annotations/primary_key.dart';

class WickModelPreferences {
  @WickModelAnnotationPrimaryKey()
  final int userId;
  final WickEnumBrightness brightness;
  final WickEnumDateFormat dateFormat;
  final WickEnumColor primaryColor;

  WickModelPreferences({
    required this.userId,
    required this.brightness,
    required this.dateFormat,
    required this.primaryColor,
  });
}
