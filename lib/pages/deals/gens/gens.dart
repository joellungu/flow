import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'gens_controller.dart';

class Gens extends GetView<GensController> {
  //
  Gens() {
    controller.load();
  }
  //
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return Scaffold(
          body: ListView(
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
                        flex: 8,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          child: RichText(
                            text: TextSpan(
                                text: "Buy Lacoste and get 500 pepites\n\n",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Début: 08/08/2023\n",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Fin: 08/08/2023",
                                    style: TextStyle(
                                      color: HexColor("#4AA6B6"),
                                      fontSize: 11,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 4,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(3),
                      //     decoration: BoxDecoration(
                      //       //color: Colors.lightBlue,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //
            },
            backgroundColor: HexColor("#4AA6B6"),
            child: Icon(Icons.add),
          ),
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
