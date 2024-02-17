import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splesh_screen/splesh_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../category_card/category_details.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make().onTap(() {
Get.to(()=>CategoryDetail(title:title));
  });
}
