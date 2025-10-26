import 'package:flutter/material.dart';

import '../models/tile.dart';
import '../widgets/tile_contents/profile.dart';
import 'dashboard_base.dart';

class WickPageProfile extends StatelessWidget {
  const WickPageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return WickPageDashboardBase(
      name: 'Profile',
      icon: Icons.person,
      tiles: [
        WickModelTile(
          name: 'Profile',
          icon: Icons.person,
          content: [WickWidgetTileContentProfile()],
          activeByDefault: true,
        ),
      ],
      availableDrawerRoutes: [
        'account',
        'profile',
        'preferences',
        'security',
        'sign-out',
      ],
    );
  }
}
