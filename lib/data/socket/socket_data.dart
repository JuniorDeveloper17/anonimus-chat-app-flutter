import 'package:clientapp/core/controller/controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';

class SocketData extends GetxController {
  late IO.Socket socket;
  RxString user_online = ''.obs;

  Future<bool?> socket_init() async {
    socket = IO.io('http://192.168.46.71:3000/', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    if (!socket.connected) {
      socket.connect();
      socket.onConnect((data) {
        anonim_c.listenMessage();
        socket
            .emit('user_online', {"room": 'user_online', 'sender': socket.id});
        socket.on('user_online', (data) {
          user_online.value = data.toString();
        });
        print('socket terhubung');
        return true;
      });
    } else {
      print('socket terputus');
      return false;
    }
    return null;
  }
}
