import 'package:flutter/material.dart';
import 'package:wick_apps/widgets/tile_contents/theme_preferences.dart';

import '../models/tile.dart';
import '../widgets/tile_contents/time_preferences.dart';
import 'dashboard_base.dart';

class WickPagePreferences extends StatelessWidget {
  const WickPagePreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return WickPageDashboardBase(
      name: 'Preferences',
      icon: Icons.settings,
      tiles: [
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
      ],
    );
  }
}
