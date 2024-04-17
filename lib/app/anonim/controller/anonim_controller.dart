import 'dart:convert';
import 'package:clientapp/app/anonim/view/anonim_chat.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:clientapp/data/controller/controller.dart';
import 'package:clientapp/data/socket/socket_static.dart';
import 'package:clientapp/domain/model/model_chat.dart';
import 'package:clientapp/domain/model/model_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class AnonimController extends GetxController {
  StaticRandom r = StaticRandom();
  RxBool loading = false.obs;
  RxString id_room = ''.obs;

  Future searchFriend() async {
    if (id_room.value == '') {
      loading.value = true;
      socket_c.socket.emit(r.cari_pasangan, socket_c.socket.id);
      socket_c.socket.on(r.di_temukan, (data) {
        id_room.value = data.toString();
        socket_c.socket.emit(r.join_room, id_room.value);
        svgCode = RandomAvatar(DateTime.now().toIso8601String());
        Future.delayed(Duration(seconds: 2), () {
          loading.value = false;
          Get.to(() => AnonimChat(),
              transition: Transition.size, duration: Duration(seconds: 2));
        });
      });
    } else {
      Get.to(() => AnonimChat(),
          transition: Transition.size, duration: Duration(seconds: 2));
    }
  }

  Future cancelSearch() async {
    if (id_room.value == '') {
      socket_c.socket.emit(r.batal_cari_pasangan);
      loading.value = false;
    }
  }

  Future outRoom() async {
    var data = model_chat(
      id: id_room.value,
      sender: socket_c.socket.id,
      name: socket_c.socket.id,
      text: '',
      timestamp: '${DateTime.now()}',
      isRead: 'false'.obs,
      status: 'out'.obs,
      attachmentsType: 'text',
      attachmentsUrl: '',
      repliedToId: "",
      repliedToName: "",
      repliedToText: "",
      repliedToTimestamp: "",
    );
    socket_c.socket.emit(r.keluar_room, data);
    anonim_c.senOnlineStatus(status: 'off');
    id_room.value = '';
    Get.back();
  }

  Widget svgCode = SizedBox();
  Rx<model_status> statusOnline = model_status().obs;
  Rx<model_status> statusMengetik = model_status().obs;
  Rx<model_status> statusRead = model_status().obs;

  void senOnlineStatus({required String status}) {
    var data = model_status(
        id: id_room.value, sender: socket_c.socket.id, status: status.obs);
    socket_c.socket.emit(r.status_online, data);
  }

  void senStatusMengetik({required String status}) {
    var data = model_status(
        id: id_room.value, sender: socket_c.socket.id, status: status.obs);
    socket_c.socket.emit(r.mengetik, data);
  }

  void senStatusRead({required String status}) {
    var data = model_status(
        id: id_room.value, sender: socket_c.socket.id, status: status.obs);
    socket_c.socket.emit(r.read_status, data);
  }

  RxList<model_chat> message = <model_chat>[].obs;
  Rx<model_chat> replayMessage = model_chat().obs;
  RxBool replay = false.obs;

  void listenMessage() {
    socket_c.socket
        .on(r.pesan, (data) => message.add(model_chat.fromJson(data)));
    socket_c.socket.on(r.status_online,
        (data) => statusOnline.value = model_status.fromJson(data));
    socket_c.socket.on(r.keluar_room, (data) {
      message.add(model_chat.fromJson(data));
      svgCode = SizedBox();
      reloadEvent();
    });
    socket_c.socket.on(r.hapus_pesan,
        (data) => deleteMessage(data: model_delete.fromJson(data)));
    socket_c.socket.on(r.read_status, (data) {
      statusRead.value = model_status.fromJson(data);
      changeStatusMessage(data: model_status.fromJson(data));
    });
    socket_c.socket.on(r.mengetik, (data) {
      if (data['sender'] != socket_c.socket.id) {
        statusMengetik.value = model_status.fromJson(data);
      }
    });
  }

  void ReplyMessage({required model_chat data}) {
    replayMessage.value.repliedToId = data.id;
    replayMessage.value.repliedToName = data.name;
    replayMessage.value.repliedToText = data.text;
    replayMessage.value.repliedToTimestamp = data.timestamp;
    replay.value = true;
  }

  void senMessage({required String text}) {
    var data = model_chat(
      id: id_room.value,
      sender: socket_c.socket.id!,
      name: socket_c.socket.id!,
      text: text,
      timestamp: '${DateTime.now()}',
      isRead: statusRead.value.status?.value == 'on' ? 'true'.obs : 'false'.obs,
      status: ''.obs,
      repliedToId: replay.isFalse ? "" : replayMessage.value.repliedToId,
      repliedToName: replay.isFalse ? "" : replayMessage.value.repliedToName,
      repliedToText: replay.isFalse ? "" : replayMessage.value.repliedToText,
      repliedToTimestamp:
          replay.isFalse ? "" : replayMessage.value.repliedToTimestamp,
      attachmentsType: image.value == null ? 'text' : 'image',
      attachmentsUrl: image.value == null ? '' : base64Encode(image.value!),
    );
    image.value = null;
    replay.value = false;
    socket_c.socket.emit(r.pesan, data);
    senStatusMengetik(status: '');
    FocusScope.of(Get.context as BuildContext).requestFocus(new FocusNode());
  }

  void senDeleteMessage({required model_chat data}) {
    message.forEach((chat) {
      if (data.sender == socket_c.socket.id) {
        socket_c.socket.emit(r.hapus_pesan,
            model_delete(id: id_room.value, timestamp: data.timestamp));
      }
    });
  }

  void deleteMessage({required model_delete data}) {
    Future.forEach(message, (element) {
      if (element.timestamp == data.timestamp) {
        element.status?.value = 'dihapus';
      }
    });
  }

  void changeStatusMessage({required model_status data}) {
    Future.forEach(message, (element) {
      if (element.sender != data.sender &&
          element.isRead?.value == 'false' &&
          data.status?.value == 'on') {
        element.isRead?.value = 'true';
      }
    });
  }

  Rx<Uint8List?> image = Rx<Uint8List?>(null);

  Future getImage({required bool camera}) async {
    final data = await ControllerData().getImageGalery(camera: camera);
    if (data != null) {
      image.value = data;
    }
  }

  RxBool reload = false.obs;
  Future reloadEvent() async {
    reload.value = true;
    Future.delayed(Duration(microseconds: 100), () async {
      reload.value = false;
    });
  }
}
