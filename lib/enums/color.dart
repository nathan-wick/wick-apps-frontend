import 'package:flutter/material.dart';

enum WickEnumColor {
  red(Colors.red),
  orange(Colors.orange),
  yellow(Colors.yellow),
  lime(Colors.lime),
  green(Colors.green),
  teal(Colors.teal),
  cyan(Colors.cyan),
  blue(Colors.blue),
  indigo(Colors.indigo),
  purple(Colors.purple),
  pink(Colors.pink),
  brown(Colors.brown),
  black(Colors.black),
  grey(Colors.grey),
  white(Colors.white);

  final Color value;

  const WickEnumColor(this.value);
}
