import 'dart:io';

import 'package:fleezy/components/BaseScreen.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  static const String id = 'ImageViewerScreen';
  final File photo;

  const ImageViewerScreen({@required this.photo});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      headerText: 'Photo',
      child: Container(
        child: Image.file(photo),
      ),
    );
  }
}
