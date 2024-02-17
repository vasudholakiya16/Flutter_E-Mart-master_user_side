import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.size(16).fontFamily(bold).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  ).box.white.rounded.width(width).height(60).padding(EdgeInsets.all(4)).make();
}
