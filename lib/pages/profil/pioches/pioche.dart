import 'package:flow/pages/profil/pioches/preuves/reclamation.dart';
import 'package:flow/pages/profil/profil_controller.dart';
import 'package:flow/utils/requete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

class Pioche extends GetView<ProfilController> {
  //
  var box = GetStorage();
  //
  List pioches = [];
  //
  Pioche() {
    //
    pioches = box.read("pioches") ?? [];
    //
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: List.generate(pioches.length, (index) {
        Map deal = pioches.elementAt(index);
        //
        return Card(
          elevation: 1,
          color: HexColor("#4AA6B6"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              //
              Get.to(reclamation("${deal['id']}", deal['titreCoupon']));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      //height: 70,
                      //width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "${Requete.url}/deals/photo/${deal['id']}"),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                        border: Border.all(
                          color: HexColor("#4AA6B6"),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 77,
                      //margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "${deal['entEmetrice'] ?? ""}\n",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "${deal['titreCoupon']}\n",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: "Exp: ${deal['dateFin']}",
                              style: TextStyle(
                                color: HexColor("#4AA6B6"),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "Reclamer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
