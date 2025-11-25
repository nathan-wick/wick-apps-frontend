class WickUtilityStringFormatter {
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

  /// Capitalizes the first letter of each word in a string.
  /// For example, 'my favorite string' becomes 'My Favorite String'.
  static String titleCase(String value, [bool addSpace = true]) {
    if (addSpace) value = replaceSpaces(value, ' ');
    return value
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Formats a string value to camelCase.
  /// For example, 'My FavoriteString' becomes 'myFavoriteString'.
  static String toCamelCase(String value) {
    final words = replaceSpaces(value, ' ').split(' ');
    if (words.isEmpty) return value;
    return words.first.toLowerCase() +
        words
            .skip(1)
            .map((word) {
              if (word.isEmpty) return word;
              return word[0].toUpperCase() + word.substring(1).toLowerCase();
            })
            .join('');
  }
}
