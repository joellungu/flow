import 'dart:async';

import 'package:flow/pages/pepites/pepite_controller.dart';
import 'package:flow/pages/profil/loyelty/loyelty_controller.dart';
import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'gagner_controller.dart';

class Gagner extends GetView<GagnerController> {
  //
  PepiteController pepiteController = Get.find();
  //
  Map utilisateur = {};
  //
  var box = GetStorage();
  //
  Gagner() {
    //controller.load();
    //
    utilisateur = box.read("user") ?? {};
    //
  }
  //pepiteController
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pepiteController.getPioches(utilisateur['numeroDeTelephone']),
      builder: (c, t) {
        Timer(const Duration(milliseconds: 200), () {
          pepiteController.points.value = 0;
        });
        if (t.hasData) {
          print("hasData: ${t.hasData}");
          print("data: ${t.data}");
          List pioches = t.data as List;
          //
          return ListView(
            padding: const EdgeInsets.all(10),
            children: List.generate(pioches.length, (index) {
              //
              Map pioche = pioches[index];
              print('pioche: $pioche');
              Timer(const Duration(milliseconds: 200), () {
                pepiteController.points.value = pepiteController.points.value +
                    int.parse("${pioche['points']}");
                //
              });
              return Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${Requete.url}/deals/photo/${pioche['idDeal']}"),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.white,
                              border: Border.all(
                                color: HexColor("#4AA6B6"),
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 5, top: 3, bottom: 3, right: 3),
                          child: RichText(
                            text: TextSpan(
                                text: "Date ${pioche['dateHeure']}\n\n",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                ),
                                children: [
                                  TextSpan(text: "${pioche['description']}")
                                ]),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            height: 80,
                            decoration: BoxDecoration(
                              //color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Pepites acquise",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: HexColor("#4AA6B6"), //Colors.blue,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    "${pioche['points']} Ppt",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        } else if (t.hasError) {
          print("hasError: ${t.hasError}");
          return Container();
        }
        return Center(
          child: Container(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
