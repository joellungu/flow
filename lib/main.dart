import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:flow/utils/local_notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'pages/deals/boutiques/boutique_controller.dart';
import 'pages/deals/gens/gens_controller.dart';
import 'pages/deals/marques/marque_controller.dart';
import 'pages/login/login_controller.dart';
import 'pages/preuves/preuve_controller.dart';
import 'pages/vouchers/voucher_controller.dart';
import 'utils/app_controller.dart';
import 'utils/scan_util.dart';

RxString urlPub = "".obs;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  LocalNotificationService.initialize();
  //
  AppController appController = Get.put(AppController());
  //

  print("message.data: ${message.data}");
  //
  if (message.data['type'] == "notification") {
    //
    var box = GetStorage();
    String token = box.read("token");
    //
    Map m = {};
    //
    m['idPub'] = message.data['idPub'];
    m['titre'] = message.data['titre'];
    m['description'] = message.data['description'];
    m['lien'] = message.data['lien'];
    //controller.setNotification(device);
    appController.setNotification(m);
    //LocalNotificationService.display(m);
    //
    print("Data: Data: _____________________________");
    print("Data: Data: ${message.category}");
    print("Data: Data: _____________________________");
    print("Data: Data: ${message.messageId}");
    print("Data: Data: _____________________________");
    print("Data: Data: ${message.messageType}");
    print("Data: Data: _____________________________");
    //print("Data: ${data.notification!.title}");
    print("Data: Data: _____________________________");
    //print("Data: ${data.notification!.body}");
    print("Data: Data: _____________________________");
    print("Data: Data: ${message.data}");
    print("Data: Data: _____________________________&&&&&&");
    //

    //____________
    if (message.data['but'] == "message") {}
    //____________
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print('Handling a background message ${message.messageId}');
  } else if (message.data['type'] == "notifier") {
    //sendAppareils

    var box = GetStorage();
    //Ici on scanne...
    String token = box.read("token") ?? "";

    ScanUtil.sendAppareils(token);
    //
  } else {
    var box = GetStorage();
    //Ici on scanne...
    //String token = box.read("token");
    ScanUtil.loadBLE();
    //
  }
}

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  await GetStorage.init();
  //
  //
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  //FirebaseMessaging.instance.setAutoInitEnabled(false);
  //
  try {
    //
    FirebaseMessaging.instance.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    //
    var box = GetStorage();
    //
    box.write("token", token);
    //
    print("token: $token");
    //
  } catch (e) {
    print("erreur: $e");
  }
  //
  AppController appController = Get.put(AppController());
  //
  if (!kIsWeb) {
    LocalNotificationService.initialize();
    WakelockPlus.enable();
    //await setupFlutterNotifications();
  }
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

class Flow extends StatefulWidget {
  const Flow({super.key});

  @override
  State<StatefulWidget> createState() {
    //
    return _Flow();
  }
  //
}

class _Flow extends State<Flow> {
  //le claire ce #4AA6B6
  //#2F565D
  //gris ce #ADADAD
  //
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //
  AppController appController = Get.find();
  //
  var box = GetStorage();
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //

    //
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    //
    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(
            () {
              print("initialMessage = ${value?.data.toString()}");
            },
          ),
        );

    FirebaseMessaging.onMessage.listen((message) {
      //
      if (message.data['type'] == "notification") {
        //
        var box = GetStorage();
        String token = box.read("token");
        //
        Map m = {};
        //
        m['idPub'] = message.data['idPub'];
        m['titre'] = message.data['titre'];
        m['description'] = message.data['description'];
        m['lien'] = message.data['lien'];
        //controller.setNotification(device);
        appController.setNotification(m);
        //LocalNotificationService.display(m);
        //
        print("Data: Data: _____________________________");
        print("Data: Data: ${message.category}");
        print("Data: Data: _____________________________");
        print("Data: Data: ${message.messageId}");
        print("Data: Data: _____________________________");
        print("Data: Data: ${message.messageType}");
        print("Data: Data: _____________________________");
        //print("Data: ${data.notification!.title}");
        print("Data: Data: _____________________________");
        //print("Data: ${data.notification!.body}");
        print("Data: Data: _____________________________");
        print("Data: Data: ${message.data}");
        print("Data: Data: _____________________________&&&&&&");
        //

        //____________
        if (message.data['but'] == "message") {}
        //____________
        // If you're going to use other Firebase services in the background, such as Firestore,
        // make sure you call `initializeApp` before using other Firebase services.
        print('Handling a background message ${message.messageId}');
      } else if (message.data['type'] == "notifier") {
        //sendAppareils

        var box = GetStorage();
        //Ici on scanne...
        String token = box.read("token") ?? "";

        ScanUtil.sendAppareils(token);
        //
      } else {
        var box = GetStorage();
        //Ici on scanne...
        //String token = box.read("token");
        ScanUtil.loadBLE();
        //
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });

    //
    appController.sendToken();
    //

    //Ici on scanne...
    //String token = box.read("token") ?? "";
    //
    Timer(const Duration(seconds: 20), () {
      ScanUtil.loadBLE();
    });
  }

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
