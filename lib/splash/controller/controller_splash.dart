import 'package:clientapp/app/anonim/view/anonim_home.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    auth();
    super.onInit();
  }

  Future auth() async {
    await socket_c.socket_init();
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => AnonimHome());
    });
  }
}
