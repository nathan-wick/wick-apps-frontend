import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/pages/welcome.dart';

import '../providers/navigation.dart';
import 'loading.dart';
import 'not_found.dart';

class WickPageInitial extends StatelessWidget {
  final String homeRoute;
  final bool isAuthenticated;

  const WickPageInitial({
    super.key,
    required this.homeRoute,
    required this.isAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialDestination(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WickPageLoading();
        }
        return snapshot.data ?? const WickPageNotFound();
      },
    );
  }

  Future<Widget> _getInitialDestination(BuildContext context) async {
    if (!isAuthenticated) {
      return const WickPageWelcome();
    }
    final WickProviderNavigation navigationProvider =
        Provider.of<WickProviderNavigation>(context, listen: false);
    final String? lastRoute =
        (await navigationProvider.getValue(context))?.lastRoute;
    final String defaultRoute = lastRoute ?? homeRoute;
    return navigationProvider.getDestination(context, defaultRoute);
  }
}
