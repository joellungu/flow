import 'dart:async';
import 'dart:convert';
import 'package:flow/utils/app_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class LocalNotificationService {
  //
// Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //
  static void initialize() {
    // Initialization setting for android
    InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
      android: const AndroidInitializationSettings("ic_launcher"),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
          //print(
          //"la fonction = onDidReceiveLocalNotification : $id , $title, $body, $payload ");
        },
      ),
    );
    //
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        //
        print('::::::::');
        print('notification(${notificationResponse.id}) action tapped: '
            '${notificationResponse.actionId} with'
            ' payload: ${notificationResponse.payload}');
        print(
            '-------(${notificationResponse.notificationResponseType.name}) action: '
            '${notificationResponse.notificationResponseType.index} ');
        //
        var box = GetStorage();
        //
        Map data = json.decode(notificationResponse.payload!);
        //
        print("Data: $data");
        //
        AppController appController = Get.find();
        //String lien =
        await appController.jaiouvert(data['idPub']);
        //
        urlPub.value = data['lien'];
        box.write('urlPub', urlPub.value);
        //
        //Get.to(OpenPub(urlPub));
        //
        // if (!await launchUrl(Uri.parse(data['lien']))) {
        //   throw Exception('Could not launch ${data['lien']}');
        // }
        //
      },
      //onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future<void> display(
      Map message, AndroidBitmap<Object> androidBitmap) async {
    // To display the notification in device
    //
    var uuid = Uuid();
    //
    var channel = AndroidNotificationChannel(
      uuid.v1(), // id
      'High Importance Notifications ${uuid.v1()}', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    try {
      /**
       * AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // actions: [
          //   AndroidNotificationAction("close", "Close"),
          // ],
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: "ic_launcher",
        ),
      
       */
      //print(message.notification!.android!.sound);
      // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      // NotificationDetails notificationDetails = NotificationDetails(
      //   android: AndroidNotificationDetails('$id', channel.name,
      //       channelDescription: channel.description,
      //       //groupKey: "gfg",
      //       //color: Colors.green,
      //       importance: Importance.max,
      //       // sound: RawResourceAndroidNotificationSound(
      //       //     message.notification!.android!.sound ?? "gfg"),
      //       // different sound for
      //       // different notification
      //       //playSound: true,
      //       priority: Priority.high),
      // );
      //RemoteNotification? notification = message.notification;
      //AndroidNotification? android = message.notification?.android;
      //notification != null && android
      if (message['title'] != null && !kIsWeb) {
        //
        print("::::: J'ai un objet notif");
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 10,
          message['titre'],
          message['description'],
          //notification.title,
          //notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              message['titre'],
              channel.name,
              channelDescription: channel.description,
              setAsGroupSummary: true,
              largeIcon: androidBitmap,
              styleInformation: BigPictureStyleInformation(
                androidBitmap,
                hideExpandedLargeIcon: false,
                contentTitle: 'overridden <b>big</b> content title',
                htmlFormatContentTitle: true,
                summaryText: 'summary <i>text</i>',
                htmlFormatSummaryText: true,
              ),

              actions: [
                const AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "ic_launcher",
            ),
          ),
          payload: json.encode(message),
        );
      } else {
        //
        print("::::: J'ai pas un objet notif : ${message}");
        _notificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          message['titre'],
          message['description'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              largeIcon: androidBitmap,
              styleInformation: BigPictureStyleInformation(
                androidBitmap,
                hideExpandedLargeIcon: false,
                contentTitle: 'overridden <b>big</b> content title',
                htmlFormatContentTitle: true,
                summaryText: 'summary <i>text</i>',
                htmlFormatSummaryText: true,
              ),
              actions: [
                AndroidNotificationAction(
                  "view",
                  "View",
                  showsUserInterface: true,
                ),
                // AndroidNotificationAction(
                //   "close",
                //   "Close",
                //   cancelNotification: true,
                //   showsUserInterface: false,
                // ),
              ],
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "ic_launcher",
            ),
          ),
          payload: json.encode(message),
        );
      }

      //_____________________________________
      // await _notificationsPlugin.show(
      //   id,
      //   message.data['title'],
      //   message.data['body'],
      //   NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channelDescription: channel.description,
      //           // actions: [
      //           //   AndroidNotificationAction("close", "Close"),
      //           // ],
      //           // TODO add a proper drawable resource to android, for now using
      //           //      one that already exists in example app.
      //           icon: "ic_launcher",
      //         ),
      //       ),
      //   //notificationDetails,
      //   payload: message.data['route'],
      // );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //
}
