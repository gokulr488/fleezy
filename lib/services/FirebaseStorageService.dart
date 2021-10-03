import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageService {
  static UploadTask uploadFile(String destination, File file) {
    try {
      final Reference ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
