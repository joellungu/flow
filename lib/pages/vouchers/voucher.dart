import 'package:flow/pages/vouchers/panier.dart';
import 'package:flow/pages/vouchers/voucher_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as m;

import 'mes_coupons.dart';
import 'nouveau_coupons.dart';

class Voucher extends GetView<VoucherController> {
  //
  var box = GetStorage();
  //
  //RxList couponsEnregistre = [].obs;
  //
  Voucher() {
    controller.couponsEnregistre.value = box.read("coupons") ?? [];
    //
    controller.getAllCoupons();
    //
  }
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#4AA6B6"), // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Image.asset(
                "assets/main logo.png",
                width: 100,
              ),
              actions: [
                InkWell(
                  onTap: (){
                    Get.to(PanierVouchers());
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: [
                         Icon(
                            CupertinoIcons.shopping_cart,
                            color: HexColor("#2F565D"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Card(
                              elevation: 2,
                              color: HexColor("#2F565D"),
                              child: Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                child: Obx(
                                  () => Text(
                                    "${controller.couponsEnregistre.length}",
                                    style: TextStyle(
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  margin: EdgeInsets.all(5),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(),
                  child: Container(
                    height: 97,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5),
                                hintText: "Recherche, Coupons, Carte etc.",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 47,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: TabBar(
                              indicatorColor: HexColor("#4AA6B6"),
                              labelColor: HexColor("#4AA6B6"),
                              unselectedLabelColor: Colors.grey.shade500,
                              isScrollable: false,
                              tabs: const [
                                Tab(
                                  //icon: Icon(Icons.location_on),
                                  text: "Acheter un coupons",
                                ),
                                Tab(
                                  //icon: Icon(Icons.workspaces),
                                  text: "Mes coupons",
                                ),
                              ],
                            ),
                            // child: Text(
                            //   "Mes Coupons",
                            //   style: TextStyle(
                            //     color: HexColor("#4AA6B6"),
                            //     fontSize: 17,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    // decoration: BoxDecoration(
                    //   color: HexColor("#4AA6B6"),
                    // ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    //physics: BouncingScrollPhysics(),
                    children: [
                      controller.obx(
                        (state) {
                          //
                          List coupons = state!;
                          print("coupons: $coupons");
                          //
                          return NouveauCoupon(coupons);
                        },
                        onError: (e) {
                          return Container();
                        },
                        onEmpty: Container(),
                        onLoading: const Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      MesCoupons(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
