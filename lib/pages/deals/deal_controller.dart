import 'dart:convert';

import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';

class DealController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  Future<List> getAllPubs() async {
    //
    //
    Response response = await requete.getE("pubs");
    //
    if (checkRep(response)) {
      //
      return response.body;
    } else {
      //
      return [];
    }
  }

  //
  checkRep(Response response) {
    return (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202 ||
        response.statusCode == 203 ||
        response.statusCode == 204);
  }
}
