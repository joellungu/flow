import 'dart:convert';

import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BoutiqueController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxString coupon = "".obs;
  //
  getAllDeals() async {
    //
    //change([], status: RxStatus.loading());
    //
    String boutique = "boutique";
    http.Response response = await requete.getE("deals");
    //
    if (checkRep(response)) {
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
      //
      return jsonDecode(response.body);
    } else {
      //
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
      return [];
    }
  }

  load() async {
    change([], status: RxStatus.success());
  }

  //
  getPioche(Map pioche) async {
    //
    //change([], status: RxStatus.loading());
    //
    String boutique = "boutique";
    http.Response response = await requete.postE("pioches", pioche);
    //
    if (checkRep(response)) {
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
    } else {
      //
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
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
