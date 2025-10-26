import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/navigation_option.dart';
import '../providers/navigation.dart';
import '../utilities/style_constants.dart';

class WickWidgetNavigationDrawer extends StatelessWidget {
  final List<String> availableRoutes;

  const WickWidgetNavigationDrawer({super.key, required this.availableRoutes});

  @override
  Widget build(BuildContext context) {
    final WickProviderNavigation navigationProvider =
        Provider.of<WickProviderNavigation>(context, listen: false);
    return FutureBuilder(
      future: navigationProvider.getValue(context),
      builder: (context, snapshot) {
        final String? currentRoute = snapshot.data?.lastRoute;
        final List<Widget> listItems = [];
        for (WickModelNavigationOption navigationOption
            in navigationProvider.navigationOptions) {
          if (!availableRoutes.contains(navigationOption.route)) {
            continue;
          }
          final bool isSelected = navigationOption.route == currentRoute;
          listItems.add(
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: WickUtilityStyleConstants.paddingSize,
              ),
              child: ListTile(
                leading: Icon(
                  navigationOption.icon,
                  color: isSelected ? Theme.of(context).primaryColor : null,
                ),
                title: Text(
                  navigationOption.name,
                  style:
                      isSelected
                          ? TextStyle(color: Theme.of(context).primaryColor)
                          : null,
                ),
                tileColor:
                    isSelected
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                        : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    WickUtilityStyleConstants.boarderRadius,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  navigationProvider.navigate(context, navigationOption.route);
                },
              ),
            ),
          );
        }
        return Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(WickUtilityStyleConstants.boarderRadius),
              bottomLeft: Radius.circular(
                WickUtilityStyleConstants.boarderRadius,
              ),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: WickUtilityStyleConstants.paddingSize,
            ),
            children: listItems,
          ),
        );
      },
    );
  }
}
