import 'package:flutter/material.dart';

class WickWidgetLoadingIndicator extends StatelessWidget {
  final String? action;

  const WickWidgetLoadingIndicator({super.key, this.action});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (action != null) ...[
            const SizedBox(height: 12),
            Text("$action...", textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
