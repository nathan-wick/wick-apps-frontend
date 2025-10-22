import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/utilities/model_helper.dart';

import '../models/form_inputs/checkbox.dart';
import '../models/preferences.dart';
import '../providers/preferences.dart';
import '../utilities/string_formatter.dart';
import '../utilities/style_constants.dart';
import '../utilities/type_converter.dart';
import '../widgets/loading_indicator.dart';
import 'forms/inputs/checkbox.dart';

class WickWidgetTable<T> extends StatelessWidget {
  final List<T> data;
  final bool displayHeader;
  final bool canReorderRows;
  final List<String> editableColumnKeys;
  final Function(List<T>)? onChanged;

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
    final List<String> columnNames = WickUtilityModelHelper.getAttributesNames(
      T,
    );
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
        await Provider.of<WickProviderPreferences>(context).getValue(context);
    for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
      final Map<String, dynamic> values =
          WickUtilityModelHelper.getAttributeValues(data[rowIndex]);
      List<Widget> columns = [];
      values.forEach((key, value) {
        if (editableColumnKeys.contains(key)) {
          // TODO In the future, we should support other editable types. For now, we only support booleans.
          columns.add(
            WickWidgetFormInputCheckbox(
              input: WickModelFormInputCheckbox(
                name: '$rowIndex:$key',
                displayName: false,
                defaultValue: WickUtilityTypeConverter.toType(value),
              ),
              onChanged: (String? newValue) {
                final Map<String, dynamic> updatedValues = {
                  ...values,
                  key: WickUtilityTypeConverter.toType(newValue),
                };
                final T updatedModel = WickUtilityTypeConverter.toType(
                  updatedValues,
                );
                data[rowIndex] = updatedModel;
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
              child: Text(
                WickUtilityTypeConverter.toType<String>(
                  value,
                  dateFormat: preferences?.dateFormat,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      });
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
