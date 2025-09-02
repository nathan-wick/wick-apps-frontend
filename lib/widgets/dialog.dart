import 'package:flutter/material.dart';

import '../enums/button_type.dart';
import '../utilities/style_constants.dart';
import 'button.dart';

class WickWidgetDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> content;
  final bool displayActions;
  final String okayMessage;
  final bool displayCancel;
  final Function()? onOkay;

  const WickWidgetDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.displayActions = true,
    this.okayMessage = "Okay",
    this.displayCancel = true,
    this.onOkay,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          WickUtilityStyleConstants.boarderRadius,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
              minWidth:
                  constraints.maxWidth < WickUtilityStyleConstants.wideWidthSize
                      ? constraints.maxWidth
                      : WickUtilityStyleConstants.wideWidthSize,
            ),
            child: IntrinsicWidth(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  WickUtilityStyleConstants.boarderRadius,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          WickUtilityStyleConstants.boarderRadius,
                        ),
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.1),
                      ),
                      padding: EdgeInsets.all(
                        WickUtilityStyleConstants.paddingSize,
                      ),
                      child: Row(
                        children: [
                          Icon(icon, color: Theme.of(context).primaryColor),
                          const SizedBox(
                            width: WickUtilityStyleConstants.contentGapSize,
                          ),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        WickUtilityStyleConstants.paddingSize,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...content,
                          const SizedBox(
                            height: WickUtilityStyleConstants.contentGapSize,
                          ),
                          if (displayActions)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (displayCancel)
                                  WickWidgetButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    message: "Cancel",
                                    type: WickEnumButtonType.text,
                                  ),
                                if (displayCancel)
                                  const SizedBox(
                                    width:
                                        WickUtilityStyleConstants
                                            .contentGapSize,
                                  ),
                                WickWidgetButton(
                                  onPressed: () {
                                    if (onOkay != null) {
                                      onOkay!();
                                    }
                                    Navigator.of(context).pop(true);
                                  },
                                  message: okayMessage,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
