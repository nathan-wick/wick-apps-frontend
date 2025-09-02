import 'package:flutter/cupertino.dart';

import '../pages/base.dart';
import 'base.dart';

class WickModelNavigationOption extends WickModelBase {
  final String name;
  final String route;
  final IconData icon;
  final WickPageBase destination;
  final Function()? onNavigate;

  WickModelNavigationOption({
    required this.name,
    required this.route,
    required this.icon,
    required this.destination,
    this.onNavigate,
  }) : super({
         'name': name,
         'route': route,
         'icon': icon,
         'destination': destination,
         'onNavigate': onNavigate,
       });
}
