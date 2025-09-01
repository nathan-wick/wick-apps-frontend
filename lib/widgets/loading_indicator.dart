import 'package:flutter/material.dart';

class WickWidgetLoadingIndicator extends StatelessWidget {
  const WickWidgetLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
