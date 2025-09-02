import '../../../enums/file_sizes.dart';
import '../../../enums/image_shapes.dart';
import 'base.dart';

class WickModelFormInputImage extends WickModelFormInputBase {
  final WickEnumImageShape shape;
  final WickEnumFileSize maxSize;

  WickModelFormInputImage({
    required super.name,
    super.autoFill,
    super.defaultValue,
    this.shape = WickEnumImageShape.square,
    this.maxSize = WickEnumFileSize.medium,
  });
}
