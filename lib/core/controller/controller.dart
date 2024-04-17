import 'package:clientapp/app/anonim/controller/anonim_controller.dart';
import 'package:clientapp/data/socket/socket_data.dart';
import 'package:get/get.dart';

final socket_c = Get.put(SocketData(), permanent: true);
final anonim_c = Get.put(AnonimController());
