import 'dart:math';

import 'package:flutter/material.dart';

class WickUtilityColorEngine {
  static Color calculateAccessibleColor(
    Color variableColor,
    Color constantColor, {
    double minimumContrastRatio = 7,
    double step = 0.1,
  }) {
    double currentContrastRatio = calculateContrastRatio(
      variableColor,
      constantColor,
    );
    if (currentContrastRatio >= minimumContrastRatio) {
      return variableColor;
    }
    HSLColor hslColor = HSLColor.fromColor(variableColor);
    bool shouldLighten = constantColor.computeLuminance() < 0.5;
    while (currentContrastRatio < minimumContrastRatio) {
      if (shouldLighten) {
        hslColor = hslColor.withLightness(min(1.0, hslColor.lightness + step));
      } else {
        hslColor = hslColor.withLightness(max(0.0, hslColor.lightness - step));
      }
      Color adjustedColor = hslColor.toColor();
      currentContrastRatio = calculateContrastRatio(
        adjustedColor,
        constantColor,
      );
      if (hslColor.lightness >= 1.0 || hslColor.lightness <= 0.0) {
        break;
      }
    }
    return hslColor.toColor();
  }

  static double calculateContrastRatio(Color color1, Color color2) {
    double luminance1 = calculateLuminance(color1);
    double luminance2 = calculateLuminance(color2);
    double brightest = max(luminance1, luminance2);
    double darkest = min(luminance1, luminance2);
    return (brightest + 0.05) / (darkest + 0.05);
  }

  static double calculateLuminance(Color color) {
    List<num> rgb =
        [color.r, color.g, color.b].map((component) {
          if (component <= 0.03928) {
            return component / 12.92;
          }
          return pow((component + 0.055) / 1.055, 2.4);
        }).toList();
    return 0.2126 * rgb[0] + 0.7152 * rgb[1] + 0.0722 * rgb[2];
  }
}
