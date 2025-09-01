import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation.dart';
import '../utilities/style_constants.dart';

class WickNavigationBar extends StatelessWidget {
  final List<String> routes;

  const WickNavigationBar({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    return FutureBuilder(
      future: navigationProvider.getValue(),
      builder: (context, snapshot) {
        final String? currentRoute = snapshot.data?.lastRoute;
        final Widget navigationBar = Container(
          padding: EdgeInsets.all(StyleConstants.paddingSize),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius:
                MediaQuery.of(context).size.width > StyleConstants.wideWidthSize
                    ? BorderRadius.circular(StyleConstants.boarderRadius)
                    : const BorderRadius.only(
                      topLeft: Radius.circular(StyleConstants.boarderRadius),
                      topRight: Radius.circular(StyleConstants.boarderRadius),
                    ),
          ),
          child: Row(
            mainAxisSize:
                MediaQuery.of(context).size.width > StyleConstants.wideWidthSize
                    ? MainAxisSize.min
                    : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                navigationProvider.navigationOptions.map((navigationOption) {
                  final bool isSelected =
                      navigationOption.route == currentRoute;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: StyleConstants.paddingSize,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(
                        StyleConstants.boarderRadius,
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
          height: StyleConstants.barHeight,
          color: Colors.transparent,
          child: Align(child: navigationBar),
        );
      },
    );
  }
}
