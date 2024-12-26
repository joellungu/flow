import 'package:flow/pages/pepites/attentes/attente.dart';
import 'package:flow/pages/pepites/depense.dart';
import 'package:flow/pages/pepites/pepite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'attentes/attente_controller.dart';
import 'gagners/gagner.dart';
import 'gagners/gagner_controller.dart';
import 'montant.dart';

class Pepite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Pepite();
  }
}

class _Pepite extends State<Pepite> with SingleTickerProviderStateMixin {
  //
  TabController? controller;
  //
  GagnerController gagnerController = Get.put(GagnerController());
  AttenteController attenteController = Get.put(AttenteController());
  //
  PepiteController pepiteController = Get.find();
  //
  RxString path = "".obs;
  //
  var box = GetStorage();
  //
  //CourseController courseController = Get.find();
  //
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
    //
    //var box = GetStorage();
    //
    //Map e = box.read("user");
    //
    //courseController.getAllCoures(1);
    //
    controller!.addListener(() {
      //print("La valeur: ${controller!.index}");
      //courseController.getAllCoures(controller!.index + 1);
    });
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
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  height: 170,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: HexColor("#4AA6B6"),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Obx(
                    () => Text(
                      "Vos Pepites\n${pepiteController.points.value} Ppt",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 50,
                        color: Colors.grey.shade100,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                alignment: Alignment.center,
                child: TabBar(
                  controller: controller,
                  isScrollable: false,
                  //labelColor: Colors.white,
                  // onTap: (e) {
                  //   print(e);
                  //   //courseController.getAllCoures();
                  // },
                  indicatorColor: HexColor("#4AA6B6"),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2,
                  /*
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 1),
                  indicator: BoxDecoration(
                      color: HexColor("#4AA6B6"),
                      borderRadius: BorderRadius.circular(1),
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade200,
                    fontSize: 13,
                  ),
                  */
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                  labelColor: HexColor("#4AA6B6"),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  tabs: const [
                    Tab(
                      text: "Pt. Accumulé",
                    ),
                    Tab(
                      text: "Pt. Utilisé",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TabBarView(
                  controller: controller,
                  children: [
                    Gagner(),
                    Attente(),
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              //
              showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  builder: (context) {
                    //
                    Map user = box.read("user") ?? {};
                    //
                    return Container(
                      height: Get.size.height / 1.7,
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          ListTile(
                            onTap: () {
                              //
                              getMessage();
                            },
                            leading: SvgPicture.asset(
                              "assets/HugeiconsCall.svg",
                              colorFilter: const ColorFilter.mode(
                                  Colors.blueGrey, BlendMode.srcIn),
                              //semanticsLabel: e["titre"],
                              height: 30,
                              width: 30,
                            ),
                            title: const Text("Airtel"),
                            subtitle: Text("Crédit et forfait"),
                          ),
                          //
                          ListTile(
                            onTap: () {
                              //
                              getMessage();
                            },
                            leading: SvgPicture.asset(
                              "assets/HugeiconsCall.svg",
                              colorFilter: const ColorFilter.mode(
                                  Colors.blueGrey, BlendMode.srcIn),
                              //semanticsLabel: e["titre"],
                              height: 30,
                              width: 30,
                            ),
                            title: const Text("Africell"),
                            subtitle: Text("Crédit et forfait"),
                          ),
                          //
                          ListTile(
                            onTap: () {
                              //
                              getMessage();
                            },
                            leading: SvgPicture.asset(
                              "assets/HugeiconsCall.svg",
                              colorFilter: const ColorFilter.mode(
                                  Colors.blueGrey, BlendMode.srcIn),
                              //semanticsLabel: e["titre"],
                              height: 30,
                              width: 30,
                            ),
                            title: const Text("Orange"),
                            subtitle: Text("Crédit et forfait"),
                          ),
                          //
                          ListTile(
                            onTap: () {
                              //
                              getMessage();
                            },
                            leading: SvgPicture.asset(
                              "assets/HugeiconsCall.svg",
                              colorFilter: const ColorFilter.mode(
                                  Colors.blueGrey, BlendMode.srcIn),
                              //semanticsLabel: e["titre"],
                              height: 30,
                              width: 30,
                            ),
                            title: const Text("Vodacom"),
                            subtitle: Text("Crédit et forfait"),
                          ),
                          //
                          ListTile(
                            onTap: () async {
                              //Scanne
                              Get.to(Depense());
                            },
                            leading: SvgPicture.asset(
                              "assets/HugeiconsLegal02.svg",
                              colorFilter: const ColorFilter.mode(
                                  Colors.blueGrey, BlendMode.srcIn),
                              //semanticsLabel: e["titre"],
                              height: 30,
                              width: 30,
                            ),
                            title: Text("Boutique ou magazin"),
                            subtitle:
                                Text("Echanger vos petites pour des biens"),
                          ),
                          //
                          ListTile(
                            onTap: () {
                              //
                            },
                            leading: SvgPicture.asset(
                              "assets/HugeiconsCancel02.svg",
                              colorFilter: const ColorFilter.mode(
                                  Colors.blueGrey, BlendMode.srcIn),
                              //semanticsLabel: e["titre"],
                              height: 30,
                              width: 30,
                            ),
                            title: const Text("Saba ba lar"),
                            subtitle: Text("Jouer à la lotterie Saba ba lar"),
                          ),
                          //
                        ],
                      ),
                    );
                  });
            },
            label: Text("Dépenser"),
          ),
        ),
      ),
    );
  }

  getMessage() {
    Get.snackbar(
      "Oups",
      "Service non disponible pour le moment",
      colorText: Colors.grey.shade300,
      backgroundColor: HexColor("#4AA6B6"),
    );
  }
}
