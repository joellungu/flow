import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';
import 'paiement_controller.dart';
import 'verification_paiement.dart';

class Paiement extends StatefulWidget {
  //
  List v;
  //
  //Map commande;
  //

  Paiement(this.v) {
    List x = v;
    print(x);
  }
  //
  @override
  State<StatefulWidget> createState() {
    return _Paiement();
  }
}

class _Paiement extends State<Paiement> {
  //

  //
  RxString choix = "CDF".obs;
  RxString CDF = "CDF".obs;
  RxString USD = "USD".obs;
  //
  //ReservationController reservationController = Get.find();
  //
  PaiementController paiementController = Get.find();
  //
  TextEditingController numero = TextEditingController();
  //
  double montant = 0.0;
  //
  //Timer? t;
  @override
  void initState() {
    //
    super.initState();
    //montant/nombre;prix
    widget.v.forEach((element) {
      montant = montant + (element['quantite'] * element['prix']);
    });
    //
    Map e = {
      "reference": getReference(),
      "phone": "",
      "amount": montant,
      "currency": "USD",
    };
  }

  //
  //List le = [];
  //
  @override
  void dispose() {
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#4AA6B6"),
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Paiement",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: HexColor("#4AA6B6"),
            leading: IconButton(
              onPressed: () {
                //
                Get.back();
                //
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          //backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(children: [
                  Container(
                    height: Get.size.height / 13,
                    color: Colors.indigo.shade100,
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          color: Colors.indigoAccent.shade400,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Payez avec tous les réseaux en RDC et en toute sécurité.",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            autofocus: true,
                            controller: numero,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefix: Text(
                                "+243  ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.phone_android_outlined,
                                color: Colors.white70,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //getDetails("${widget.e['idPartenaire']}"),
                      ],
                    ),
                  ),
                ]),
              ),
              //////////
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                ),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        //color: Colors.grey,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: RichText(
                          text: TextSpan(
                            text: "Prix total\n",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "$montant USD",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () async {
                          //
                          DateTime dateTime = DateTime.now();
                          String d =
                              "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                          //
                          print("Salut comment ?");
                          //String parametres =
                          //  "12-12-2023,15:00,+243,815381693,80500,CDF,kinshasa,kilongo,2,12-13,12345,false";
                          //
                          if (numero.text.length >= 9) {
                            print("le numéro:" "243" + numero.text);
                            //
                            PaiementController paiementController = Get.find();
                            //
                            // Get.dialog(
                            //   const Material(
                            //     color: Colors.transparent,
                            //     child: Center(
                            //       child: SizedBox(
                            //         height: 40,
                            //         width: 40,
                            //         child: CircularProgressIndicator(),
                            //       ),
                            //     ),
                            //   ),
                            // );
                            var ref = getReference();
                            ref = ref.replaceAll("-", "");
                            //referencePaiement = ref;
                            DateTime d = DateTime.now();
                            /***/
                            widget.v.forEach((element) {
                              element["telephone"] = "00243${numero.text}";
                              element["reference"] = ref;
                            });
                            // Map e = {
                            //   "merchant": "JOSBARK",
                            //   "status": 0,
                            //   "date": "${d.day}/${d.month}/${d.year}",
                            //   "phone": "243${numero.text}",
                            //   "amount": widget.e['prix'] * 1,
                            //   "currency": "CDF",
                            //   "reference": ref,
                            //   "callbackurl": "www.google.com",
                            // };
                            //
                            //double mont = 0.0;
                            //////////////Le ticket
                            /**
                             * Le contenu non pas le contenant...
                             */

                            //
                            Get.dialog(
                              Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: VerificationPaiement(
                                    widget.v,
                                    devise: "USD",
                                    telephone: "243${numero.text}",
                                    montant: montant,
                                    ref: ref,
                                  ),
                                ),
                              ),
                            );
                            //
                            // Get.to(
                            //   VerificationPaiement(
                            //     widget.v,
                            //     devise: "USD",
                            //     montant: montant,
                            //     ref: ref,
                            //   ),
                            // );
                            //
                            //send(le);
                            //////////////
                          } else {
                            Get.snackbar("Erreur", "Le numéro est incorrecte");
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          color: HexColor("#4AA6B6"),
                          alignment: Alignment.center,
                          child: const Text(
                            "Acheter",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     //
          //     Get.dialog(Material(
          //       color: Colors.transparent,
          //       child: Center(
          //         child: VerificationPaiement(le),
          //       ),
          //     ),);
          //   },
          //   child: Icon(Icons.check),
          // ),
        ),
      ),
    );
  }

  Widget getDetails(String idPartenaire) {
    return FutureBuilder(
        future: paiementController.getCompanie(idPartenaire),
        builder: (c, t) {
          if (t.hasData) {
            Map d = t.data as Map;
            return Text.rich(
              TextSpan(
                text: 'Paiemant de ${1} billets de la compagnie ',
                style: const TextStyle(
                  fontSize: 25,
                ),
                children: [
                  TextSpan(
                    text: "${d['nom']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            );
          } else if (t.hasError) {
            return Container();
          }
          return Container();
        });
  }

  //
  // send(List le) async {
  //   //
  //   paiementController.achatTicket(le);
  // }

  //
  String getReference() {
    var uuid = const Uuid();
    return uuid.v4();
  }
}
