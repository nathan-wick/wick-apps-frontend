import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/controllers/user.dart';
import 'package:wick_apps/models/form_inputs/attribute.dart';
import 'package:wick_apps/providers/preferences.dart';
import 'package:wick_apps/widgets/forms/stack.dart';

import '../../enums/model_attributes/preferences.generated.dart';
import '../../models/preferences.dart';
import '../loading_indicator.dart';

class WickWidgetTileContentTimePreferences extends StatelessWidget {
  const WickWidgetTileContentTimePreferences({super.key});

  @override
  Widget build(BuildContext context) {
    final WickModelPreferences? preferences =
        Provider.of<WickProviderPreferences>(context).value;
    if (preferences == null) {
      return const WickWidgetLoadingIndicator();
    }
    return WickWidgetFormStack(
      name: 'Time Preferences',
      inputs: [
        WickModelFormInputAttribute(
          attribute: WickEnumModelAttributePreferences.dateFormat,
        ),
      ],
      controller: WickControllerUser(),
      primaryKey: preferences.userId,
      autoSubmit: true,
      autoFocus: false,
    );
  }
}
