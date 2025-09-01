import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

import '../enums/file_sizes.dart';

class WickUtilityImageEngine {
  static Future<Uint8List> compress(
    Uint8List imageBytes, [
    WickFileSize maxSize = WickFileSize.medium,
  ]) async {
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception("Invalid image. Please try another image.");
    }
    int quality = 100;
    late Uint8List compressedBytes;
    Future<Uint8List> compressWithQuality(int q) async {
      return await compute(
        (Map<String, dynamic> args) => Uint8List.fromList(
          img.encodeJpg(args['image'], quality: args['quality']),
        ),
        {'image': image, 'quality': q},
      );
    }

    compressedBytes = await compressWithQuality(quality);
    while (compressedBytes.length > maxSize.value) {
      double overshootRatio = compressedBytes.length / maxSize.value;
      quality ~/= overshootRatio;
      if (quality > 1) {
        compressedBytes = await compressWithQuality(quality);
      } else {
        int newWidth = image!.width ~/ overshootRatio;
        int newHeight = image.height ~/ overshootRatio;
        image = await compute(
          (Map<String, dynamic> args) => img.copyResize(
            args['image'],
            width: args['width'],
            height: args['height'],
            interpolation: img.Interpolation.average,
          ),
          {'image': image, 'width': newWidth, 'height': newHeight},
        );
        quality = 100;
        compressedBytes = await compressWithQuality(quality);
      }
    }
    return compressedBytes;
  }
}
