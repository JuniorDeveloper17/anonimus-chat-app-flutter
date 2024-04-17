import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/core/color/color.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:clientapp/core/module/module_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class widget_appbar extends StatefulWidget {
  const widget_appbar({
    super.key,
  });

  @override
  State<widget_appbar> createState() => _widget_appbarState();
}

class _widget_appbarState extends State<widget_appbar> {
  @override
  void initState() {
    anonim_c.senStatusRead(status: 'on');
    anonim_c.senOnlineStatus(status: 'on');
    super.initState();
  }

  @override
  void dispose() {
    anonim_c.senStatusRead(status: 'off');
    anonim_c.senOnlineStatus(status: 'off');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 95,
        color: black2,
        width: Get.width,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SizedBox(
            height: 60,
            child: Row(children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.navigate_before_outlined,
                      color: white, size: 25)),
              SizedBox(
                  height: 55,
                  width: 55,
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: light_blue, shape: BoxShape.circle),
                        child: Obx(() => anonim_c.reload.isFalse
                            ? anonim_c.svgCode
                            : SizedBox())),
                    Obx(
                      () => anonim_c.statusOnline.value.status?.value == 'on'
                          ? Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                  color: light_blue,
                                  border: Border.all(color: white, width: 2),
                                  shape: BoxShape.circle))
                          : SizedBox(),
                    )
                  ])),
              SizedBox(width: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'TEMAN ANONIM',
                      style: TextStyle(
                        color: white,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Obx(
                      () => AutoSizeText(
                          anonim_c.statusMengetik.value.status?.value != null &&
                                  anonim_c.statusMengetik.value.sender !=
                                      socket_c.socket.id
                              ? '${anonim_c.statusMengetik.value.status?.value}'
                              : '',
                          style: TextStyle(
                              color: grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic)),
                    )
                  ]),
              Expanded(child: SizedBox()),
              IconButton(
                  onPressed: () {
                    dialog(
                      context: context,
                      title:
                          "yakin kamu ingin meninggalkan room obrolan dengan ini?",
                      action: () => anonim_c.outRoom(),
                    );
                  },
                  icon: Icon(Icons.back_hand, color: red2, size: 25))
            ])));
  }
}
