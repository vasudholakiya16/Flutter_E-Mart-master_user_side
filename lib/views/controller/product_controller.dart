import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class productController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subcat = [];
  var isFav = false.obs;
  getSubCategories(title) async {
    subcat.clear();
    var data =
        await rootBundle.loadString("lib/services/categories_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, sellerName, color, qty, tPrice, context, vender_id}) async {
    await firestore.collection(cartCollections).doc().set({
      'title': title,
      'img': img,
      'sellerName': sellerName,
      'color': color,
      'qty': qty,
      'vendorId': vender_id,
      'tPrice': tPrice,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  // add to wishlist
  addToWishlist(docId, context) async {
    await firestore.collection(productCollections).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Add to wishlist");
  }

  // remove to wishlist
  removeFromWishlist(docId, context) async {
    await firestore.collection(productCollections).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }
  // checkIfFav(data) async{
  //   if(data['p_wishlist'].contins(currentUser!.uid)){
  //     isFav(true);
  //   }else{
  //     isFav(false);
  //   }
  // }
}
