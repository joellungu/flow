import 'package:flow/pages/accueil.dart';
import 'package:flow/pages/pepites/pepite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

class Montant extends StatelessWidget {
  //
  RxInt devise = 0.obs;
  //
  PepiteController pepiteController = Get.find();
  //
  int idEntreprise;
  //
  TextEditingController quantite = TextEditingController();
  //
  var box = GetStorage();
  //
  Montant(this.idEntreprise);
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Echange"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          child: Column(
            children: [
              const Text(
                "Montant à échanger",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextField(
                      autofocus: true,
                      controller: quantite,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Montant",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 70,
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: devise.value,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text("CDF"),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text("USD"),
                            ),
                          ],
                          onChanged: (e) {
                            devise.value = e as int;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  //
                  Get.dialog(
                    Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                  //
                  Map user = box.read("user") ?? {};
                  //
                  String rep = await pepiteController.echange(
                      user['numeroDeTelephone'],
                      idEntreprise,
                      double.parse(quantite.text),
                      ["CDF", "USD"][devise.value]);
                  //
                  Get.back();
                  //
                  debugPrint(rep);
                  Get.offAll(Accueil());
                  Get.snackbar("Reponse du serveur", rep);
                  //
                },
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(2),
                  fixedSize: WidgetStateProperty.all(
                    const Size(
                      double.maxFinite,
                      45,
                    ),
                  ),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                  backgroundColor: WidgetStateProperty.all(HexColor("#2F565D")),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: Text(
                    "Valider",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
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
  }
  //
}
