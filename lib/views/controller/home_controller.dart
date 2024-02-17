import 'package:emart_app/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeContainer extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getUsername();
    super.onInit();
  }

  var CurrentNavIndex = 0.obs;
  var username = '';
  var searchController=TextEditingController();
  getUsername() async {
    var n = await firestore
        .collection(userCollections)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    // print(username);
  }
}
