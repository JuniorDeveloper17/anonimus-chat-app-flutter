import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../core/color/color.dart';
import '../../../domain/model/model_chat.dart';

class ChatBuuble extends StatelessWidget {
  final model_chat data;
  const ChatBuuble({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return data.sender == socket_c.socket.id
        ? InkWell(
            onLongPress: () => anonim_c.senDeleteMessage(data: data),
            child: SwipeTo(
                iconColor: red2,
                onLeftSwipe: (details) => anonim_c.ReplyMessage(data: data),
                child: ChatBubble(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    backGroundColor: blue1,
                    alignment: Alignment.bottomRight,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                    child: item_chat(data: data))),
          )
        : SwipeTo(
            iconColor: red2,
            onLeftSwipe: (details) => anonim_c.ReplyMessage(data: data),
            child: ChatBubble(
                backGroundColor: blue3,
                alignment: Alignment.bottomLeft,
                elevation: 0,
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                child: item_chat(data: data)));
  }
}

class item_chat extends StatelessWidget {
  const item_chat({
    super.key,
    required this.data,
  });

  final model_chat data;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Stack(alignment: Alignment.bottomRight, children: [
          Obx(
            () => data.status?.value == 'dihapus'
                ? Container(
                    width: Get.width / 1.6,
                    height: 40,
                    padding: EdgeInsets.only(bottom: 7),
                    child: Row(children: [
                      Icon(
                        Icons.block,
                        color: grey200,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      AutoSizeText('pesan telah dihapus                ',
                          style: TextStyle(
                              color: grey200,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic))
                    ]))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        data.repliedToId != ''
                            ? Container(
                                decoration: BoxDecoration(
                                    color: data.id == '1' ? blue2 : blue2,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: IntrinsicHeight(
                                    child: Row(children: [
                                  Container(
                                      width: 7.0,
                                      decoration: BoxDecoration(
                                          color: light_blue,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8.0),
                                              topLeft: Radius.circular(8.0)))),
                                  Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("${data.repliedToName}",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                SizedBox(height: 3),
                                                Text("${data.repliedToText}",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: grey200))
                                              ])))
                                ])))
                            : SizedBox(),
                        data.attachmentsType == 'image'
                            ? InkWell(
                                onTap: () => Get.dialog(
                                    view_image(image: data.attachmentsUrl!),
                                    useSafeArea: false),
                                child: Container(
                                    width: Get.width / 2,
                                    height: Get.width / 1.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(base64Decode(
                                                data.attachmentsUrl!))))),
                              )
                            : SizedBox(),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: AutoSizeText('${data.text}              ',
                                style: TextStyle(color: white, fontSize: 15),
                                textAlign: TextAlign.start)),
                        SizedBox(height: 12),
                      ]),
          ),
          Positioned(
              bottom: 5,
              child: Row(children: [
                AutoSizeText(
                    '${DateFormat.Hm().format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(data.timestamp!))}  ',
                    style: TextStyle(color: grey200, fontSize: 10)),
                data.sender == socket_c.socket.id
                    ? Obx(() => data.isRead?.value == 'true'
                        ? Icon(Icons.done_all, size: 13, color: white)
                        : Icon(Icons.done, size: 13, color: grey200))
                    : SizedBox()
              ]))
        ]));
  }
}

class view_image extends StatelessWidget {
  final String image;
  const view_image({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          color: backgroundColor,
          image: DecorationImage(
              fit: BoxFit.contain, image: MemoryImage(base64Decode(image)))),
    );
  }
}
