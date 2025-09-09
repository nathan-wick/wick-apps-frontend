import 'package:flutter/material.dart';

import '../widgets/card.dart';
import '../widgets/authentication.dart';
import 'base.dart';

class WickPageWelcome extends StatelessWidget {
  const WickPageWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return WickPageBase(
      title: 'Welcome',
      content: const [
        WickWidgetCard(
          title: 'Sign-In',
          content: [WickWidgetAuthentication()],
          icon: Icons.account_circle,
        ),
      ],
    );
  }
}
