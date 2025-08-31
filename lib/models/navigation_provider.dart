import '../utilities/type_converter.dart';
import 'base.dart';

class NavigationProviderModel extends BaseModel {
  final String lastRoute;

  NavigationProviderModel({required this.lastRoute})
    : super({'lastRoute': lastRoute});

  factory NavigationProviderModel.fromJson(Map<String, dynamic> json) {
    return NavigationProviderModel(
      lastRoute: TypeConverter.describe(json['lastRoute']) ?? '',
    );
  }
}
