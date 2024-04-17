import 'package:auto_size_text/auto_size_text.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:clientapp/core/color/color.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class widget_footer extends StatelessWidget {
  const widget_footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MessageBar(
        replying: anonim_c.replay.value,
        messageBarColor: backgroundColor,
        replyWidgetColor: grey200!,
        replyCloseColor: grey,
        onTextChanged: (p0) {
          p0 == ''
              ? anonim_c.senStatusMengetik(status: '')
              : anonim_c.senStatusMengetik(status: 'mengetik');
        },
        messageBarHitText: ' Tulis pesan ...',
        sendButtonColor: light_blue,
        onSend: (_) => anonim_c.senMessage(text: _),
        replyingTo: anonim_c.replay.value == false
            ? ""
            : anonim_c.replayMessage.value.repliedToText!,
        onTapCloseReply: () => anonim_c.replay.value = false,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 2, right: 8),
            child: InkWell(
                child: Icon(Icons.image, color: green, size: 25),
                onTap: () => anonim_c.getImage(camera: false)),
          ),
          InkWell(
              child: Icon(Icons.camera_alt, color: white, size: 25),
              onTap: () => anonim_c.getImage(camera: true)),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}

class image_sen extends StatelessWidget {
  const image_sen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 80,
      width: Get.width,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: Get.width,
            color: black2,
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      anonim_c.image.value = null;
                    },
                    icon: Icon(
                      Icons.cancel,
                      size: 25,
                      color: white,
                    )),
                AutoSizeText('Batalkan',
                    style: TextStyle(color: white, fontSize: 15))
              ],
            ),
          ),
          Expanded(child: Image.memory(anonim_c.image.value!)),
        ],
      ),
    );
  }
}
