import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'voucher_controller.dart';

class ProduitPanier extends StatelessWidget {
  Map coupon;
  //
  VoucherController couponsEnregistre = Get.find();
  //
  int ix;
  ProduitPanier(this.coupon, this.ix) {
    print("Coupon::: $coupon");
    prix = RxDouble(coupon['prix']);
  }
  //
  VoucherController voucherController = Get.find();
  //
  RxDouble prix = 0.0.obs;
  //
  var box = GetStorage();
  //
  RxInt nombre = 1.obs;

  RxDouble sousTotal = 0.0.obs;

  @override
  Widget build(BuildContext context) {
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
        height: 150,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${Requete.url}/coupon/logo/${coupon['id']}"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: HexColor("#4AA6B6")),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "${coupon['titre'] ?? 'test'}\n",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 20,
                                ),
                                children: [
                                  TextSpan(text: "${coupon['description']}")
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 45,
                                    //color: Colors.yellow,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "\$ ${coupon['prix']}",
                                      style: TextStyle(
                                        color: HexColor("#4AA6B6"),
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 45,
                                    //color: Colors.green,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            nombre.value--;
                                            coupon['quantite'] = nombre.value;
                                            //total.value = total.value *
                                            //    nombre.value;
                                            //
                                            voucherController.total.value =
                                                voucherController.total.value -
                                                    coupon['prix'];
                                            //voucherController.total.value = voucherController.total.value - (coupon['prix'] * nombre.value);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            "${nombre.value}",
                                            style: TextStyle(),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            //
                                            nombre.value++;
                                            coupon['quantite'] = nombre.value;
                                            //
                                            voucherController.total.value =
                                                voucherController.total.value +
                                                    coupon['prix'];
                                            /*
                                    if(nombre.value == 1){
                                      voucherController.total.value = coupon['prix'] * nombre.value;
                                    }else{
                                      voucherController.total.value = voucherController.total.value + (coupon['prix'] * nombre.value);
                                    }
                                    */
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(),
                child: IconButton(
                  onPressed: () {
                    //
                    print("Salut");
                    //
                    voucherController.total.value =
                        voucherController.total.value -
                            (coupon['prix'] * coupon['quantite']);
                    //
                    voucherController.couponsEnregistre.removeAt(ix);
                    //
                    box.write(
                        "coupons", voucherController.couponsEnregistre.value);
                    //
                    Get.back();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
