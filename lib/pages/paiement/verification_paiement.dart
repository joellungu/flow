import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'paiement_controller.dart';

class VerificationPaiement extends StatefulWidget {
  List commande;
  String? telephone;
  String? ref;
  double? montant;
  String? devise;
  VerificationPaiement(this.commande,
      {this.devise, this.montant, this.telephone, this.ref}) {}

  @override
  State<StatefulWidget> createState() {
    //
    return _VerificationPaiement();
  }
}

class _VerificationPaiement extends State<VerificationPaiement> {
  //
  PaiementController paiementController = Get.find();
  //
  //final wsUrl = Uri.parse('${Requete.urlPaie}paiementbillet/${referencePaiement}');
  //var channel = WebSocketChannel.connect(
  //  Uri.parse('${Requete.urlPaie}paiementbillet/$referencePaiement'));
  //bool premierMessage = true;

  //PaiementController paiementController = Get.find();
  //
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    verification();
    //
  }

  verification() async {
    Map rep = await paiementController.paiement(
      {
        "reference": widget.ref,
        "phone": widget.telephone,
        "amount": widget.montant,
        "currency": widget.devise,
      },
    );
    print("Message serveur: $rep");

    if (rep['code'] == 0 || rep['code'] == '0') {
      //Vérification à chaque 5 sec
      //
      timer = Timer.periodic(
        const Duration(seconds: 5),
        (t) async {
          //
          Map repCheck =
              await paiementController.checkPaiement(rep['orderNumber']);
          print("repCheck: ${repCheck.runtimeType} :: $repCheck");
          /**
           * 0 : pour une transaction traiter avec succès
1 : pour une transaction qui n’a pas abouti
2 : Le paiement est en attente
3 : Le paiement va être remboursé au client
4 : Le paiement a été remboursé au client
5 : La transaction a été annulée par le marchand
           */
          //
          if (repCheck["transaction"]['status'] == 0 ||
              repCheck['status'] == '0') {
            //
            //Il à payé
            timer!.cancel();
            //
            Get.back();
            //Get.snackbar("Oups", repCheck['message']);
            //
            Get.dialog(
              const Material(
                color: Colors.transparent,
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
            //
            send(
              widget.commande,
              "00${widget.telephone!}",
            );
            //
          } else if (repCheck["transaction"]['status'] == 1 ||
              repCheck["transaction"]['status'] == '1') {
            //
            timer!.cancel();
            //
            Get.back();
            Get.snackbar(
              "Oups",
              repCheck['message'],
              backgroundColor: Colors.red.shade700,
              colorText: Colors.white,
              duration: const Duration(seconds: 5),
            );
            send(widget.commande, "00${widget.telephone}");
            //
          } else if (repCheck["transaction"]['status'] == 2 ||
              repCheck["transaction"]['status'] == '2') {
            //J'attends
          } else if (repCheck["transaction"]['status'] == 3 ||
              repCheck["transaction"]['status'] == '3') {
            //
            timer!.cancel();
            //
            Get.back();
            Get.snackbar(
              "Oups",
              repCheck['message'],
              backgroundColor: Colors.red.shade700,
              colorText: Colors.white,
              duration: const Duration(seconds: 5),
            );
            //
          } else if (repCheck["transaction"]['status'] == 4 ||
              repCheck["transaction"]['status'] == '4') {
            //
            timer!.cancel();
            //
            Get.back();
            Get.snackbar(
              "Oups",
              repCheck['message'],
              backgroundColor: Colors.red.shade700,
              colorText: Colors.white,
              duration: const Duration(seconds: 5),
            );
            //
          } else if (repCheck["transaction"]['status'] == 5 ||
              repCheck["transaction"]['status'] == '5') {
            //
            timer!.cancel();
            //
            Get.back();
            Get.snackbar(
              "Oups",
              repCheck['message'],
              backgroundColor: Colors.red.shade700,
              colorText: Colors.white,
              duration: const Duration(seconds: 5),
            );
            //
          } else {
            //Oups c'est quoi ça ?
          }
          //channel.sink.add(jsonEncode({"check": ""}));
          //
          //
        },
      );
    } else {
      timer = Timer(const Duration(microseconds: 1), () {
        //
      });
      Get.back();
      Get.snackbar("Oups", rep['message']);
    }

    //
  }

  @override
  void dispose() {
    //
    timer!.cancel();
    //channel.sink.close(status.goingAway);
    //
    super.dispose();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      height: 100,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const CircularProgressIndicator(),
    );
  }

  //
  send(List le, String telephone) async {
    //
    paiementController.achatTicket(le, telephone);
  }
}
