import 'model_registry.generated.dart';

class WickUtilityModelHelper {
  /// Returns true if an model type is registered.
  static bool isRegistered(Type type) {
    return WickUtilityModelRegistry.constructors.containsKey(type);
  }

  /// Returns the values of an enum as a list of dropdown options.
  static Set<String>? getAttributesNames(Type type) {
    return WickUtilityModelRegistry.attributeGetters[type]?.keys.toSet();
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

  /// Returns the type of an object's attribute given the attribute name
  static Type getAttributeType<T>(String attributeName) {
    final T? defaultObject = createInstance<T>({});
    return getAttributeValue(defaultObject, attributeName).runtimeType;
  }

  /// Returns the values of an object's attributes
  static Map<String, dynamic> getAttributeValues(Object? object) {
    if (object == null) return {};
    final Type objectType = object.runtimeType;
    final Set<String>? attributesNames = getAttributesNames(objectType);
    if (attributesNames == null) return {};
    return {
      for (String attributeName in attributesNames)
        attributeName: getAttributeValue(object, attributeName),
    };
  }

  /// Creates an instance of a model class from a map of attributes.
  static T? createInstance<T>(Map<String, dynamic> attributes) {
    final constructor = WickUtilityModelRegistry.constructors[T];
    if (constructor == null) return null;
    final Set<String>? expectedAttributes = getAttributesNames(T);
    if (expectedAttributes == null) return null;
    final Map<String, dynamic> filteredAttributes =
        Map<String, dynamic>.fromEntries(
          attributes.entries.where(
            (entry) => expectedAttributes.contains(entry.key),
          ),
        );
    return constructor(filteredAttributes) as T;
  }

  /// Returns the primary key attribute name for a model.
  static String? findPrimaryKeyAttribute<T>() {
    return WickUtilityModelRegistry.primaryKeyAttributes[T];
  }
}
