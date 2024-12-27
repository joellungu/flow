import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'boutiques/boutique.dart';
import 'boutiques/boutique_controller.dart';
import 'deal_controller.dart';
import 'gens/gens.dart';
import 'gens/gens_controller.dart';
import 'marques/marque.dart';
import 'marques/marque_controller.dart';

class Deal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _Deal();
  }
}

class _Deal extends State<Deal> with SingleTickerProviderStateMixin {
  //
  TabController? controller;
  //
  PageController pageController = PageController();
  //
  DealController dealController = Get.find();
  //
  Timer? temps;
  //
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
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
    //
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //
    //temps!.cancel();
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
          backgroundColor: Colors.white,
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
              Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(),
                child: FutureBuilder(
                  future: dealController.getAllPubs(),
                  builder: (c, t) {
                    if (t.hasData) {
                      List pubs = t.data as List;
                      // Timer(const Duration(seconds: 3), () async {
                      //   //
                      //   temps = Timer.periodic(const Duration(seconds: 2), (t) {
                      //     //
                      //     pageController.nextPage(
                      //         duration: const Duration(milliseconds: 300),
                      //         curve: Curves.linear);
                      //   });
                      // });
                      //
                      return Container(
                        height: 180,
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: Swiper(
                          //duration: 1,
                          //autoplayDelay: 1,
                          allowImplicitScrolling: true,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${Requete.url}/pubs/${pubs[index]}"),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.white,
                                border: Border.all(
                                  color: HexColor("#4AA6B6"),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                            );
                          },
                          itemCount: pubs.length,
                          pagination: SwiperPagination(),
                          control: SwiperControl(size: 0),
                        ),
                      );
                    } else if (t.hasError) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text("..."),
                      );
                    }
                    return Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
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
                      text: "Marques",
                    ),
                    Tab(
                      text: "Boutiques",
                    ),
                    Tab(
                      text: "Utilisateur",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TabBarView(
                  controller: controller,
                  children: [
                    Marque(),
                    Boutique(),
                    Gens(),
                  ],
                ),
              )
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   backgroundColor: HexColor("#4AA6B6"),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(25),
          //   ),
          //   child: const Icon(
          //     Icons.camera,
          //     size: 40,
          //   ),
          // ),
        ),
      ),
    );
  }

  //
}
