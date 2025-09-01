import '../../../enums/file_sizes.dart';
import '../../../enums/image_shapes.dart';
import 'base.dart';

class ImageModel extends WickFormInputBase {
  final WickImageShape shape;
  final WickFileSize maxSize;

  ImageModel({
    required super.name,
    super.autoFill,
    super.defaultValue,
    this.shape = WickImageShape.square,
    this.maxSize = WickFileSize.medium,
  });
}
