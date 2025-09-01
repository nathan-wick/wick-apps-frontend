import 'package:flutter/cupertino.dart';

import '../pages/base.dart';
import 'base.dart';

class NavigationOptionModel extends BaseModel {
  final String name;
  final String route;
  final IconData icon;
  final BasePage destination;
  final Function()? onNavigate;

  NavigationOptionModel({
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

  factory NavigationOptionModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
