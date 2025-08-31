import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final String name;
  final Alignment alignment;
  final List<Widget> content;
  final List<Widget> actionButtons;
  final bool displayMainNavigation;
  final IconData? icon;
  final Widget? drawer;

  const BasePage({
    super.key,
    required this.name,
    required this.content,
    this.actionButtons = const [],
    this.alignment = Alignment.topCenter,
    this.displayMainNavigation = true,
    this.icon,
    this.drawer,
  });

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    // TODO Implement build
    return Scaffold();
  }
}
