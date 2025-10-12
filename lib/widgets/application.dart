import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/widgets/loading_indicator.dart';

import '../enums/brightness.dart';
import '../enums/color.dart';
import '../models/navigation_option.dart';
import '../models/preferences.dart';
import '../pages/account.dart';
import '../pages/initial.dart';
import '../pages/preferences.dart';
import '../pages/profile.dart';
import '../pages/security.dart';
import '../pages/welcome.dart';
import '../providers/navigation.dart';
import '../providers/preferences.dart';
import '../providers/session.dart';
import '../providers/user.dart';
import '../utilities/color_engine.dart';

class WickWidgetApplication extends StatefulWidget {
  final String name;
  final List<WickModelNavigationOption> navigationOptions;
  final String homeRoute;
  final WickEnumColor defaultPrimaryColor;

  const WickWidgetApplication({
    super.key,
    required this.name,
    required this.navigationOptions,
    required this.homeRoute,
    this.defaultPrimaryColor = WickEnumColor.blue,
  });

  @override
  State<WickWidgetApplication> createState() => _WickWidgetApplicationState();
}

class _WickWidgetApplicationState extends State<WickWidgetApplication> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WickProviderSession()),
        ChangeNotifierProvider(
          create:
              (context) => WickProviderNavigation(
                homeRoute: widget.homeRoute,
                navigationOptions: widget.navigationOptions,
              ),
        ),
        ChangeNotifierProvider(create: (context) => WickProviderUser()),
        ChangeNotifierProvider(create: (context) => WickProviderPreferences()),
      ],
      child: Builder(
        builder: (context) {
          _initializeNavigation(context);
          return FutureBuilder(
            future: Provider.of<WickProviderPreferences>(
              context,
            ).getValue(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WickWidgetLoadingIndicator();
              }
              final WickModelPreferences? preferences = snapshot.data;
              final Color primaryColor =
                  preferences?.primaryColor.value ??
                  widget.defaultPrimaryColor.value;
              final accessibleLightPrimaryColor =
                  WickUtilityColorEngine.calculateAccessibleColor(
                    primaryColor,
                    Colors.white,
                  );
              final accessibleDarkPrimaryColor =
                  WickUtilityColorEngine.calculateAccessibleColor(
                    primaryColor,
                    Colors.black,
                  );
              final lightColorScheme = ColorScheme.fromSeed(
                seedColor: accessibleLightPrimaryColor,
                brightness: Brightness.light,
              );
              final darkColorScheme = ColorScheme.fromSeed(
                seedColor: accessibleDarkPrimaryColor,
                brightness: Brightness.dark,
              );
              final lightTheme = ThemeData(
                useMaterial3: true,
                colorScheme: lightColorScheme,
                primaryColor: accessibleLightPrimaryColor,
              );
              final darkTheme = ThemeData(
                useMaterial3: true,
                colorScheme: darkColorScheme,
                primaryColor: accessibleDarkPrimaryColor,
              );
              return MaterialApp(
                title: widget.name,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode:
                    preferences?.brightness.value ??
                    WickEnumBrightness.system.value,
                home: WickPageInitial(
                  homeRoute: widget.homeRoute,
                  isAuthenticated: preferences != null,
                ),
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }

  void _initializeNavigation(BuildContext context) {
    final List<WickModelNavigationOption> initialNavigationOptions =
        List<WickModelNavigationOption>.from(widget.navigationOptions);
    initialNavigationOptions.addAll([
      WickModelNavigationOption(
        name: 'Welcome',
        route: 'welcome',
        icon: Icons.login,
        destination: const WickPageWelcome(),
      ),
      WickModelNavigationOption(
        name: 'Account',
        route: 'account',
        icon: Icons.account_circle,
        destination: const WickPageAccount(),
        isMain: true,
      ),
      WickModelNavigationOption(
        name: 'Profile',
        route: 'profile',
        icon: Icons.person,
        destination: const WickPageProfile(),
      ),
      WickModelNavigationOption(
        name: 'Preferences',
        route: 'preferences',
        icon: Icons.settings,
        destination: const WickPagePreferences(),
      ),
      WickModelNavigationOption(
        name: 'Security',
        route: 'security',
        icon: Icons.security,
        destination: const WickPageSecurity(),
      ),
      WickModelNavigationOption(
        name: 'Sign Out',
        route: 'sign-out',
        icon: Icons.logout,
        destination: const WickPageWelcome(),
        onNavigate: () {
          Provider.of<WickProviderSession>(
            context,
            listen: false,
          ).signOut(context);
        },
      ),
    ]);
    final WickProviderNavigation navigationProvider =
        Provider.of<WickProviderNavigation>(context, listen: false);
    navigationProvider.navigationOptions = initialNavigationOptions;
  }
}
