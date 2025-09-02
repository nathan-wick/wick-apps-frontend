import 'package:flutter/cupertino.dart';

import '../../base.dart';

class WickModelFormInputDropdownOption extends WickModelBase {
  final String? value;
  final String label;
  final IconData? icon;

  WickModelFormInputDropdownOption({
    required this.value,
    required this.label,
    this.icon,
  }) : super({"value": value, "label": label, "icon": icon});
}
