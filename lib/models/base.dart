import '../utilities/type_converter.dart';

abstract class WickModelBase {
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

  /// Converts the model to a map of strings.
  Map<String, String?> toStringMap() {
    return attributes.map(
      (key, value) => MapEntry(key, WickUtilityTypeConverter.describe(value)),
    );
  }
}
