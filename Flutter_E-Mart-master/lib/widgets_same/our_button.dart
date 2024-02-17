import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';

Widget ourButton(
    {required onpress,
    required Color color,
    required Color textColor,
    required String title,
    required Null Function() onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.all(12),
    ),
    onPressed: onpress,
    child: Text(
      title,
      style: TextStyle(
        color: textColor,
        fontFamily: bold,
      ),
    ),
  );
}
