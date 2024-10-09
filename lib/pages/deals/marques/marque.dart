import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'marque_controller.dart';

class Marque extends GetView<MarqueController> {
  //
  Marque() {
    controller.getAllDeals();
  }
  //
  var box = GetStorage();
  //
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        //
        List deals = state!;
        //
        return ListView(
          padding: const EdgeInsets.all(10),
          children: List.generate(deals.length, (index) {
            //
            Map deal = deals[index];
            //
            List pioches = box.read("pioches") ?? [];
            //
            RxBool deja = false.obs;
            //
            for (Map e in pioches) {
              //
              if (e['id'] == deal['id']) {
                deja.value = true;
                break;
              }
            }
            ;
            //
            return Card(
              elevation: 1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                                  "${Requete.url}/deal/logo/${deal['id']}"),
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
                        padding: EdgeInsets.all(3),
                        child: RichText(
                          text: TextSpan(
                              text: "${deal['titre'] ?? "Simple test"}\n",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "${deal['description']}\n\n",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: "Exp: ${deal['fin']}",
                                  style: TextStyle(
                                    color: HexColor("#4AA6B6"),
                                    fontSize: 11,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          //color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                //
                                //Set pioches = box.read("pioches") ?? {};
                                //
                                //bool deja = false;
                                //

                                //
                                Set listeUnique = pioches.toSet();
                                //
                                //print("listeUnique: $listeUnique");
                                //
                                if (!deja.value) {
                                  //
                                  deja.value = true;
                                  //
                                  pioches.add(deal);
                                  //
                                  //pioches = listeUnique.toList(); //.add(deal);
                                  //
                                  box.write("pioches", pioches);
                                  //
                                  Get.dialog(
                                    Center(
                                      child: Card(
                                        elevation: 1,
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: HexColor("#4AA6B6"),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                50,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                              size: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  Get.snackbar(
                                    "Oups",
                                    "Déjà pioché",
                                    backgroundColor: Colors.red.shade700,
                                  );
                                }
                                //
                              },
                              icon: Obx(
                                () => deja.value
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.yellow.shade700,
                                      )
                                    : Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            Container(
                              height: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                //color: HexColor("#4AA6B6"), //Colors.blue,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "${deal['valeur'] ?? ''} Ppt",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: HexColor("#4AA6B6"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
      onEmpty: Container(),
      onLoading: Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
