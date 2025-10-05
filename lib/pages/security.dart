import 'package:flutter/material.dart';
import 'package:wick_apps/widgets/tile_contents/active_sessions.dart';

import '../models/tile.dart';
import 'dashboard_base.dart';

class WickPageSecurity extends StatelessWidget {
  const WickPageSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return WickPageDashboardBase(
      name: 'Security',
      icon: Icons.security,
      tiles: [
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
