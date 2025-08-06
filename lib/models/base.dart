abstract class BaseModel<T> {
  Map<String, dynamic> get attributes;

  T newInstance(Map<String, dynamic> newAttributes);

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError('fromJson must be implemented');

  Map<String, dynamic> toJson() {
    return attributes.map((key, value) => MapEntry(key, dynamicToJson(value)));
  }

  Map<String, String> toStringMap() {
    return attributes.map(
      (key, value) => MapEntry(key, dynamicToString(value)),
    );
  }

  T copyWith(Map<String, dynamic> updatedAttributes) {
    final newAttributes = {...attributes, ...updatedAttributes};
    return newInstance(newAttributes);
  }
}
