import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/cart_screen/payment_screen.dart';
import 'package:emart_app/widgets_same/custome_text_fild.dart';
import 'package:emart_app/widgets_same/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Cartcontroller>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Patel Transport"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            onpress: () {
              if (controller.addressController.text.length > 10 ||
                  controller.cityController.text.length > 3 ||
                  controller.stateController.text.length > 3 ||
                  controller.countryController.text.length > 3 ||
                  controller.postalCodeController.text.length > 6 ||
                  controller.phoneController.text.length > 10) {
                Get.to(()=>PaymentMethodScreen());
              } else {
                VxToast.show(context, msg: "Please Fill the form");
              }
            },
            color: redColor,
            textColor: Colors.white,
            title: "Continue",
            onPress: () {}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Country",
                isPass: false,
                title: "Country",
                controller: controller.countryController),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalCodeController),
            customTextField(
                hint: "Phone No",
                isPass: false,
                title: "Phone NO",
                controller: controller.phoneController)
          ],
        ),
      ),
    );
  }
}
