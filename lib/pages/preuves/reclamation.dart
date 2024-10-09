import 'dart:io';

import 'package:flow/pages/preuves/preuve_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class reclamation extends GetView<PreuveController> {
  //
  String iddeal;
  //
  reclamation(this.iddeal);
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
                Get.dialog(
                  Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: const CircularProgressIndicator(),
                      alignment: Alignment.center,
                    ),
                  ),
                );
                List liste = [];
                for (var photo in photos) {
                  //
                  liste.add(File(photo).readAsBytesSync());
                }
                //
                DateTime d = DateTime.now();
                //
                String date = "${d.day}-${d.month}-${d.year}";
                //
                Map facture = {
                  "idClient": user['id'],
                  "iddeal": iddeal,
                  "idVerificateur": 0,
                  "photos": liste,
                  "dateCapture": date,
                  "status": false,
                };
                //
                bool v = await controller.envoiePreuve(facture);
                if (v) {
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
                }
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(2),
                fixedSize: MaterialStateProperty.all(
                  Size(
                    double.maxFinite,
                    45,
                  ),
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                backgroundColor: MaterialStateProperty.all(HexColor("#2F565D")),
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
}
