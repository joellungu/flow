import 'dart:convert';

import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VoucherController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxDouble total = 0.0.obs;
  //
  RxList couponsEnregistre = [].obs;
  //
  RxString coupon = "".obs;
  //
  getAllCoupons() async {
    //
    change([], status: RxStatus.loading());
    //
    http.Response response = await requete.getE("coupon/all");
    //
    if (checkRep(response)) {
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
      //
      change(jsonDecode(response.body), status: RxStatus.success());
    } else {
      //
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
      change([], status: RxStatus.empty());
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
