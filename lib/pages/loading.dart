import 'package:flutter/cupertino.dart';

import '../widgets/loading_indicator.dart';
import 'base.dart';

class WickPageLoading extends StatelessWidget {
  final String? action;

  const WickPageLoading({super.key, this.action});

  @override
  Widget build(BuildContext context) {
    return WickPageBase(
      title: 'Loading',
      content: [
        WickWidgetLoadingIndicator(action: action),
        // TODO Add useful information if it's taking a while to load
      ],
    );
  }
}
