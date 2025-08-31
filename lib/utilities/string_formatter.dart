class StringFormatter {
  /// Formats a string value to kebab-case.
  /// For example, 'My FavoriteString' becomes 'my-favorite-string'.
  static String toKebabCase(String value) {
    return replaceSpaces(value, '-').toLowerCase();
  }

  /// Formats a string value to snake_case.
  /// For example, 'My FavoriteString' becomes 'my_favorite_string'.
  static String toSnakeCase(String value) {
    return replaceSpaces(value, '_').toLowerCase();
  }

  /// Replaces the spaces in a string.
  /// For example, if the space replacement is an underscore, then 'My FavoriteString' becomes 'My_Favorite_String'.
  static String replaceSpaces(String value, String spaceReplacement) {
    return value
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (match) => '${match.group(1)}$spaceReplacement${match.group(2)}',
        )
        .replaceAll(RegExp(r'\s+'), spaceReplacement);
  }
}
