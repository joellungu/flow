import 'package:flow/pages/profil/loyelty/loyelty_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'attente_controller.dart';

class Attente extends GetView<AttenteController> {
  //
  Attente() {
    controller.load();
  }
  //
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return ListView(
        padding: EdgeInsets.all(10),
        children: List.generate(10, (index) {
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
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(color: HexColor("#4AA6B6")),
                            borderRadius: BorderRadius.circular(35)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      child: RichText(
                        text: TextSpan(
                            text: "Date 08/08/2023\n\n",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Gain 2% cash back on any purchase done in store")
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
                          Text(
                            "Pepites dépensé",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              "150 Ppt",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: HexColor("#4AA6B6"), //Colors.blue,
                                borderRadius: BorderRadius.circular(15)),
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
        ));
  }
}
