import 'dart:async';
import 'dart:typed_data';
import 'package:flow/utils/requete.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id_plus/platform_device_id.dart';
import 'local_notification_service.dart';

class AppController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  var box = GetStorage();
  //
  Future<void> getAllDevices(String token, List devices) async {
    //
    print("devices: $devices");
    //
    //final _mobileDeviceIdentifier =  MobileDeviceIdentifier().getDeviceId();
    //
    String? idTelephone = await await PlatformDeviceId.getDeviceId;
    //
    Map data = {
      "idTelephone": idTelephone,
      "token": token,
      "tokenFb": "cricket-6dd43-firebase-adminsdk-f1a8a-f842fa0876",
      "devices": devices,
    };
    //
    //var response = await http.post(Uri.parse("${Requete.url}/balise"),
    //  body: json.encode(data));
    //
    Response response = await requete.postE("balise", data);
    //
    if (response.statusCode == 200 ||
        response.statusCode == 200 ||
        response.statusCode == 204) {
      //
      print("rep1: ${response.statusCode}");
      print("rep1: ${response.body}");
      //
      //return json.decode(response.body);
    } else {
      print("rep2: ${response.statusCode}");
      print("rep2: ${response.body}");
      //return [];
      //Get.snackbar("Oups", "problème lors de l'enregistrement");
    }
  }

  Future<Uint8List> getImageBytes(String imageUrl) async {
    var response = await http.get(Uri.parse(imageUrl));
    return response.bodyBytes;
  }

  setNotification(Map device) async {
    //idPub
    Uint8List img = await getImageBytes(
        "${Requete.url}/publicite/photo?id=${device['idPub']}");
    //${Requete.urlSt}publicite/photo?id=${pub['id']}
    //https://picsum.photos/id/237/200/300
    AndroidBitmap<Object> androidBitmap = ByteArrayAndroidBitmap(img);
    //Bitmap bitmap = await Bitmap.fromProvider(
    //  const NetworkImage("http://pudim.com.br/pudim.jpg"));
    //
    jaivue("${device['idPub']}");
    //
    LocalNotificationService.display({
      "idPub": "${device["idPub"]}",
      "titre": "${device["titre"]}",
      "lien": "${device["lien"]}",
      "description": "${device["description"]}",
    }, androidBitmap);
    //
  }

  //
  enregistrementAppareils(Map device) async {
    //
    Response response = await requete.postE("balise/save", device);
    //
    if (response.isOk) {
      //
      Get.back();
      Get.snackbar("Succès", "Youpiiiii");
    } else {
      Get.back();
      Get.snackbar("Oups", "problème lors de l'enregistrement");
    }
  }

  //
  Future<void> getAllDevices2(List devs) async {
    //
    Response response = await requete.postE("balise", devs);
    //
    if (response.isOk) {
      //
      List devices = response.body;
      //
      devices.forEach((device) {
        //
        //
        bool v = false;
        //
        int dd = 0;
        //
        devs.forEach((element) {
          if (element["name"] == device["name"] &&
              element["mac"] == device["mac"]) {
            v = true;

            dd = element["rssi"];
            //
            Timer(const Duration(seconds: 1), () {
              print(":::::**** Une notification lancé");
              setNotification(device);
              // LocalNotificationService.display(
              //   {
              //     "titre": "${device["mac"]}",
              //     "description":
              //         "Une notification venant de ${device["name"]}"
              //   },
              // );
            });
            //

            //
          }
        });
        //
      });
      //
      return response.body;
    }
  }

  //
  jaivue(String idPub) async {
    //
    String? idTelephone = await PlatformDeviceId.getDeviceId;
    //
    Response response = await requete
        .getE("publicite/vue?idPub=$idPub&idtelephone=$idTelephone");
    //
    if (response.isOk) {
      //
      print("Rep 1: ${response.statusCode}");
      print("Rep 1: ${response.body}");
      //
    } else {
      //
      print("Rep 2: ${response.statusCode}");
      print("Rep 2: ${response.body}");
      //
    }
  }

  //
  jaiouvert(String idPub) async {
    //
    String? idTelephone = await PlatformDeviceId.getDeviceId;
    //
    Response response = await requete
        .getE("publicite/ouvert?idPub=$idPub&idtelephone=$idTelephone");
    //
    if (response.isOk) {
      //
      print("Rep 1: ${response.statusCode}");
      print("Rep 1: ${response.body}");
      //
      //return response.body;
      //
    } else {
      //
      print("Rep 2: ${response.statusCode}");
      print("Rep 2: ${response.body}");
      //
      //return "";
      //
    }
  }

  //
  sendToken() async {
    //
    String token = box.read("token") ?? "";
    //
    String? ids = await PlatformDeviceId.getDeviceId;
    //
    Map e = {
      "device": ids!,
      "token": token,
      "tokenFb": "cricket-6dd43-firebase-adminsdk-f1a8a-f842fa0876",
    };
    //
    Response response = await requete.postE("utilisateur", e);
    //
    if (response.isOk) {
      //
      print("Rep 1: ${response.statusCode}");
      print("Rep 1: ${response.body}");
      //
    } else {
      //
      print("Rep 2: ${response.statusCode}");
      print("Rep 2: ${response.body}");
      //
    }
  }

  //
}
