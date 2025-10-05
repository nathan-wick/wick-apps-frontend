import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/controllers/user.dart';
import 'package:wick_apps/models/form_inputs/field.dart';
import 'package:wick_apps/widgets/forms/stack.dart';

import '../../models/user.dart';
import '../../providers/user.dart';
import '../loading_indicator.dart';

class WickWidgetTileContentProfile extends StatelessWidget {
  const WickWidgetTileContentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final WickModelUser? user = Provider.of<WickProviderUser>(context).value;
    if (user == null) {
      return const WickWidgetLoadingIndicator();
    }
    return WickWidgetFormStack(
      name: 'Profile',
      inputs: [
        WickModelFormInputField(fieldName: 'picture'),
        WickModelFormInputField(fieldName: 'firstName'),
        WickModelFormInputField(fieldName: 'lastName'),
        WickModelFormInputField(fieldName: 'birthday'),
      ],
      controller: WickControllerUser(),
      primaryKey: user.id,
      autoSubmit: true,
      autoFocus: false,
    );
  }
}
