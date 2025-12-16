import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/enums/model_attributes/preferences.generated.dart';
import 'package:wick_apps/models/form_inputs/attribute.dart';
import 'package:wick_apps/providers/preferences.dart';
import 'package:wick_apps/widgets/forms/stack.dart';

import '../../controllers/preferences.dart';
import '../../models/preferences.dart';
import '../loading_indicator.dart';

class WickWidgetTileContentThemePreferences extends StatelessWidget {
  const WickWidgetTileContentThemePreferences({super.key});

  @override
  Widget build(BuildContext context) {
    final WickModelPreferences? preferences =
        Provider.of<WickProviderPreferences>(context).value;
    if (preferences == null) {
      return const WickWidgetLoadingIndicator();
    }
    return WickWidgetFormStack(
      name: 'Theme Preferences',
      inputs: [
        WickModelFormInputAttribute(
          attribute: WickEnumModelAttributePreferences.brightness,
        ),
        WickModelFormInputAttribute(
          attribute: WickEnumModelAttributePreferences.primaryColor,
        ),
      ],
      controller: WickControllerPreferences(),
      primaryKey: preferences.userId,
      autoSubmit: true,
      autoFocus: false,
    );
  }
}
