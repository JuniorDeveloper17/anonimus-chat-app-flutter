import 'package:clientapp/app/anonim/module/anonim_chat/widget_appbar.dart';
import 'package:clientapp/app/anonim/module/anonim_chat/widget_body.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../module/anonim_chat/widget_footer.dart';

class AnonimChat extends StatelessWidget {
  const AnonimChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
              children: [widget_appbar(), widget_body(), SizedBox(height: 85)]),
          Obx(() => anonim_c.image.value == null ? SizedBox() : image_sen()),
          widget_footer()
        ],
      ),
    );
  }
}
