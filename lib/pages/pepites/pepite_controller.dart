import 'dart:convert';

import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PepiteController extends GetxController with StateMixin<List> {
  //
  RxInt points = 0.obs;
  //
  Requete requete = Requete();
  //
  Future<List> getPioches(String telephone) async {
    //
    http.Response response = await requete.getE("pioches/$telephone");
    //
    if (checkRep(response)) {
      print("rep1: ${response.statusCode}");
      print("rep1: ${response.body}");
      //
      return jsonDecode(response.body);
    } else {
      //
      return [];
    }
  }

  //
  Future<List> getPiochesHistorique(String telephone) async {
    //
    http.Response response =
        await requete.getE("pioches/historique/$telephone");
    //
    if (checkRep(response)) {
      print("rep1: ${response.statusCode}");
      print("rep1: ${response.body}");
      //
      return jsonDecode(response.body);
    } else {
      //
      return [];
    }
  }

  //
  Future<String> echange(String numeroDeTelephone, int idEntreprise,
      double quantite, String devise) async {
    //echange?numeroDeTelephone=815381693&idEntreprise=1&quantite=0.5&devise=USD
    http.Response response = await requete.putE(
        "pioches/echange?numeroDeTelephone=$numeroDeTelephone&idEntreprise=$idEntreprise&quantite=$quantite&devise=$devise",
        "");
    //
    if (checkRep(response)) {
      //
      return response.body;
    } else {
      //
      return response.body;
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
