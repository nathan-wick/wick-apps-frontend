import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation.dart';
import '../utilities/style_constants.dart';
import '../widgets/icon_button.dart';
import '../widgets/navigation_bar.dart';

class BasePage extends StatefulWidget {
  final String name;
  final Alignment alignment;
  final List<Widget> content;
  final List<Widget> actionButtons;
  final bool displayMainNavigation;
  final IconData? icon;
  final Widget? drawer;

  const BasePage({
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
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    if (widget.drawer != null) {
      widget.actionButtons.add(
        Builder(
          builder: (context) {
            return WickIconButton(
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
        preferredSize: const Size.fromHeight(StyleConstants.barHeight),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(StyleConstants.boarderRadius),
            bottomRight: Radius.circular(StyleConstants.boarderRadius),
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
                padding: EdgeInsets.all(StyleConstants.paddingSize),
                child: Column(
                  children: [
                    ...widget.content,
                    const SizedBox(height: StyleConstants.barHeight),
                  ],
                ),
              ),
            ),
            if (widget.displayMainNavigation)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: WickNavigationBar(routes: navigationProvider.mainRoutes),
              ),
          ],
        ),
      ),
      endDrawer: widget.drawer,
    );
  }
}
