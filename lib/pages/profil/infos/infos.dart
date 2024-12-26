import 'package:flow/pages/login/login.dart';
import 'package:flow/pages/terms/termes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Infos extends StatelessWidget {
  //
  var box = GetStorage();
  //
  Map user = {};
  //
  Infos(this.user);
  //
  @override
  Widget build(BuildContext context) {
    //
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ListTile(
          onTap: () {
            //
          },
          leading: SvgPicture.asset(
            "assets/HugeiconsUser.svg",
            colorFilter:
                const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
            //semanticsLabel: e["titre"],
            height: 30,
            width: 30,
          ),
          title: const Text("Nom"),
          subtitle: Text("${user['nom']} ${user['postnom']} ${user['prenom']}"),
        ),
        //
        ListTile(
          onTap: () {
            //
          },
          leading: SvgPicture.asset(
            "assets/HugeiconsCall.svg",
            colorFilter:
                const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
            //semanticsLabel: e["titre"],
            height: 30,
            width: 30,
          ),
          title: const Text("Téléphone"),
          subtitle: Text("${user['numeroDeTelephone']}"),
        ),
        //
        ListTile(
          onTap: () {
            //
          },
          leading: SvgPicture.asset(
            "assets/HugeiconsBluetooth.svg",
            colorFilter:
                const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
            //semanticsLabel: e["titre"],
            height: 30,
            width: 30,
          ),
          title: const Text("Notifications"),
          subtitle: const Text("Recevoir des notifications par BLE"),
        ),
        //
        ListTile(
          onTap: () {
            //
          },
          leading: SvgPicture.asset(
            "assets/HugeiconsAlignBoxBottomLeft.svg",
            colorFilter:
                const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
            //semanticsLabel: e["titre"],
            height: 30,
            width: 30,
          ),
          title: const Text("A propos"),
          //subtitle: Text(""),
        ),
        //
        ListTile(
          onTap: () {
            //
            Get.to(Termes());
          },
          leading: SvgPicture.asset(
            "assets/HugeiconsLegal02.svg",
            colorFilter:
                const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
            //semanticsLabel: e["titre"],
            height: 30,
            width: 30,
          ),
          title: Text("Condition d'utilisation"),
          //subtitle: Text(""),
        ),
        //
        ListTile(
          onTap: () {
            //
            Get.dialog(Center(
              child: Card(
                elevation: 1,
                child: Container(
                  height: 150,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Quitter"),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Voulez-vous vraiment vous déconnecter ?",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              //
                              box.write("user", {});
                              //
                              Get.offAll(Login());
                            },
                            child: Text(
                              "Oui",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              //
                              Get.back();
                            },
                            child: Text(
                              "Non",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
            //
          },
          leading: SvgPicture.asset(
            "assets/HugeiconsCancel02.svg",
            colorFilter:
                const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
            //semanticsLabel: e["titre"],
            height: 30,
            width: 30,
          ),
          title: Text("Se déconnecter"),
          //subtitle: Text(""),
        ),
        //
      ],
    );
  }
  //
}
