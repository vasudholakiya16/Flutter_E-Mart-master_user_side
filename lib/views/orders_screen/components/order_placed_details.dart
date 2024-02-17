import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
Widget orderPlacedDetails({ title1, title2, d1, d2}){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 7.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$d1".text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
        SizedBox(
          width: 125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$d2".text.color(redColor).fontFamily(semibold).make(),
            ],
          ),
        ),
      ],
    ),
  );
}