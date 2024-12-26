import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flow/pages/accueil.dart';
import 'package:flow/pages/vouchers/voucher_controller.dart';
import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PaiementController extends GetxController with StateMixin<List> {
  RxList historique = RxList();
  //
  VoucherController voucherController = Get.find();
  //
  var box = GetStorage();
  //
  RxString reference = "".obs;
  //
  Requete requete = Requete();
  //
  Future<Map> paiement(Map e) async {
    print("message envoyé au serveur: $e");
    http.Response rep = await requete.postE("paiement/paie", e);
    print("la reponse du serveur: ${rep.statusCode}");
    print("la reponse du serveur: ${rep.body}");

    if (checkRep(rep)) {
      return jsonDecode(rep.body);
    } else {
      return {"erreur": rep.statusCode};
    }
  }

  Future<Map> checkPaiement(String orderNumer) async {
    //
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.bluetooth)) {
      //
      http.Response rep = await requete.getE("paiement/check/$orderNumer");
      print("la reponse du serveur: ${rep.statusCode}");
      print("la reponse du serveur: ${rep.body}");

      if (checkRep(rep)) {
        return jsonDecode(rep.body);
      } else {
        return {
          "transaction": {"status": 2}
        };
      }
    } else {
      //repCheck["transaction"]['status']
      return {
        "transaction": {"status": 2}
      };
    }
    //
  }

  //
  Future<void> achatTicket(List le, String telephone) async {
    http.Response rep =
        await requete.putE("coupon/transfere?telephone=$telephone", le);
    //print("la reponse du serveur: ${rep.statusCode}");
    //print("la reponse du serveur: ${rep.body}");

    if (checkRep(rep)) {
      List cps = jsonDecode(rep.body);
      List l = box.read("mescoupons") ?? [];
      cps.forEach((c) {
        l.add(c);
      });
      box.write("mescoupons", l);
      box.write("coupons", []);
      //
      voucherController.couponsEnregistre.clear();
      voucherController.total.value = 0;
      //
      DateTime dateTime = DateTime.now();
      //
      Map e = {
        "date": "${dateTime.day}-${dateTime.month}-${dateTime.year}",
        "tickes": rep.body,
      };
      Get.back();
      Get.offAll(Accueil());
      //eturn rep.body;
    } else {
      Get.back();
      Get.snackbar("Erreur", "Un problème est survenu lors de l'achat");
      //return {"erreur": rep.statusCode};
    }
  }

  //
  Future<Map> saveTicket(Map e) async {
    http.Response rep = await requete.postE("tickets", e);
    print("la reponse du serveur: ${rep.statusCode}");
    print("la reponse du serveur: ${rep.body}");

    if (checkRep(rep)) {
      return jsonDecode(rep.body);
    } else {
      return {"erreur": rep.statusCode};
    }
  }

  // Future<Map> verification(String orderNumber) async {
  //   //flexpay
  //   //Uri.parse("http://41.243.7.46:3006/api/rest/v1/check/$orderNumber"),
  //   var rep = await requete.getEE(
  //     "http://41.243.7.46:3006/api/rest/v1/check/$orderNumber",
  //     {
  //       "Content-Type": "application/json",
  //       "Authorization":
  //           "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJcL2xvZ2luIiwicm9sZXMiOlsiTUVSQ0hBTlQiXSwiZXhwIjoxNzQ2MTg5MDk2LCJzdWIiOiJlYWVjMjJmYjIzZDRmYzIxYjc1ZmViZTdjYThjNmEyOSJ9.V36-U2YBmK5WuIR2jz6fMIt6VcsGzdn_38205UygYT8",
  //     },
  //   );
  //   /**
  //    * timeout(
  //     const Duration(minutes: 1),
  //     onTimeout: () {
  //       // Time has run out, do what you wanted to do.
  //       return http.Response(
  //           'Error', 408); // Request Timeout response status code
  //     },
  //   );
  //    */
  //   print(rep.statusCode);
  //   print(rep.body);
  //   //Response rep = await requete
  //   //  .get("http://41.243.7.46:3006/flexpay/api/rest/v1/$orderNumber");
  //   if (rep.isOk) {
  //     return rep.body;
  //   } else {
  //     return rep.body;
  //   }
  // }

  getAllBusTranson() async {
    Timer(Duration(seconds: 3), () {
      change([
        {"id": "1234567890"}
      ], status: RxStatus.success());
    });
  }

  ///
  Future<Map> getCompanie(String id) async {
    http.Response rep = await requete.getE("companie/$id");
    if (checkRep(rep)) {
      return jsonDecode(rep.body);
    } else {
      return {};
    }
  }

  //
  Future<Map> getBuss(String id) async {
    http.Response rep = await requete.getE("bus/via/$id");
    if (checkRep(rep)) {
      return jsonDecode(rep.body);
    } else {
      return {};
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
