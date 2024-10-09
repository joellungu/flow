import 'package:flow/pages/paiement/paiement.dart';
import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'produit_panier.dart';
import 'voucher_controller.dart';

class PanierVouchers extends StatelessWidget {
  //
  var box = GetStorage();
  //
  //RxList couponsEnregistre = [].obs;
  //
  VoucherController voucherController = Get.find();
  //
  PanierVouchers() {
    voucherController.total.value = 0.0;
    /**
     * 
      var box = GetStorage();
      voucherController.couponsEnregistre.value =
          box.read("coupons") ?? [];
     */
    //
    voucherController.couponsEnregistre.value = box.read("coupons") ?? [];
    //
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          "assets/main logo.png",
          width: 100,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            height: 70,
            child: Text(
              "Panier",
              style: TextStyle(
                color: HexColor("#4AA6B6"),
                fontSize: 40,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: List.generate(
                voucherController.couponsEnregistre.length,
                (index) {
                  //
                  Map coupon = voucherController.couponsEnregistre[index];

                  int nombre = 1;
                  //
                  voucherController.total.value =
                      voucherController.total.value + coupon['prix'];
                  //
                  return ProduitPanier(coupon, index);
                },
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.center,
                    child: Obx(
                      () => RichText(
                        text: TextSpan(
                          text: "Total\n",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(
                              text: "\$${voucherController.total.value}",
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        //

                        Get.to(Paiement(
                            voucherController.couponsEnregistre.value));
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        fixedSize: MaterialStateProperty.all(
                          Size(
                            double.maxFinite,
                            40,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          HexColor("#4AA6B6"),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ACHETER",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: HexColor("#4AA6B6"),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
