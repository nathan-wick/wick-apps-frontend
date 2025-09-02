import 'package:flutter/cupertino.dart';

enum WickEnumKeyboardType {
  text(TextInputType.text),
  name(TextInputType.name),
  number(TextInputType.number),
  date(TextInputType.number),
  email(TextInputType.emailAddress),
  phone(TextInputType.phone),
  address(TextInputType.streetAddress),
  website(TextInputType.url),
  multipleLines(TextInputType.multiline);

  const WickEnumKeyboardType(this.value);

  final TextInputType value;
}
