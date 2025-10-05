import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/controllers/user.dart';
import 'package:wick_apps/models/form_inputs/field.dart';
import 'package:wick_apps/providers/preferences.dart';
import 'package:wick_apps/widgets/forms/stack.dart';

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
        WickModelFormInputField(fieldName: 'brightness'),
        WickModelFormInputField(fieldName: 'primaryColor'),
      ],
      controller: WickControllerUser(),
      primaryKey: preferences.userId,
      autoSubmit: true,
      autoFocus: false,
    );
  }
}
