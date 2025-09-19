import 'package:flutter/cupertino.dart';

import 'base.dart';

class WickModelDashboardTile extends WickModelBase<WickModelDashboardTile> {
  final String name;

  // TODO This could use a wick tile base
  final Widget tile;
  final bool activeByDefault;

  WickModelDashboardTile({
    required this.name,
    required this.tile,
    this.activeByDefault = true,
  }) : super({'name': name, 'tile': tile, 'activeByDefault': activeByDefault});
}
