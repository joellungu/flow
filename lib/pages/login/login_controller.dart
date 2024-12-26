import 'dart:convert';

import 'package:flow/pages/accueil.dart';
import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  //
  Requete requete = Requete();
  //
  var box = GetStorage();
  //
  creerCompte(Map e) async {
    //
    http.Response response = await requete.postE("utilisateurs", e);
    //
    if (checkRep(response)) {
      //
      box.write("user", jsonDecode(response.body));
      //
      Get.back();
      Get.offAll(Accueil());
    } else {
      //
      Get.back();
      Get.snackbar("Oups erreur: ${response.statusCode}",
          "Quelque chose c'est mal passé, veuillez reessayer ou contacter le service");
    }
  }

  //
  login(String telephone, String mdp) async {
    //
    http.Response response = await requete.getE(
        "utilisateurs/login?numeroDeTelephone=$telephone&motDePasse=$mdp");
    //
    if (checkRep(response)) {
      //
      box.write("user", jsonDecode(response.body));
      //
      Get.back();
      Get.offAll(Accueil());
    } else {
      //
      Get.back();
      Get.snackbar("Oups erreur: ${response.statusCode}", response.body);
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
