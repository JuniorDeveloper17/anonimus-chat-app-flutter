import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/core/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/color/color.dart';

class AnonimHome extends StatelessWidget {
  const AnonimHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Obx(() => anonim_c.loading.isFalse ? home() : searching()),
    ));
  }
}

class searching extends StatelessWidget {
  const searching({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          'Searching',
          style: TextStyle(
              color: white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        AutoSizeText(
          'mencari teman dari berbagai lokasi',
          style: TextStyle(
              color: white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 2,
              letterSpacing: 1.2),
        ),
        SizedBox(height: 30),
        LottieBuilder.asset('assets/json/searching2.json'),
        SizedBox(height: 20),
        InkWell(
          onTap: () => anonim_c.cancelSearch(),
          child: Container(
            height: 45,
            width: Get.width / 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: grey200!),
                borderRadius: BorderRadius.circular(5),
                gradient: RadialGradient(colors: [red2, red], radius: 5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'Batalkan Pencarian',
                  style: TextStyle(
                      color: white, fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.search_rounded,
                  color: white,
                  weight: 10,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class home extends StatelessWidget {
  const home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(child: SizedBox()),
      SizedBox(height: 40),
      Shimmer.fromColors(
        baseColor: grey200!,
        highlightColor: white,
        child: AutoSizeText(
          'AnonimusApp',
          style: TextStyle(
              color: white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.3),
        ),
      ),
      SizedBox(height: 40),
      Container(
        width: Get.width / 1.9,
        height: Get.width / 1.9,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                DecorationImage(image: AssetImage('assets/image/image_1.png'))),
      ),
      SizedBox(height: 30),
      InkWell(
        onTap: () => anonim_c.searchFriend(),
        child: Container(
          height: 45,
          width: Get.width / 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: grey200!),
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(colors: [blue, light_blue])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                'Cari teman',
                style: TextStyle(
                    color: white, fontSize: 17, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.search_rounded,
                color: white,
                weight: 10,
                size: 25,
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: AutoSizeText.rich(
          TextSpan(
              style: TextStyle(
                  color: grey, fontSize: 14, fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: 'Cari ',
                  style: TextStyle(
                      color: red, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                TextSpan(text: 'teman '),
                TextSpan(
                  text: 'anonim ',
                  style: TextStyle(
                      color: red, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                TextSpan(text: 'kamu. dan tetap terhubung dengan '),
                TextSpan(
                  text: 'privasi ',
                  style: TextStyle(
                      color: red, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                TextSpan(text: 'kamu tetap terjaga '),
                TextSpan(
                  text: 'klik cari  ',
                  style: TextStyle(
                      color: red, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                TextSpan(text: 'untuk memulai  '),
              ]),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(height: 10),
      Obx(
        () => AutoSizeText(
          'pengguna online ' + socket_c.user_online.value,
          style: TextStyle(color: light_blue, fontSize: 15),
        ),
      ),
      Expanded(child: SizedBox()),
      Image.asset('assets/image/random people.png')
    ]);
  }
}
