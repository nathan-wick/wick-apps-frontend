import 'package:flutter/material.dart';

import '../utilities/style_constants.dart';

class WickIconButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final void Function() onPressed;

  const WickIconButton({
    super.key,
    required this.name,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // TODO This padding is sus
      padding: const EdgeInsets.only(right: StyleConstants.paddingSize),
      child: IconButton(
        tooltip: name,
        icon: Icon(icon, color: Theme.of(context).scaffoldBackgroundColor),
        onPressed: onPressed,
      ),
    );
  }
}
