import 'dart:convert';

import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/request/request.dart';

class ContactsController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  getAllContact(List numeraux) async {
    change([], status: RxStatus.loading());
    http.Response response =
        await requete.postE("utilisateur/contacts", numeraux);
    if (checkRep(response)) {
      change(jsonDecode(response.body), status: RxStatus.success());
    } else {
      change(jsonDecode(response.body), status: RxStatus.success());
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
