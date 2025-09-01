import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/navigation_option.dart';
import '../models/navigation_provider.dart';
import '../pages/base.dart';
import '../pages/not_found.dart';
import '../pages/welcome.dart';
import '../providers/session.dart';
import 'base.dart';

class NavigationProvider extends BaseProvider<NavigationProviderModel> {
  String homeRoute;
  List<String> mainRoutes;
  List<NavigationOptionModel> navigationOptions;

  NavigationProvider({
    required this.homeRoute,
    this.mainRoutes = const [],
    this.navigationOptions = const [],
  }) : super(NavigationProviderModel.fromJson);

  void navigate(BuildContext context, [String? route]) async {
    final bool signedIn =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token !=
        null;
    if (signedIn) {
      route ??= homeRoute;
      setValue(NavigationProviderModel(lastRoute: route));
      final NavigationOptionModel? navigationOption = navigationOptions
          .firstWhereOrNull(
            (navigationOption) => navigationOption.route == route,
          );
      if (navigationOption == null) {
        _navigate(context, const NotFoundPage());
      } else {
        navigationOption.onNavigate?.call();
        _navigate(context, navigationOption.destination);
      }
    } else {
      setValue(null);
      _navigate(context, const WelcomePage());
    }
  }

  void _navigate(BuildContext context, BasePage destination) {
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
