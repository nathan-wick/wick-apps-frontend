import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/button_type.dart';
import '../../models/user.dart';
import '../../providers/session.dart';
import '../../providers/user.dart';
import '../../utilities/style_constants.dart';
import '../button.dart';
import '../loading_indicator.dart';

class WickWidgetTileContentAccount extends StatelessWidget {
  const WickWidgetTileContentAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final WickModelUser? user = Provider.of<WickProviderUser>(context).value;
    if (user == null) {
      return const WickWidgetLoadingIndicator();
    }
    return Column(
      children: [
        CircleAvatar(
          radius: WickUtilityStyleConstants.largeAvatarSize / 2,
          backgroundImage:
              user.picture != null
                  ? MemoryImage(base64Decode(user.picture!))
                  : null,
          child:
              user.picture == null
                  ? const Icon(
                    Icons.account_circle,
                    size: WickUtilityStyleConstants.largeAvatarSize,
                  )
                  : null,
        ),
        const SizedBox(height: WickUtilityStyleConstants.paddingSize),
        if (user.firstName != null || user.lastName != null)
          Text('${user.firstName ?? ''} ${user.lastName ?? ''}'.trim()),
        Text(user.email),
        const SizedBox(height: WickUtilityStyleConstants.paddingSize),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WickWidgetButton(
              onPressed: () {
                Provider.of<WickProviderSession>(
                  context,
                  listen: false,
                ).signOut(context);
              },
              type: WickEnumButtonType.text,
              icon: Icons.logout,
              message: "Sign Out",
            ),
          ],
        ),
      ],
    );
  }
}
