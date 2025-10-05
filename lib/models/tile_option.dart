import 'base.dart';

class WickModelTileOption extends WickModelBase<WickModelTileOption> {
  final bool active;
  final String name;

  WickModelTileOption({required this.active, required this.name})
    : super({'active': active, 'name': name});
}
