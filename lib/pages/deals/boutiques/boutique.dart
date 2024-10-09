import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'boutique_controller.dart';

class Boutique extends GetView<BoutiqueController> {
  //
  Boutique() {
    controller.getAllDeals();
  }
  //
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        //
        List deals = state!;
        //
        return ListView(
          padding: EdgeInsets.all(10),
          children: List.generate(deals.length, (index) {
            //
            Map deal = deals[index];
            //
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
                            color: Colors.white,
                            border: Border.all(
                              color: HexColor("#4AA6B6"),
                            ),
                            borderRadius: BorderRadius.only(
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
                              text: "Lacoste\n",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "Buy Lacoste and get 500 pepites\n\n",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: "Exp: 08/08/2023",
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.star,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 25,
                              alignment: Alignment.center,
                              child: Text(
                                "1500 Ppt",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: HexColor("#4AA6B6"),
                                ),
                              ),
                              decoration: BoxDecoration(
                                //color: HexColor("#4AA6B6"), //Colors.blue,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          //color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
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
