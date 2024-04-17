import 'package:clientapp/core/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:get/get.dart';

YYDialog dialog(
    {required BuildContext context,
    required String title,
    required VoidCallback action}) {
  return YYDialog().build(context)
    ..width = Get.width / 1.5
    ..decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: white, width: 0.6),
        color: black)
    ..text(
        padding: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        text: "${title}",
        color: red2,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center)
    ..divider()
    ..doubleButton(
        padding: EdgeInsets.only(top: 10.0),
        gravity: Gravity.spaceEvenly,
        withDivider: true,
        text1: "tidak",
        color1: grey,
        fontSize1: 14.0,
        fontWeight1: FontWeight.bold,
        onTap1: () {},
        text2: "yakin",
        color2: light_blue,
        fontSize2: 14.0,
        fontWeight2: FontWeight.bold,
        onTap2: action)
    ..show();
}
