import 'package:flow/pages/profil/loyelty/loyelty.dart';
import 'package:flow/pages/profil/loyelty/loyelty_controller.dart';
import 'package:flow/pages/profil/pioches/pioche_controller.dart';
import 'package:flow/pages/profil/profil_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'infos/infos.dart';
import 'pioches/pioche.dart';

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _Profil();
  }
}

class _Profil extends State<Profil> with SingleTickerProviderStateMixin {
  TabController? controller;
  //
  LoyeltyController loyeltyController = Get.put(LoyeltyController());
  PiocheController piocheController = Get.put(PiocheController());
  //
  var box = GetStorage();
  Map user = {};
  //
  //CourseController courseController = Get.find();
  //
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
    //
    user = box.read("user") ?? {};
    print("user: $user");
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
                //color: HexColor("#ADADAD"),
                color: HexColor("#4AA6B6"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 170,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: HexColor("#4AA6B6"),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(55)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${user['nom']}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade100,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     // Container(
                            //     //   height: 50,
                            //     //   width: 50,
                            //     //   child: Stack(
                            //     //     children: [
                            //     //       Padding(
                            //     //         padding: const EdgeInsets.only(
                            //     //           top: 5,
                            //     //         ),
                            //     //         child: InkWell(
                            //     //           onTap: () {},
                            //     //           child: SvgPicture.asset(
                            //     //             "assets/IcBaselinePoll.svg",
                            //     //             colorFilter:
                            //     //                 const ColorFilter.mode(
                            //     //                     Colors.white,
                            //     //                     BlendMode.srcIn),
                            //     //             //semanticsLabel: e["titre"],
                            //     //             height: 30,
                            //     //             width: 30,
                            //     //           ),
                            //     //         ),
                            //     //       ),
                            //     //       Padding(
                            //     //         padding: EdgeInsets.only(),
                            //     //         child: Align(
                            //     //           alignment: Alignment.bottomRight,
                            //     //           child: Card(
                            //     //             elevation: 2,
                            //     //             color: HexColor("#2F565D"),
                            //     //             child: Container(
                            //     //               alignment: Alignment.center,
                            //     //               height: 20,
                            //     //               width: 20,
                            //     //               child: Text(
                            //     //                 "5",
                            //     //                 style: TextStyle(
                            //     //                   color: Colors.grey.shade100,
                            //     //                 ),
                            //     //               ),
                            //     //             ),
                            //     //           ),
                            //     //         ),
                            //     //       )
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     InkWell(
                            //       onTap: () {},
                            //       child: SvgPicture.asset(
                            //         "assets/IcBaselineMiscellaneousServices.svg",
                            //         colorFilter: ColorFilter.mode(
                            //             Colors.white, BlendMode.srcIn),
                            //         //semanticsLabel: e["titre"],
                            //         height: 30,
                            //         width: 30,
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ],
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
                      text: "Pioche",
                    ),
                    Tab(
                      text: "Loyauté",
                    ),
                    Tab(
                      text: "Plus",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TabBarView(
                  controller: controller,
                  children: [
                    Pioche(),
                    Loyelty(),
                    Infos(user),
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
