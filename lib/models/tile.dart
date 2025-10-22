import 'package:flutter/cupertino.dart';

class WickModelTile {
  final String name;
  final IconData icon;
  final List<Widget> content;
  final bool activeByDefault;

  WickModelTile({
    required this.name,
    required this.icon,
    required this.content,
    this.activeByDefault = true,
  });
}
