// created by `flutter pub run build_runner build`

import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/objectbox.g.dart';

class ObjectBox {
  ObjectBox._create(this.store) {
    reportsBox = store.box<ModelReport>();
    // Add any additional setup code, e.g. build queries.
  }

  Box<ModelReport> reportsBox;

  /// The Store of this app.
  final Store store;

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBox._create(store);
  }
}
