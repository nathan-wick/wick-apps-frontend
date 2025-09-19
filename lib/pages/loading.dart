import 'package:flutter/cupertino.dart';

import '../widgets/loading_indicator.dart';
import 'base.dart';

class WickPageLoading extends StatelessWidget {
  const WickPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return WickPageBase(
      title: 'Loading',
      content: const [
        WickWidgetLoadingIndicator(),
        // TODO Add useful information if it's taking a while to load
      ],
    );
  }
}
