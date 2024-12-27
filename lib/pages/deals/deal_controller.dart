import 'dart:convert';

import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DealController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  Future<List> getAllPubs() async {
    //
    //
    http.Response response = await requete.getE("pubs");
    //
    if (checkRep(response)) {
      //
      return jsonDecode(response.body);
    } else {
      //
      return [];
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
