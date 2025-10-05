import 'package:flutter/cupertino.dart';

import 'base.dart';

class WickModelTile extends WickModelBase<WickModelTile> {
  final String name;
  final IconData icon;
  final List<Widget> content;
  final bool activeByDefault;

  WickModelTile({
    required this.name,
    required this.icon,
    required this.content,
    this.activeByDefault = true,
  }) : super({
         'name': name,
         'icon': icon,
         'content': content,
         'activeByDefault': activeByDefault,
       });
}
