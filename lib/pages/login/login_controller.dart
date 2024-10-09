import 'package:flow/pages/accueil.dart';
import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  var box = GetStorage();
  //
  login(String email, String mdp) async {
    //
    Response response = await requete.getE("utilisateur/login/$email/$mdp");
    if (response.isOk) {
      //
      Get.back();
      box.write("user", response.body);
      //
      Get.offAll(Accueil());
    } else {
      //
      Get.back();
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
      //
      Get.snackbar(
        "Oups",
        "Votre email (Téléphone) ou votre mdp est incorrecte.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //
  creerCompte(Map e) async {
    //
    Response response = await requete.postE("utilisateur", e);
    if (response.isOk) {
      //
      Get.back();
      box.write("user", response.body);
      //
      Get.offAll(Accueil());
    } else {
      //
      Get.back();
      //
      Get.snackbar(
        "Oups",
        response.body,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
