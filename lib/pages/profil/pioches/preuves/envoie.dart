import 'dart:typed_data';

import 'package:flow/pages/accueil.dart';
import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';

final dio = Dio();

class Envois extends StatelessWidget {
  //
  List images;
  //
  String titreCoupon;
  //
  String idDeal, numeroDeTelephone, code;
  //
  //DealController dealController = Get.find();
  //
  //VendorController controller = Get.find();
  //
  var box = GetStorage();
  //
  Envois(this.images, this.titreCoupon, this.idDeal, this.numeroDeTelephone,
      this.code) {
    //

    //
    //print('utilisateur: $utilisateur');
    //print('fiche: $fiche');
    //
    sendTest();
  }
  ///////////
  @override
  Widget build(Object context) {
    //
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blue.shade100.withOpacity(0.2),
            ),
            child: Obx(() {
              if (images.length > envoyes.value) {
                return SpinKitFadingCube(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  height: 70,
                  width: 70,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.check,
                    size: 50,
                    color: Colors.green,
                  ),
                );
              }
            }),
            // child: SvgPicture.asset(
            //   "assets/SolarCheckCircleLinear.svg",
            //   color: Colors.green.shade700,
            //   width: 80,
            //   height: 80,
            // ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Veuillez patientez svp",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          //
          const SizedBox(
            height: 10,
          ),
          Text(
            titreCoupon,
            textAlign: TextAlign.left,
            style: TextStyle(
              //fontSize: 20,
              color: Colors.green.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //LinearProgressIndicator(),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    "Envoyé",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Obx(
                    () => Text(
                      "${envoyes.value}",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    "Total",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "${images.length}",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //
          const SizedBox(
            height: 30,
          ),
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: quitter.value ? 1 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: Size(Get.size.width, 50),
                backgroundColor:
                    quitter.value ? HexColor("#4AA6B6") : Colors.black45,
              ),
              onPressed: () async {
                //Vendor
                if (quitter.value) {
                  //
                  Get.offAll(Accueil());
                } else {
                  Get.dialog(Center(
                    child: Card(
                      elevation: 1,
                      child: Container(
                        height: 150,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Oups",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Voulez-vous vraiment quitter cette page pendant l'envois dans le serveur ? ",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      fixedSize: Size(100, 40),
                                      backgroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      //
                                      Get.back();
                                      //
                                      Get.offAll(Accueil());
                                    },
                                    child: Text(
                                      " Ok ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                }
              },
              child: const Text(
                "Ok",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  String percentage = "";
  //
  RxString denomination = "".obs;
  //
  RxDouble pr = 0.0.obs;
  //
  RxInt envoyes = 0.obs;
  //
  RxInt invalides = 0.obs;
  //
  RxBool quitter = false.obs;

  sendTest() async {
    //
    int nombreDeFiches = images.length;
    List pioches = box.read("pioches");
    //
    while (nombreDeFiches > 0) {
      //
      //int newNumber = Random.nextInt(100); // Génère un nombre aléatoire entre 0 et 99
      //numbers.add(newNumber);

      print('Nombre à envoyer : $nombreDeFiches');

      // Envoie la donnée au serveur
      //bool success = await sendDataToServer(newNumber);
      nombreDeFiches--;
      // if (success) {
      //   print('Donnée synchronisée avec succès : $newNumber');
      // } else {
      //   print('Échec de synchronisation pour : $newNumber');
      // }
      //denomination.value = images[nombreDeFiches]['data']['name'];
      //
      //Map e = images[nombreDeFiches];
      send(images[nombreDeFiches]);

      //
      //envoyes++;

      //
      // await Future.delayed(
      //   const Duration(seconds: 5),
      // ); // Attend 5 secondes avant de continuer

      // La boucle attend que l'envoi au serveur soit terminé avant de continuer
    }
    //
    pioches.removeWhere((pioche) => '${pioche['id']}' == idDeal);
    //
    box.write("pioches", pioches);
    if (nombreDeFiches <= 0) {
      //
      quitter.value = true;
    }
  }

  Future<bool> send(Uint8List e) async {
    //
    //Map utilisateur = box.read("utilisateur");
    //
    print("-----------------------------------------");
    //print("data: ${jsonEncode(e)}");
    //
    try {
      var res = await http.post(
        Uri.parse(
            "${Requete.url}/deals/image?idDeal=$idDeal&numeroDeTelephone=$numeroDeTelephone&code=$code"),
        body: e, //e["data"],
        headers: {
          "Content-Type": "application/json",
          //"Authorization": "Bearer ${utilisateur['token']}",
        },

        // onSendProgress: (int sent, int total) {
        //   percentage = (sent / total * 100).toStringAsFixed(2);
        //   pr.value = double.parse(percentage);
        //   print("::::::::: $percentage ");
        // },
      );

      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 203 ||
          res.statusCode == 204) {
        print(res.toString());
        envoyes.value++;
        pr.value = 0.0;
        //print response from server
      } else {
        invalides.value--;
        pr.value = 0.0;
        //
        print("Error during connection to server.");
      }
    } catch (e) {
      print("Erreur du à: $e");
    }
    return true;
  }
}
