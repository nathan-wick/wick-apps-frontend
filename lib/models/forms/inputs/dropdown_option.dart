import 'package:flutter/cupertino.dart';

import '../../base.dart';

class DropdownOptionModel extends BaseModel {
  final String? value;
  final String label;
  final IconData? icon;

  DropdownOptionModel({required this.value, required this.label, this.icon})
    : super({"value": value, "label": label, "icon": icon});
}
