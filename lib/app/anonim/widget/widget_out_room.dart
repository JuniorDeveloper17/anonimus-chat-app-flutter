import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/core/color/color.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:clientapp/domain/model/model_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class widget_out_room extends StatelessWidget {
  final model_chat data;
  const widget_out_room({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return data.sender != socket_c.socket.id
        ? Column(children: [
            SizedBox(height: 30),
            AutoSizeText('teman kamu telah meinggalkan room obrolan',
                style: TextStyle(
                    color: red2, fontSize: 13, fontWeight: FontWeight.w500)),
            SizedBox(height: 10),
            InkWell(
                onTap: () {
                  anonim_c.id_room.value = '';
                  Get.back();
                  anonim_c.searchFriend();
                },
                child: Container(
                    height: 45,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: white, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [blue, light_blue])),
                    child: AutoSizeText('Cari Teman Baru',
                        style: TextStyle(
                            color: white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)))),
            SizedBox(height: 20)
          ])
        : Column(children: [
            SizedBox(height: 30),
            AutoSizeText(
              'kamu telah meinggalkan room obrolan',
              style: TextStyle(
                  color: light_blue, fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            InkWell(
                onTap: () {},
                child: Container(
                    height: 45,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: white, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [red, red])),
                    child: AutoSizeText('Cari Teman Baru',
                        style: TextStyle(
                            color: white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)))),
            SizedBox(height: 20)
          ]);
  }
}
