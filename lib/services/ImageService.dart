import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker imagePicker = ImagePicker();

  Future<File> getImage() async {
    final XFile image = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 35);
    return File(image?.path);
  }
}
