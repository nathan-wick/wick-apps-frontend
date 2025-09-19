import '../utilities/type_converter.dart';
import 'base.dart';

class WickModelWickProviderNavigation
    extends WickModelBase<WickModelWickProviderNavigation> {
  final String lastRoute;

  WickModelWickProviderNavigation({required this.lastRoute})
    : super({'lastRoute': lastRoute});

  factory WickModelWickProviderNavigation.fromJson(Map<String, dynamic> json) {
    return WickModelWickProviderNavigation(
      lastRoute: WickUtilityTypeConverter.describe(json['lastRoute']) ?? '',
    );
  }

  @override
  WickModelWickProviderNavigation newInstance(
    Map<String, dynamic> newAttributes,
  ) => WickModelWickProviderNavigation.fromJson(newAttributes);
}
