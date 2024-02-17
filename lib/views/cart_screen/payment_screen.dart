import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/consts/loadingIndicator.dart';
import 'package:emart_app/views/controller/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets_same/our_button.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Cartcontroller>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placeOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onpress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Placed successfully");
                    Get.offAll(Home());
                  },
                  color: redColor,
                  textColor: Colors.white,
                  title: "Place my order",
                  onPress: () {}),
        ),
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(scrollDirection: Axis.vertical, children: [
            Obx(
              () => Column(
                children: List.generate(paymentMethodImg.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),

                          border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      )),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Stack(alignment: Alignment.topRight, children: [
                        Image.asset(
                          paymentMethodImg[index],
                          height: context.screenHeight * 0.20,
                          width: context.screenWidth / 1.2,
                          fit: BoxFit.cover,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                      ]),
                    ),
                  );
                }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
