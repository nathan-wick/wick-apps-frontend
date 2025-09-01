import 'package:flutter/material.dart';

enum WickBrightness {
  system(ThemeMode.system),
  light(ThemeMode.light),
  dark(ThemeMode.dark);

  final ThemeMode value;

  const WickBrightness(this.value);
}
