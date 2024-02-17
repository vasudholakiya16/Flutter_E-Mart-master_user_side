
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/cart_screen/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/list_tile.dart';
import 'package:get/get.dart';

import '../../consts/loadingIndicator.dart';
import '../../services/firestore_services.dart';
import '../../widgets_same/our_button.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(Cartcontroller());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar:
      SizedBox(
        width: context.screenWidth - 60,
        height: 60,
        child: ourButton(
          onpress: () {
            Get.to(()=> const ShippingDetails());
          },
          color: redColor,
          textColor: whiteColor,
          title: "Proceed to shopping",
          onPress: () {},
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot.data?.size);
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is Empty".text.make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot=data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                         leading: SizedBox(width:50,height: 50,child: Image.network(data[index]['img'][0].toString())),
                          title: "${data[index]['title']} (${data[index]['qty']})"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: "${data[index]['tPrice']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),
                          trailing: Icon(Icons.delete,color: redColor).onTap(() {
                            FireStoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(()=>"${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightGrey)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  // SizedBox(
                  //   width: context.screenWidth - 60,
                  //   child: ourButton(
                  //     onpress: () {},
                  //     color: redColor,
                  //     textColor: whiteColor,
                  //     title: "Proceed to shopping",
                  //     onPress: () {},
                  //   ),
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
