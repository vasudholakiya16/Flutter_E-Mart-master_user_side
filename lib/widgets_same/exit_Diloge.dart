
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_same/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';

Widget exitDialoge(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "conform".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure want to exit?..".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                onpress: () {
                  SystemNavigator.pop();
                },
                color: redColor,
                textColor: whiteColor,
                title: "Yes",
                onPress: () {
                }),
            ourButton(
                onpress: () {Navigator.pop(context);},
                color: redColor,
                textColor: whiteColor,
                title: "No",
                onPress: () {

                })
          ],
        ),
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}

