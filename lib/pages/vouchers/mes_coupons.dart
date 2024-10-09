import 'package:fast_contacts/fast_contacts.dart';
import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'contacts/contacts.dart';
import 'details_coupon.dart';

class MesCoupons extends StatelessWidget {
  //
  var box = GetStorage();
  //
  List mescoupons = [];
  //
  MesCoupons() {
    mescoupons = box.read("mescoupons") ?? [];
  }

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
          mescoupons.length,
          (index) {
            Map coupon = mescoupons[index];
            print("coupon: $coupon");
            //
            return InkWell(
              onTap: () {
                //
                //Get.to(DetailAgent({}));
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
                        child: Transform.rotate(
                          angle: 56,
                          child: IconButton(
                            onPressed: () async {
                              // See installation notes below regarding AndroidManifest.xml and Info.plist

// Request contact permission
                              if (await Permission.contacts
                                  .request()
                                  .isGranted) {
                                // Either the permission was already granted before or the user just granted it.
                                final contacts =
                                    await FastContacts.getAllContacts();
                                //
                                Get.dialog(Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                  ),
                                ));
                                //
                                List<String> nums = [];
                                //
                                contacts.forEach((c) {
                                  c.phones.forEach((cc) {
                                    //
                                    String num = cc.number.replaceAll(" ", "");
                                    print("num: ${num[0]}");
                                    print("num: ${num[0].runtimeType}");
                                    print("__________________________________");
                                    //
                                    if (num[0] == "0") {
                                      //
                                      nums.add(num.replaceFirst("0", "00243"));
                                    } else if (num[0] == "+") {
                                      nums.add(num.replaceFirst("+", "00"));
                                    } else {
                                      nums.add(num);
                                    }

                                    //
                                  });
                                });
                                //

                                //
                                Get.back();
                                //
                                Get.to(MesContacts(contacts, nums));
                              }

                              /*
                              Get.dialog(Material(
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
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              "Envoyer la carte",
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: SizedBox(
                                              height: 50,
                                              width: 300,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Recherche, Coupons, Carte etc.",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide: BorderSide(
                                                      color:
                                                          Colors.grey.shade500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Expanded(
                                              flex: 4,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 120,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Jane Doe",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    HexColor("#4AA6B6"),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  //
                                                  Get.back();
                                                  Get.dialog(
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: Center(
                                                        child: Card(
                                                          elevation: 1,
                                                          child: Container(
                                                            height: 300,
                                                            width: 300,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Container(
                                                              height: 100,
                                                              width: 100,
                                                              child: Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .white,
                                                                size: 100,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: HexColor(
                                                                      "#4AA6B6"),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Envoyer",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      Transform.rotate(
                                                        angle: 56,
                                                        child: Container(
                                                          child: Icon(
                                                            Icons.send,
                                                            size: 20,
                                                            color: HexColor(
                                                                "#4AA6B6"),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          height: 25,
                                                          width: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                              */
                            },
                            icon: const Icon(
                              Icons.send,
                            ),
                          ),
                        ),
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
                            color: Colors.white,
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
