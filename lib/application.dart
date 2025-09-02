import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enums/brightness.dart';
import 'enums/color.dart';
import 'models/navigation_option.dart';
import 'models/preferences.dart';
import 'pages/account.dart';
import 'pages/loading.dart';
import 'pages/preferences.dart';
import 'pages/profile.dart';
import 'pages/security.dart';
import 'pages/welcome.dart';
import 'providers/navigation.dart';
import 'providers/preferences.dart';
import 'providers/session.dart';
import 'providers/user.dart';
import 'utilities/color_engine.dart';

class WickApplication extends StatefulWidget {
  final String name;
  final List<WickModelNavigationOption> navigationOptions;
  final String homeRoute;
  final List<String> mainRoutes;
  final WickEnumColor defaultPrimaryColor;

  const WickApplication({
    super.key,
    required this.name,
    required this.navigationOptions,
    required this.homeRoute,
    required this.mainRoutes,
    this.defaultPrimaryColor = WickEnumColor.blue,
  });

  @override
  State<WickApplication> createState() => _WickApplicationState();
}

class _WickApplicationState extends State<WickApplication> {
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
            future: Provider.of<WickProviderPreferences>(context).getValue(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WickPageLoading();
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
                // TODO Get and set the initial destination
                home: const WickPageLoading(),
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
    List<String> mainRoutes = List<String>.from(widget.mainRoutes);
    mainRoutes.add('account');
    final WickProviderNavigation navigationProvider =
        Provider.of<WickProviderNavigation>(context, listen: false);
    navigationProvider.navigationOptions = initialNavigationOptions;
    navigationProvider.mainRoutes = mainRoutes;
  }
}
