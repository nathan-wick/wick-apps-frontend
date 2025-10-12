import 'package:flutter/cupertino.dart';

import 'base.dart';

class WickModelNavigationOption
    extends WickModelBase<WickModelNavigationOption> {
  final String name;
  final String route;
  final IconData icon;
  final Widget destination;
  final bool isMain;
  final Function()? onNavigate;

  WickModelNavigationOption({
    required this.name,
    required this.route,
    required this.icon,
    required this.destination,
    this.isMain = false,
    this.onNavigate,
  }) : super({
         'name': name,
         'route': route,
         'icon': icon,
         'destination': destination,
         'isMain': isMain,
         'onNavigate': onNavigate,
       });
}
