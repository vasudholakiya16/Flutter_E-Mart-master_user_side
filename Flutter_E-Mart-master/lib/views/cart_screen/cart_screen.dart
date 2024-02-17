import 'package:emart_app/consts/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: "Cart is empty"
          .text
          .color(darkFontGrey)
          .fontFamily(semibold)
          .makeCentered(),
    );
  }
}
