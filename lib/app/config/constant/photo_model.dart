import 'package:image_picker/image_picker.dart';

/// 사진 모델
class PhotoModel {
  final XFile? file;
  final String? imageUrl;

  PhotoModel({
    this.file,
    this.imageUrl,
  });
}
