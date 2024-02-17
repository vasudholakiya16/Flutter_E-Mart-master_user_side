import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class Cartcontroller extends GetxController {
  var totalP = 0.obs;

  //Text controller for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

// text for cart controller
  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];
  var placeOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tPrice'].toString());
    }
  }

// Change Payment method
  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

//Place order
  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placeOrder(true);
    await getProductDetails();

    await firestore.collection(ordersCollections).doc().set({
      'order_code': "24789654",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeContainer>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_country': countryController.text,
      'order_by_postalCode': postalCodeController.text,
      'order_by_phoneNo': phoneController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_conformed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'order_placed': true,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
    });
    placeOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vendor_id': productSnapshot[i]['vendorId'],
        'tPrice': productSnapshot[i]['tPrice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }
    print(products);
  }

// Clear Product method
  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollections).doc(productSnapshot[i].id).delete();
    }
  }
}
