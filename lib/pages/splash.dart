import 'dart:async';

import 'package:flow/pages/accueil.dart';
import 'package:flow/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

class Splash extends StatelessWidget {
  Splash() {
    //
    var box = GetStorage();
    //
    Timer(const Duration(seconds: 3), () {
      //
      Map user = box.read("user") ?? {};
      if (user["id"] == null) {
        //
        Get.offAll(Login());
      } else {
        //
        Get.offAll(Accueil());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.size.height,
      width: Get.size.width,
      /*
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/main logo.png")
          )
        ),
        */
      child: Center(
          child: Image.asset(
        "assets/main logo.png",
        width: 200,
      )),
    ));
  }
}
