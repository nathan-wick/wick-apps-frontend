import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation.dart';
import '../utilities/style_constants.dart';
import '../widgets/icon_button.dart';
import '../widgets/navigation_bar.dart';

class WickPageBase extends StatefulWidget {
  final String name;
  final Alignment alignment;
  final List<Widget> content;
  final List<Widget> actionButtons;
  final bool displayMainNavigation;
  final IconData? icon;
  final Widget? drawer;

  const WickPageBase({
    super.key,
    required this.name,
    required this.content,
    this.actionButtons = const [],
    this.alignment = Alignment.topCenter,
    this.displayMainNavigation = true,
    this.icon,
    this.drawer,
  });

  @override
  WickPageBaseState createState() => WickPageBaseState();
}

class WickPageBaseState extends State<WickPageBase> {
  @override
  Widget build(BuildContext context) {
    final WickProviderNavigation navigationProvider =
        Provider.of<WickProviderNavigation>(context, listen: false);
    if (widget.drawer != null) {
      widget.actionButtons.add(
        Builder(
          builder: (context) {
            return WickWidgetIconButton(
              name: 'Menu',
              icon: Icons.table_rows,
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          },
        ),
      );
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          WickUtilityStyleConstants.barHeight,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(
              WickUtilityStyleConstants.boarderRadius,
            ),
            bottomRight: Radius.circular(
              WickUtilityStyleConstants.boarderRadius,
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              widget.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            actions: widget.actionButtons,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: widget.alignment,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(WickUtilityStyleConstants.paddingSize),
                child: Column(
                  children: [
                    ...widget.content,
                    const SizedBox(height: WickUtilityStyleConstants.barHeight),
                  ],
                ),
              ),
            ),
            if (widget.displayMainNavigation)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: WickWidgetNavigationBar(
                  routes: navigationProvider.mainRoutes,
                ),
              ),
          ],
        ),
      ),
      endDrawer: widget.drawer,
    );
  }
}
