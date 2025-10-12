import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../enums/log_type.dart';
import '../models/navigation_option.dart';
import '../models/navigation_provider.dart';
import '../pages/not_found.dart';
import '../utilities/logger.dart';
import 'base.dart';

class WickProviderNavigation
    extends WickProviderBase<WickModelWickProviderNavigation> {
  String homeRoute;
  List<WickModelNavigationOption> navigationOptions;

  WickProviderNavigation({
    required this.homeRoute,
    this.navigationOptions = const [],
  }) : super(WickModelWickProviderNavigation.fromJson);

  void navigate(BuildContext context, [String? route]) async {
    route ??= homeRoute;
    setValue(context, WickModelWickProviderNavigation(lastRoute: route));
    final Widget destination = await getDestination(context, route);
    navigationOptions
        .firstWhereOrNull((navigationOption) => navigationOption.route == route)
        ?.onNavigate
        ?.call();
    _navigate(context, destination);
  }

  Future<Widget> getDestination(BuildContext context, String? route) async {
    WickModelNavigationOption? option;
    try {
      option = navigationOptions.firstWhere(
        (navigationOption) => navigationOption.route == route,
      );
    } catch (_) {
      option = null;
    }
    final Widget destination = option?.destination ?? const WickPageNotFound();
    WickUtilityLogger.log(context, WickEnumLogType.navigation, {
      'method': 'getDestination',
      'route': route,
      'destination': destination,
    });
    return destination;
  }

  void _navigate(BuildContext context, Widget destination) {
    WickUtilityLogger.log(context, WickEnumLogType.navigation, {
      'method': 'navigate',
      'route': value?.lastRoute,
      'destination': destination,
    });
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        maintainState: false,
      ),
    );
  }
}
