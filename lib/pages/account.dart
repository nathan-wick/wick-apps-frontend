import 'package:flutter/material.dart';
import 'package:wick_apps/widgets/tile_contents/active_sessions.dart';
import 'package:wick_apps/widgets/tile_contents/theme_preferences.dart';

import '../models/tile.dart';
import '../widgets/tile_contents/account.dart';
import '../widgets/tile_contents/profile.dart';
import '../widgets/tile_contents/time_preferences.dart';
import 'dashboard_base.dart';

class WickPageAccount extends StatelessWidget {
  const WickPageAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return WickPageDashboardBase(
      name: 'Account',
      icon: Icons.account_circle,
      tiles: [
        WickModelTile(
          name: 'Account',
          icon: Icons.account_circle,
          content: [WickWidgetTileContentAccount()],
          activeByDefault: true,
        ),
        WickModelTile(
          name: 'Profile',
          icon: Icons.person,
          content: [WickWidgetTileContentProfile()],
          activeByDefault: false,
        ),
        WickModelTile(
          name: 'Theme Preferences',
          icon: Icons.format_paint,
          content: [WickWidgetTileContentThemePreferences()],
          activeByDefault: false,
        ),
        WickModelTile(
          name: 'Time Preferences',
          icon: Icons.timer,
          content: [WickWidgetTileContentTimePreferences()],
          activeByDefault: false,
        ),
        WickModelTile(
          name: 'Active Sessions',
          icon: Icons.directions_run,
          content: [WickWidgetTileContentActiveSessions()],
          activeByDefault: false,
        ),
      ],
    );
  }
}
