import 'package:flow/pages/pepites/attentes/attente.dart';
import 'package:flow/pages/pepites/pepite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'attentes/attente_controller.dart';
import 'gagners/gagner.dart';
import 'gagners/gagner_controller.dart';

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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
                child: Container(
                  height: 170,
                  alignment: Alignment.center,
                  child: Text(
                    "Vos Pepites 10000 Ppt",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 50,
                      color: Colors.grey.shade100,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: HexColor("#4AA6B6"),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
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
        ),
      ),
    );
  }
}
