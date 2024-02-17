import 'package:emart_app/consts/consts.dart';

class FireStoreServices {
  static getUser(uid) {
    // Get user Data
    return firestore
        .collection(userCollections)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}
