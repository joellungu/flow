import 'package:flow/pages/terms/termes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login_controller.dart';

class Signup extends GetView<LoginController> {
  //
  final formKey = GlobalKey<FormState>();
  final num = TextEditingController();
  final nom = TextEditingController();
  final mdp = TextEditingController();
  RxString datenaissance = "".obs;
  //
  RxBool vue = true.obs;

  //LoginController loginController = Get.find();
  RxBool masquer = true.obs;
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
            backgroundColor: HexColor("#4AA6B6"),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 130,
                          child: Image.asset(
                            "assets/logo white.png",
                            width: 200,
                          ),
                          /*
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                              ExactAssetImage("assets/LOGO TRANSPARANT.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          */
                        ),
                        // Image.asset(
                        //   "assets/logo_MIN SANTE.png",
                        //   width: 300,
                        //   height: 300,
                        // ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Créer un compte",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        TextFormField(
                          controller: nom,
                          style: TextStyle(
                            //fontSize: 25,
                          ),
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Veuilliez inserer votre nom";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: HexColor("#2F565D"),
                              ),
                              hintText: "Nom d'utilisateur",
                              hintStyle:
                              TextStyle(color: Colors.grey.shade500)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: num,
                          style: TextStyle(
                              //fontSize: 25,
                              ),
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Veuilliez inserer votre téléphone";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefix: const Text("00243 "),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: HexColor("#2F565D"),
                              ),
                              hintText: "Téléphone ex: 00243...",
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: mdp,
                            obscureText: masquer.value,
                            style: TextStyle(
                                //fontSize: 25,
                                ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Veuilliez inserer votre mot de passe";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: HexColor("#2F565D"),
                                ),
                                suffixIcon: Obx(
                                  () => IconButton(
                                    icon: vue.value
                                        ? Icon(
                                            Icons.remove_red_eye,
                                            color: HexColor("#2F565D"),
                                          )
                                        : Icon(
                                            Icons.remove_red_eye,
                                            color: HexColor("#2F565D"),
                                          ),
                                    onPressed: () {
                                      //
                                      masquer.value = !masquer.value;
                                    },
                                  ),
                                ),
                                hintText: "Mot de passe",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1920),
                                    lastDate: DateTime(2100),
                                  ).then((d) {
                                    if (d != null) {
                                      datenaissance.value =
                                          "${d.day}-${d.month}-${d.year}";
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.calendar_month,
                                  color: HexColor("#2F565D"),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Date de naissance",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => Text(
                                  datenaissance.value,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            //height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(value: true, onChanged: (ec) {}),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text.rich(
                                    TextSpan(text: "J'accepte ", children: [
                                      //
                                      WidgetSpan(
                                          child: InkWell(
                                        onTap: () {
                                          //
                                          Get.to(Termes());
                                        },
                                        child: Text(
                                          "les termes et conditions",
                                          style: TextStyle(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                            //decoration: TextDecoration.underline,
                                            color: HexColor("#2F565D"),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),

                                      TextSpan(
                                        text:
                                            " d'utilisations de l'application",
                                      ),
                                    ]),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      //decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //Get.off(Accueil());

                              Get.dialog(
                                Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: const CircularProgressIndicator(),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              );

                              Map e = {
                                "nomUtilisateur": nom.text,
                                "telephone": num.text,
                                "mdp": mdp.text,
                                "dateNaissance": datenaissance.value,
                              };
                              /**
                               *  public String nom;
                                  public String telephone;
                                  public String email;
                                  public String mdp;
                                  public String trancheAge;
                                  public String sexe;
                               */
                              // // Timer(Duration(seconds: 3), () {
                              // //   Get.back();
                              // //   Get.off(Accueil());
                              // // });
                              // Map e = {
                              //   "email": email.text,
                              //   "pwd": mdp.text,
                              // };
                              controller.creerCompte(e);
                              //Get.off(Accueil());
                              //loginController.deja.value = true;
                            }
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(2),
                            fixedSize: MaterialStateProperty.all(
                              Size(
                                double.maxFinite,
                                45,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#2F565D")),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            child: Text(
                              "S'authentifier",
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
                    //)
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
