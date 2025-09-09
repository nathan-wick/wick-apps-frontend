import 'package:flutter/material.dart';

import '../utilities/style_constants.dart';

class WickWidgetCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> content;
  final bool isWide;

  const WickWidgetCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints:
            isWide
                ? const BoxConstraints(maxWidth: double.infinity)
                : const BoxConstraints(
                  maxWidth: WickUtilityStyleConstants.wideWidthSize,
                ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              WickUtilityStyleConstants.boarderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    WickUtilityStyleConstants.boarderRadius,
                  ),
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                ),
                padding: EdgeInsets.all(WickUtilityStyleConstants.paddingSize),
                child: Row(
                  children: [
                    Icon(icon, color: Theme.of(context).primaryColor),
                    const SizedBox(
                      width: WickUtilityStyleConstants.paddingSize,
                    ),
                    Text(
                      title,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(WickUtilityStyleConstants.paddingSize),
                child: Column(children: content),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
