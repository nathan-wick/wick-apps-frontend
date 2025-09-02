import 'package:flutter/material.dart';

enum WickEnumBrightness {
  system(ThemeMode.system),
  light(ThemeMode.light),
  dark(ThemeMode.dark);

  final ThemeMode value;

  const WickEnumBrightness(this.value);
}
