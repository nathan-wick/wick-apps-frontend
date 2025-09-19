import '../enums/date_format.dart';
import '../utilities/type_converter.dart';

abstract class WickModelBase<T> {
  /// The raw attribute values of this model (ideally passed to the constructor).
  final Map<String, dynamic> attributes;

  /// Protected generative constructor so subclasses can initialize [attributes]
  WickModelBase(this.attributes);

  /// Subclasses must implement this to build themselves from raw JSON.
  factory WickModelBase.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError('fromJson must be implemented');

  /// Converts the model to a JSON-safe map.
  Map<String, dynamic> toJson() {
    return attributes.map(
      (key, value) => MapEntry(key, WickUtilityTypeConverter.toJson(value)),
    );
  }

  /// Subclasses must implement this to build themselves from new attributes.
  T newInstance(Map<String, dynamic> newAttributes) =>
      throw UnimplementedError('newInstance must be implemented');

  /// Converts the model to a map of strings.
  Map<String, String?> toStringMap([WickEnumDateFormat? dateFormat]) {
    return attributes.map(
      (key, value) =>
          MapEntry(key, WickUtilityTypeConverter.describe(value, dateFormat)),
    );
  }

  /// Returns a copy of this model with the given updated attributes.
  T copyWith(Map<String, dynamic> updatedAttributes) {
    final Map<String, dynamic> newAttributes = {
      ...attributes,
      ...updatedAttributes,
    };
    return newInstance(newAttributes);
  }
}
