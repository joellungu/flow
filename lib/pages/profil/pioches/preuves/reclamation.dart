import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:flow/pages/profil/pioches/preuves/preuve_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_view/photo_view.dart';

import 'envoie.dart';

class reclamation extends GetView<PreuveController> {
  //
  String iddeal;
  //
  String titreCoupon;
  //
  reclamation(this.iddeal, this.titreCoupon);
  //
  RxList photos = [].obs;
  //
  RxString path = "".obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reclamation",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Obx(
              () => path.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: Text("Faite le capture de votre facture"),
                    )
                  : PhotoView(
                      imageProvider: FileImage(
                        File('$path'),
                      ),
                    ),
              // Container(
              //                   decoration: BoxDecoration(
              //                     image: DecorationImage(
              //                       image: FileImage(
              //                         File('$path'),
              //                       ),
              //                       fit: BoxFit.contain,
              //                     ),
              //                   ),
              //                 ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(photos.length, (index) {
                        return InkWell(
                          onTap: () async {
                            //
                            path.value = photos[index];
                          },
                          child: Container(
                            //margin: EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            height: 70,
                            width: 65,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  File('${photos[index]}'),
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    //
                    final ImagePicker picker = ImagePicker();
                    // Capture a photo.
                    final XFile? photo = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 80,
                        maxWidth: 900,
                        maxHeight: 1024);
                    //final XFile? file = response.file;
                    if (photo != null) {
                      //_handleLostFiles(files);
                      path.value = photo.path;
                      photos.add(photo.path);
                    } else {
                      //_handleError(response.exception);
                      Get.snackbar(
                          "Erreur", "Nous n'avons pas pu récuper l'image");
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: 65,
                    color: HexColor("#ADADAD"),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () async {
                //
                var box = GetStorage();
                //
                Map user = box.read("user");
                //
                String code = getCode();
                //
                Get.dialog(
                  Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                );
                List liste = [];
                for (var photo in photos) {
                  //
                  /**
                   * public Long idDeal;
    public String numeroDeTelephone;

    @Lob // Permet de stocker un contenu volumineux comme les images
    public byte[] contenu;

    public String code;
                   */
                  liste.add(
                    File(photo).readAsBytesSync(),
                  );
                }
                //
                DateTime d = DateTime.now();
                //
                String date = "${d.day}-${d.month}-${d.year}";
                //
                Map facture = {
                  "numeroDeTelephone": user['numeroDeTelephone'],
                  "idDeal": iddeal,
                  "idVerificateur": 0,
                  "date": date,
                  "code": code,
                  "statut": "",
                };
                print("facture: $facture");
                //
                if (liste.isNotEmpty) {
                  //
                  Map v = await controller.envoiePreuve(facture);
                  //
                  if (v['status']) {
                    var box = GetStorage();
                    //
                    List pioches = box.read("pioches") ?? [];
                    //
                    for (int t = 0; t < pioches.length; t++) {
                      if (pioches[t]["id"] == iddeal) {
                        pioches.removeAt(t); //
                      }
                    }
                    //
                    box.write("pioches", pioches);
                    //
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) {
                        return Material(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Center(
                            child: Card(
                              elevation: 1,
                              child: Container(
                                height: Get.size.height / 2,
                                width: Get.size.width / 1.1,
                                alignment: Alignment.center,
                                child: Envois(liste, titreCoupon, iddeal,
                                    user['numeroDeTelephone'], code),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    //
                  } else {
                    Get.dialog(
                      Center(
                        child: Card(
                          elevation: 1,
                          child: Container(
                            height: 150,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Oups",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "${v['message']}",
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          fixedSize: Size(100, 40),
                                          backgroundColor: Colors.black,
                                        ),
                                        onPressed: () {
                                          //
                                          Get.back();
                                        },
                                        child: const Text(
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
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size(Get.size.width, 40),
                backgroundColor: HexColor("#4AA6B6"),
                //backgroundColor: MaterialStateProperty.all(HexColor("#2F565D")),
              ),
              child: const Text(
                "Envoyer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  String getCode() {
    String code = "";
    //
    for (int c = 0; c < 16; c++) {
      //
      int v = Random().nextInt(10);
      code = "$code$v";
    }
    //
    return code;
  }
}
