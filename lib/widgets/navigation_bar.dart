import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation.dart';
import '../utilities/style_constants.dart';

class WickWidgetNavigationBar extends StatelessWidget {
  final List<String> routes;

  const WickWidgetNavigationBar({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    final WickProviderNavigation navigationProvider =
        Provider.of<WickProviderNavigation>(context, listen: false);
    return FutureBuilder(
      future: navigationProvider.getValue(context),
      builder: (context, snapshot) {
        final String? currentRoute = snapshot.data?.lastRoute;
        final Widget navigationBar = Container(
          padding: EdgeInsets.all(WickUtilityStyleConstants.paddingSize),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius:
                MediaQuery.of(context).size.width >
                        WickUtilityStyleConstants.wideWidthSize
                    ? BorderRadius.circular(
                      WickUtilityStyleConstants.boarderRadius,
                    )
                    : const BorderRadius.only(
                      topLeft: Radius.circular(
                        WickUtilityStyleConstants.boarderRadius,
                      ),
                      topRight: Radius.circular(
                        WickUtilityStyleConstants.boarderRadius,
                      ),
                    ),
          ),
          child: Row(
            mainAxisSize:
                MediaQuery.of(context).size.width >
                        WickUtilityStyleConstants.wideWidthSize
                    ? MainAxisSize.min
                    : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                navigationProvider.navigationOptions.map((navigationOption) {
                  final bool isSelected =
                      navigationOption.route == currentRoute;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: WickUtilityStyleConstants.paddingSize,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(
                        WickUtilityStyleConstants.boarderRadius,
                      ),
                    ),
                    child: IconButton(
                      tooltip: navigationOption.name,
                      icon: Icon(
                        navigationOption.icon,
                        color:
                            isSelected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).scaffoldBackgroundColor,
                      ),
                      onPressed:
                          isSelected
                              ? null
                              : () => navigationProvider.navigate(
                                context,
                                navigationOption.route,
                              ),
                    ),
                  );
                }).toList(),
          ),
        );
        return Container(
          width: double.infinity,
          height: WickUtilityStyleConstants.barHeight,
          color: Colors.transparent,
          child: Align(child: navigationBar),
        );
      },
    );
  }
}
