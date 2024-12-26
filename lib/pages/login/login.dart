import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login_controller.dart';
import 'signup.dart';

class Login extends GetView<LoginController> {
  //
  final formKey = GlobalKey<FormState>();
  final num = TextEditingController();
  final mdp = TextEditingController();
  //
  RxBool vue = true.obs;

  //AppController appController = Get.find();
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
                        height: 70,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "LOGIN",
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
                        controller: num,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            //fontSize: 25,
                            ),
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Veuilliez inserer votre email";
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
                            prefix: const Text("+243 "),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: HexColor("#2F565D"),
                            ),
                            hintText: "Téléphone",
                            hintStyle: TextStyle(color: Colors.grey.shade500)),
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
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
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
                            // // Timer(Duration(seconds: 3), () {
                            // //   Get.back();
                            // //   Get.off(Accueil());
                            // // });
                            // Map e = {
                            //   "email": email.text,
                            //   "pwd": mdp.text,
                            // };
                            controller.login(num.text, mdp.text);
                            //
                            //Get.off(Accueil());
                            //loginController.deja.value = true;
                          }
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
                          backgroundColor:
                              WidgetStateProperty.all(HexColor("#2F565D")),
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
                      const SizedBox(
                        height: 70,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Vous n'avez pas encore de compte ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          //
                          Get.to(Signup());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          child: Text(
                            "Créer un compte",
                            style: TextStyle(
                              fontSize: 13,
                              color: HexColor("#2F565D"),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  //)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
