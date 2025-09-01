import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enumerations/brightness.dart';
import 'enumerations/color.dart';
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

class Application extends StatefulWidget {
  final String name;
  final List<NavigationOptionModel> navigationOptions;
  final String homeRoute;
  final List<String> mainRoutes;
  final WickColor defaultPrimaryColor;

  const Application({
    super.key,
    required this.name,
    required this.navigationOptions,
    required this.homeRoute,
    required this.mainRoutes,
    this.defaultPrimaryColor = WickColor.blue,
  });

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SessionProvider()),
        ChangeNotifierProvider(
          create:
              (context) => NavigationProvider(
                homeRoute: widget.homeRoute,
                navigationOptions: widget.navigationOptions,
              ),
        ),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PreferencesProvider()),
      ],
      child: Builder(
        builder: (context) {
          _initializeNavigation(context);
          return FutureBuilder(
            future: Provider.of<PreferencesProvider>(context).getValue(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              }
              final PreferencesModel? preferences = snapshot.data;
              final Color primaryColor =
                  preferences?.primaryColor.value ??
                  widget.defaultPrimaryColor.value;
              final accessibleLightPrimaryColor =
                  ColorEngine.calculateAccessibleColor(
                    primaryColor,
                    Colors.white,
                  );
              final accessibleDarkPrimaryColor =
                  ColorEngine.calculateAccessibleColor(
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
                    WickBrightness.system.value,
                // TODO Get and set the initial destination
                home: const LoadingPage(),
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }

  void _initializeNavigation(BuildContext context) {
    final List<NavigationOptionModel> initialNavigationOptions =
        List<NavigationOptionModel>.from(widget.navigationOptions);
    initialNavigationOptions.addAll([
      NavigationOptionModel(
        name: 'Welcome',
        route: 'welcome',
        icon: Icons.login,
        destination: const WelcomePage(),
      ),
      NavigationOptionModel(
        name: 'Account',
        route: 'account',
        icon: Icons.account_circle,
        destination: const AccountPage(),
      ),
      NavigationOptionModel(
        name: 'Profile',
        route: 'profile',
        icon: Icons.person,
        destination: const ProfilePage(),
      ),
      NavigationOptionModel(
        name: 'Preferences',
        route: 'preferences',
        icon: Icons.settings,
        destination: const PreferencesPage(),
      ),
      NavigationOptionModel(
        name: 'Security',
        route: 'security',
        icon: Icons.security,
        destination: const SecurityPage(),
      ),
      NavigationOptionModel(
        name: 'Sign Out',
        route: 'sign-out',
        icon: Icons.logout,
        destination: const WelcomePage(),
        onNavigate: () {
          Provider.of<SessionProvider>(context, listen: false).signOut(context);
        },
      ),
    ]);
    List<String> mainRoutes = List<String>.from(widget.mainRoutes);
    mainRoutes.add('account');
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    navigationProvider.navigationOptions = initialNavigationOptions;
    navigationProvider.mainRoutes = mainRoutes;
  }
}
