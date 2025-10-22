import 'enum_helper.dart';
import 'model_registry.generated.dart';

class WickUtilityModelHelper {
  /// Returns the values of an enum as a list of dropdown options.
  static List<String> getAttributesNames(Type type) {
    final attributes = WickUtilityModelRegistry.attributes[type];
    return attributes == null ? [] : WickUtilityEnumHelper.getValuesNames(type);
  }

  /// Returns the value of an object's attribute given the attribute name
  static dynamic getAttributeValue(Object? object, String attributeName) {
    if (object == null) return null;
    final objectType = object.runtimeType;
    final getter =
        WickUtilityModelRegistry.attributeGetters[objectType]?[attributeName];
    if (getter == null) return null;
    return getter(object);
  }

  /// Returns the values of an object's attributes
  static Map<String, dynamic> getAttributeValues(Object? object) {
    if (object == null) return {};
    final Type objectType = object.runtimeType;
    final List<String> attributesNames = getAttributesNames(objectType);
    return {
      for (String attributeName in attributesNames)
        attributeName: getAttributeValue(object, attributeName),
    };
  }
}
