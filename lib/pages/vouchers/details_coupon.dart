import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailAgent extends StatelessWidget {
  Map coupon;
  DetailAgent(this.coupon);
  //
  //
  @override
  Widget build(BuildContext context) {
    //
    /**DefaultTabController(
      length: 2,
      child: 
       */

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: TextStyle(
                    //color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  text: "Gold Voucher\n",
                  children: [
                    TextSpan(
                      text: "Kin Marche",
                      style: TextStyle(
                        //color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: ExactAssetImage("${cat['profil']}"),
                  //   fit: BoxFit.contain,
                  // ),
                  //color: Colors.blue,
                  borderRadius: BorderRadius.circular(2),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Colors.blue.shade100.withOpacity(0.1),
                  //     Colors.blue.shade100.withOpacity(0.1),
                  //     Colors.blue.shade100.withOpacity(0.2),
                  //     Colors.blue.shade100.withOpacity(0.3),
                  //     Colors.blue.shade100.withOpacity(0.4),
                  //     Colors.blue.shade100.withOpacity(0.5),
                  //     Colors.blue.shade100.withOpacity(0.6),
                  //     Colors.blue.shade100.withOpacity(0.7),
                  //     Colors.blue.shade100,
                  //     Colors.blue.shade100,
                  //     Colors.blue.shade200,
                  //     //Colors.blue.shade300,
                  //     //Colors.blue.shade400,
                  //     //Colors.blue.shade500,
                  //     Colors.blue.shade500,
                  //     Colors.blue.shade700,
                  //   ],
                  //   //tileMode: TileMode.decal,
                  //   //stops: [0.1, 0.2, 0.3],
                  // ),
                ),
                // child: Hero(
                //   tag: "${coupon['profil']}",
                //   child: Image.asset(
                //     "${coupon['profil']}",
                //     fit: BoxFit.contain,
                //     height: double.maxFinite,
                //     width: double.maxFinite,
                //   ),
                // ),
              ),
            ),
          ),
          // SliverGrid(
          //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: 200.0,
          //     mainAxisSpacing: 10.0,
          //     crossAxisSpacing: 10.0,
          //     childAspectRatio: 4.0,
          //   ),
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Container(
          //         alignment: Alignment.center,
          //         color: Colors.teal[100 * (index % 9)],
          //         child: Text('Grid Item $index'),
          //       );
          //     },
          //     childCount: 20,
          //   ),
          // ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const ListTile(
                      title: Text(
                        "Coupon",
                        style: TextStyle(
                          //color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("Gold Voucher"),
                      //trailing: Icon(CupertinoIcons.person),
                    ),
                    ListTile(
                      onTap: () {
                        //
                      },
                      title: const Text(
                        "Date d'expiration",
                        style: TextStyle(
                          //color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("12-12-2024"),
                      // trailing: Icon(
                      //   Icons.favorite,
                      //   color: Colors.grey,
                      // ),
                    ),
                    ListTile(
                      title: Text(
                        "description",
                        style: TextStyle(
                          //color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                          "Kinshasa, Mont-ngafula, Cité mama Mobutu, Av du temple N°122"),
                    ),
                    ListTile(
                      title: Text(
                        "Prix",
                        style: TextStyle(
                          //color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("Expéditionniste"),
                      //trailing: Icon(Icons.location_on),
                    ),
                    ListTile(
                      title: Text(
                        "Valeur",
                        style: TextStyle(
                          //color: Colors.teal.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text("Actif"),
                      //trailing: Icon(Icons.location_on),
                    ),
                    ListTile(
                      title: Text(
                        "Status",
                        style: TextStyle(
                          //color: Colors.teal.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text("Actif"),
                      //trailing: Icon(Icons.location_on),
                    ),
                    ListTile(
                      title: Text(
                        "Terme & Condition",
                        style: TextStyle(
                          //color: Colors.teal.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text("Actif"),
                      //trailing: Icon(Icons.location_on),
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: 15),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           "Services ",
                    //           style: TextStyle(
                    //             color: Colors.teal.shade700,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 20,
                    //           ),
                    //         ),
                    //         Expanded(
                    //           flex: 1,
                    //           child: Container(
                    //             height: 10,
                    //             decoration: BoxDecoration(
                    //               border: Border(
                    //                 bottom: BorderSide(
                    //                   color: Colors.grey,
                    //                 ),
                    //               ),
                    //             ),
                    //             width: double.maxFinite,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: List.generate(services.length, (index) {
                    //     Map s = services[index];
                    //     return ListTile(
                    //       title: Text(
                    //         "${s['nom']}",
                    //         style: const TextStyle(
                    //           //color: Colors.black,
                    //           fontStyle: FontStyle.italic,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.normal,
                    //         ),
                    //       ),
                    //       subtitle: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "${s['prix']} ",
                    //             style: TextStyle(
                    //               color: Colors.blue.shade900,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //           Text(
                    //             "${s['devise']}",
                    //             style: TextStyle(
                    //               color: Colors.blue.shade900,
                    //               fontWeight: FontWeight.normal,
                    //               fontStyle: FontStyle.italic,
                    //               fontSize: 15,
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       //trailing: Icon(Icons.fact_check_outlined),
                    //     );
                    //   }),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          //
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade700),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Container(
                          height: 45,
                          alignment: Alignment.center,
                          child: Text(
                            "Supprimer",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
