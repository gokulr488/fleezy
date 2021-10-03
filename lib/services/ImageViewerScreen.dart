import 'dart:io';

import 'package:fleezy/components/BaseScreen.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({@required this.photo});
  static const String id = 'ImageViewerScreen';
  final File photo;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      headerText: 'Photo',
      child: Image.file(photo),
    );
  }
}
