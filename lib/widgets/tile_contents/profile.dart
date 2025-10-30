import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/controllers/user.dart';
import 'package:wick_apps/enums/model_attributes/user.generated.dart';
import 'package:wick_apps/models/form_inputs/attribute.dart';
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
        WickModelFormInputAttribute(
          attributeName: WickEnumModelAttributeUser.picture.name,
        ),
        WickModelFormInputAttribute(
          attributeName: WickEnumModelAttributeUser.firstName.name,
        ),
        WickModelFormInputAttribute(
          attributeName: WickEnumModelAttributeUser.lastName.name,
        ),
        WickModelFormInputAttribute(
          attributeName: WickEnumModelAttributeUser.birthday.name,
        ),
      ],
      controller: WickControllerUser(),
      primaryKey: user.id,
      autoSubmit: true,
      autoFocus: false,
    );
  }
}
