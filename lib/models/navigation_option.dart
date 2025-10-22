import 'package:flutter/cupertino.dart';

class WickModelNavigationOption {
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
  });
}
