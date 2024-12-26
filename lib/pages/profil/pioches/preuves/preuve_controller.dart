import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class PreuveController extends GetxController {
  //
  Requete requete = Requete();
  //
  Future<bool> envoiePreuve(Map fac) async {
    //
    http.Response response = await requete.postE("deals/deal", fac);
    if (checkRep(response)) {
      //
      Get.back();
      // Get.snackbar(
      //   "Succès",
      //   "Votre facture a été envoyé pour vérification et attribution de points.",
      //   backgroundColor: HexColor("#4AA6B6"),
      //   colorText: Colors.white,
      // );
      return true;
    } else {
      //
      Get.back();
      //
      print("status: ${response.statusCode}");
      print("body: ${response.body}");
      //
      // Get.snackbar(
      //   "Oups",
      //   "Un problème est survenu lors de l'envois de la facture",
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      return false;
    }
  }

  //
  checkRep(http.Response response) {
    return (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202 ||
        response.statusCode == 203 ||
        response.statusCode == 204);
  }
}
