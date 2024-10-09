import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'voucher_controller.dart';

class NouveauCoupon extends StatelessWidget {
  List coupons;
  NouveauCoupon(this.coupons);
  //
  VoucherController voucherController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.8,
        children: List.generate(
          coupons.length,
          (index) {
            //
            Map coupon = coupons[index];
            //
            return InkWell(
              onTap: () {
                //
                Get.dialog(
                  Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 350,
                          width: 350,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Ajouter au panier",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "${Requete.url}/coupon/logo/${coupon['id']}"),
                                          fit: BoxFit.cover,
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${coupon['titre'] ?? 'Test'}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "${coupon['description']}",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      HexColor("#4AA6B6"),
                                    ),
                                  ),
                                  onPressed: () {
                                    //
                                    var box = GetStorage();
                                    voucherController.couponsEnregistre.value =
                                        box.read("coupons") ?? [];
                                    //
                                    voucherController.couponsEnregistre
                                        .add(coupon);
                                    //
                                    box.write(
                                        "coupons",
                                        voucherController
                                            .couponsEnregistre.value);

                                    //
                                    Get.back();
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
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Ajouter",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: 20,
                                          child: Container(
                                            child: Icon(
                                              Icons.shopping_basket,
                                              size: 20,
                                              color: HexColor("#4AA6B6"),
                                            ),
                                            alignment: Alignment.center,
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 0),
                        // child: Transform.rotate(
                        //   angle: 56,
                        //   child: IconButton(
                        //     onPressed: () {
                        //     },
                        //     icon: const Icon(
                        //       Icons.send,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${Requete.url}/coupon/logo/${coupon['id']}"),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        //alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "${coupon['titre'] ?? 'Test'}\n",
                            style: TextStyle(
                              color: HexColor("#4AA6B6"),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "${coupon['description']}\n",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 10,
                                ),
                              ),
                              TextSpan(
                                text: "\$${coupon['devise']} ${coupon['prix']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " ${coupon['devise']}\n",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
