import 'package:flutter/material.dart';

import '../controllers/dashboard_configuration.dart';
import '../models/dashboard_configuration.dart';
import '../models/tile.dart';
import '../models/tile_option.dart';
import '../utilities/style_constants.dart';
import '../widgets/card.dart';
import '../widgets/dialog.dart';
import '../widgets/icon_button.dart';
import '../widgets/table.dart';
import 'base.dart';
import 'loading.dart';

class WickPageDashboardBase extends StatefulWidget {
  final String name;
  final List<WickModelTile> tiles;
  final IconData? icon;

  // TODO Only use wick drawer. Do the same for page base.
  final Widget? drawer;

  const WickPageDashboardBase({
    super.key,
    required this.name,
    required this.tiles,
    this.icon,
    this.drawer,
  });

  @override
  State<WickPageDashboardBase> createState() => _WickPageDashboardBaseState();
}

class _WickPageDashboardBaseState extends State<WickPageDashboardBase> {
  Future<WickModelDashboardConfiguration?>? _configurationFuture;
  String? _activeConfiguration;

  @override
  void initState() {
    super.initState();
    _configurationFuture ??= WickControllerDashboardConfiguration()
        .getConfigurationForCurrentUser(context, widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WickModelDashboardConfiguration?>(
      future: _configurationFuture,
      builder: (context, snapshot) {
        _activeConfiguration = snapshot.data?.configuration;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WickPageLoading(action: 'Configuring dashboard');
        }
        return WickPageBase(
          title: widget.name,
          icon: widget.icon,
          drawer: widget.drawer,
          content: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getColumns(_activeConfiguration),
            ),
          ],
          additionalActionButtons: [
            WickWidgetIconButton(
              name: 'Configure Dashboard',
              icon: Icons.dashboard_customize,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WickWidgetDialog(
                      icon: Icons.dashboard_customize,
                      title: "Configure Dashboard",
                      content: [
                        WickWidgetTable(
                          data: _getOptions(_activeConfiguration),
                          displayHeader: false,
                          canReorderRows: true,
                          editableColumnKeys: const ["active"],
                          onChanged: _onConfigurationChanged,
                        ),
                      ],
                      displayActions: true,
                      okayMessage: "Save",
                      onOkay:
                          () => _onApplyChangedConfiguration(
                            context,
                            snapshot.data,
                          ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  List<WickModelTileOption> _getOptions(String? configuration) {
    if (configuration == null || configuration.isEmpty) {
      return widget.tiles
          .map(
            (tile) => WickModelTileOption(
              active: tile.activeByDefault,
              name: tile.name,
            ),
          )
          .toList();
    }

    return widget.tiles
        .map(
          (tile) => WickModelTileOption(
            active: configuration.split(',').contains(tile.name),
            name: tile.name,
          ),
        )
        .toList();
  }

  List<Widget> _getColumns(String? configuration) {
    final List<WickModelTile> activeTiles =
        configuration == null
            ? widget.tiles.where((tile) => tile.activeByDefault).toList()
            : widget.tiles
                .where((tile) => configuration.split(',').contains(tile.name))
                .toList();
    final double screenWidth = MediaQuery.sizeOf(context).width;
    int numberOfColumns =
        screenWidth ~/ WickUtilityStyleConstants.wideWidthSize;
    if (numberOfColumns < 1) numberOfColumns = 1;
    if (activeTiles.isNotEmpty && numberOfColumns > activeTiles.length) {
      numberOfColumns = activeTiles.length;
    }
    double columnWidth = screenWidth / numberOfColumns;
    if (columnWidth > WickUtilityStyleConstants.wideWidthSize) {
      columnWidth = WickUtilityStyleConstants.wideWidthSize;
    }
    columnWidth =
        columnWidth -
        ((WickUtilityStyleConstants.paddingSize * 2) / numberOfColumns);
    List<List<WickModelTile>> columnTiles = List.generate(
      numberOfColumns,
      (_) => [],
    );
    for (int index = 0; index < activeTiles.length; index++) {
      int columnIndex = index % numberOfColumns;
      columnTiles[columnIndex].add(activeTiles[index]);
    }
    return columnTiles
        .map(
          (tiles) => SizedBox(
            width: columnWidth,
            child: Column(
              children:
                  tiles
                      .map(
                        (tile) => Padding(
                          padding: EdgeInsets.all(
                            WickUtilityStyleConstants.paddingSize / 2,
                          ),
                          child: WickWidgetCard(
                            icon: tile.icon,
                            title: tile.name,
                            content: tile.content,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        )
        .toList();
  }

  void _onConfigurationChanged(List<Object> updatedTileOptions) {
    if (updatedTileOptions is List<WickModelTileOption>) {
      String configuration = updatedTileOptions
          .where((updatedTileOption) => updatedTileOption.active == true)
          .map((updatedTileOption) => updatedTileOption.name)
          .join(',');
      setState(() {
        _activeConfiguration = configuration;
      });
    }
  }

  void _onApplyChangedConfiguration(
    BuildContext context,
    WickModelDashboardConfiguration? currentConfiguration,
  ) {
    if (_activeConfiguration == null || currentConfiguration == null) {
      return;
    }
    final WickModelDashboardConfiguration changedConfiguration =
        WickModelDashboardConfiguration(
          id: currentConfiguration.id,
          userId: currentConfiguration.userId,
          dashboard: currentConfiguration.dashboard,
          configuration: _activeConfiguration!,
        );
    WickControllerDashboardConfiguration().edit(context, changedConfiguration);
    setState(() {
      _configurationFuture = Future.value(changedConfiguration);
    });
  }
}
