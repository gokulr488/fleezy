import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageService {
  File _image;
  final imagePicker = ImagePicker();

  Future<File> getImage() async {
    final image = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    _image = File(image?.path);
    return _image;
  }
}
