import 'package:flow/pages/accueil.dart';
import 'package:flow/pages/login/login.dart';
import 'package:flow/pages/login/signup.dart';
import 'package:flow/pages/paiement/paiement.dart';
import 'package:flow/pages/paiement/paiement_controller.dart';
import 'package:flow/pages/pepites/pepite.dart';
import 'package:flow/pages/splash.dart';
import 'package:flow/pages/terms/termes.dart';
import 'package:flow/pages/vouchers/contacts/contacts_controller.dart';
import 'package:flow/pages/vouchers/panier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/deals/boutiques/boutique_controller.dart';
import 'pages/deals/gens/gens_controller.dart';
import 'pages/deals/marques/marque_controller.dart';
import 'pages/login/login_controller.dart';
import 'pages/preuves/preuve_controller.dart';
import 'pages/vouchers/voucher_controller.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //
  VoucherController voucherController = Get.put(VoucherController());
  //
  LoginController loginController = Get.put(LoginController());
  //
  PreuveController preuveController = Get.put(PreuveController());
  //
  BoutiqueController boutiqueController = Get.put(BoutiqueController());
  //
  GensController gensController = Get.put(GensController());
  //
  MarqueController marqueController = Get.put(MarqueController());
  //
  ContactsController controller = Get.put(ContactsController());
  //
  PaiementController paiementController = Get.put(PaiementController());
  //
  runApp(const Flow());
}

class Flow extends StatelessWidget {
  const Flow({super.key});
  //le claire ce #4AA6B6
  //#2F565D
  //gris ce #ADADAD

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flow Rewards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        applyElevationOverlayColor: true,
        appBarTheme: AppBarTheme(
          elevation: 1,
          backgroundColor: HexColor("#4AA6B6"),
          //HexColor("#2F565D")
        ),
        useMaterial3: true,
      ),
      home:
          //Pepite()
          //Signup()
          //Login()
          //Accueil()
          //Paiement()
          //PanierVouchers()
          //Termes(),
          Splash(),
    );
  }
}
