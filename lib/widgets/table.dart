import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/base.dart';
import '../models/forms/inputs/checkbox.dart';
import '../models/preferences.dart';
import '../providers/preferences.dart';
import '../utilities/string_formatter.dart';
import '../utilities/style_constants.dart';
import '../utilities/type_converter.dart';
import '../widgets/loading_indicator.dart';
import 'forms/inputs/checkbox.dart';

class WickWidgetTable extends StatelessWidget {
  final List<WickModelBase> data;
  final bool displayHeader;
  final bool canReorderRows;
  final List<String> editableColumnKeys;
  final Function(List<WickModelBase>)? onChanged;

  const WickWidgetTable({
    super.key,
    required this.data,
    this.displayHeader = true,
    this.canReorderRows = false,
    this.editableColumnKeys = const [],
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Widget noDataMessage = const Center(
      child: Text('No data available.'),
    );
    if (data.isEmpty) {
      return noDataMessage;
    }
    return FutureBuilder<List<TableRow>>(
      future: _getRows(context),
      builder: (context, snapshot) {
        final rows = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WickWidgetLoadingIndicator();
        }
        if (rows == null || rows.isEmpty) {
          return noDataMessage;
        }
        return Table(children: rows);
      },
    );
  }

  Future<List<TableRow>> _getRows(BuildContext context) async {
    final List<String> columnNames = data.first.attributes.keys.toList();
    final List<int> editableColumnIndexes =
        editableColumnKeys
            .map((editableColumnKey) => columnNames.indexOf(editableColumnKey))
            .toList();
    List<TableRow> rows = [];
    if (displayHeader) {
      final TableRow header = TableRow(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            WickUtilityStyleConstants.boarderRadius,
          ),
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        ),
        children:
            columnNames
                .map(
                  (columnName) => Padding(
                    padding: EdgeInsets.all(
                      WickUtilityStyleConstants.paddingSize,
                    ),
                    child: Text(
                      WickUtilityStringFormatter.titleCase(columnName),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                .toList(),
      );
      rows.add(header);
    }
    WickModelPreferences? preferences =
        await Provider.of<WickProviderPreferences>(context).getValue();
    for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
      final List<String?> values =
          data[rowIndex].toStringMap(preferences?.dateFormat).values.toList();
      List<Widget> columns = [];
      for (int columnIndex = 0; columnIndex < values.length; columnIndex++) {
        final value = values[columnIndex];
        if (editableColumnIndexes.contains(columnIndex)) {
          // TODO In the future, we should support other editable types. For now, we only support booleans.
          columns.add(
            WickWidgetFormInputCheckbox(
              input: WickModelFormInputCheckbox(
                name: '$rowIndex:$columnIndex',
                displayName: false,
                defaultValue: WickUtilityTypeConverter.toBool(value).toString(),
              ),
              onChanged: (String? newValue) {
                final updatedAttributes = Map<String, dynamic>.from(
                  data[rowIndex].attributes,
                );
                updatedAttributes[columnNames[columnIndex]] = newValue;
                data[rowIndex] = data[rowIndex].copyWith(updatedAttributes);
                if (onChanged != null) onChanged!(data);
              },
            ),
          );
        } else {
          columns.add(
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: WickUtilityStyleConstants.paddingSize,
                horizontal: WickUtilityStyleConstants.paddingSize / 4,
              ),
              child: Text(value ?? '', textAlign: TextAlign.center),
            ),
          );
        }
      }
      rows.add(
        TableRow(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              WickUtilityStyleConstants.boarderRadius,
            ),
            color:
                (displayHeader ? rowIndex.isOdd : rowIndex.isEven)
                    ? Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withValues(alpha: 0.6)
                    : null,
          ),
          children: columns,
        ),
      );
    }

    return rows;
  }
}
