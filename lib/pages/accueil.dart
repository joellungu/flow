import 'package:flow/pages/deals/deal.dart';
import 'package:flow/pages/profil/loyelty/loyelty.dart';
import 'package:flow/pages/pepites/pepite.dart';
import 'package:flow/pages/profil/pioches/preuves/preuve.dart';
import 'package:flow/pages/profil/profil.dart';
import 'package:flow/pages/vouchers/voucher.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'profil/pioches/preuves/preuve_controller.dart';

class Accueil extends StatelessWidget {
  Rx<Widget> vue = Rx(Deal());
  RxInt choix = 0.obs;
  //
  List angles = [
    {"titre": "Deals", "icon": "MdiTagSearch"},
    //{"titre": "Shop", "icon": "MdiStorefront"},
    //{"titre": "Scan", "icon": "MdiImageFilterCenterFocusStrong"},
    {"titre": "Pepites", "icon": "MaterialSymbolsWallet"},
    {"titre": "Profil", "icon": "IcSharpPerson"},
  ];
  //
  PreuveController preuveController = Get.put(PreuveController());
  //
  /*
  
  */
  @override
  Widget build(BuildContext context) {
    // var box = GetStorage();
    // //
    // box.write("user", null);
    //
    return Scaffold(
      body: Obx(() => vue.value),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(angles.length, (index) {
            Map e = angles[index];
            return Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  //
                  choix.value = index;
                  /**
                   * else if (choix.value == 1) {
                    vue.value = Voucher();
                    // } else if (choix.value == 2) {
                    //   vue.value = Preuve();
                  }
                   */
                  if (choix.value == 0) {
                    vue.value = Deal();
                  } else if (choix.value == 1) {
                    vue.value = Pepite();
                  } else {
                    vue.value = Profil();
                  }
                },
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/${e["icon"]}.svg",
                        colorFilter: index == choix.value
                            ? ColorFilter.mode(
                                HexColor("#2F565D"), BlendMode.srcIn)
                            : ColorFilter.mode(
                                HexColor("#ADADAD"), BlendMode.srcIn),
                        semanticsLabel: e["titre"],
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        e["titre"],
                        style: TextStyle(
                          fontSize: 10,
                          color: index == choix.value
                              ? HexColor("#2F565D")
                              : HexColor("#ADADAD"),
                          fontWeight: index == choix.value
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
