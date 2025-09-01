class WickUtilityRegularExpression {
  static RegExp email = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  static RegExp letters = RegExp(r'^[a-zA-Z]+$');
  static RegExp date = RegExp(r'^\d{4}/\d{2}/\d{2}$|^\d{2}/\d{2}/\d{4}$');
}
