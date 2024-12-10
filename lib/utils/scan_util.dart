import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:io';

import 'app_controller.dart';
//import 'package:beacon_broadcast/beacon_broadcast.dart';
// import 'package:test_ble/utils/app_controller.dart';
// import 'package:test_ble/utils/local_notification_service.dart';

class ScanUtil {
  //

  static RxList<ScanResult> bluetoothDevices = RxList([]);
  //
  static List devs = [];
  //
  var box = GetStorage();
  //
  static loadBLE() async {
    //
    bluetoothDevices.clear();
    //
    devs.clear();
    // first, check if bluetooth is supported by your hardware
    // Note: The platform is initialized on the first call to any FlutterBluePlus method.
    if (await FlutterBluePlus.isSupported == false) {
      print(":::::: Bluetooth not supported by this device");
      return;
    }

// handle bluetooth on & off
// note: for iOS the initial state is typically BluetoothAdapterState.unknown
// note: if you have permissions issues you will get stuck at BluetoothAdapterState.unauthorized
    var subscription = FlutterBluePlus.adapterState.listen(
      (BluetoothAdapterState state) {
        print(state);
        if (state == BluetoothAdapterState.on) {
          // usually start scanning, connecting, etc
          print(":::::: succès");
          commencer();
        } else {
          print(":::::: erreur");
          // show an error to the user, etc
        }
      },
      onDone: () {
        print("On done");
      },
      onError: (e) async {
        print("Erreur du à: $e");
      },
      cancelOnError: true,
    );

// turn on bluetooth ourself if we can
// for iOS, the user controls bluetooth enable/disable
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

// cancel to prevent duplicate listeners
    //subscription.cancel();
  }

  //
  static commencer() async {
    //
    Set ls = {};
    // listen to scan results
    // Note: `onScanResults` only returns live scan results, i.e. during scanning. Use
    //  `scanResults` if you want live scan results *or* the results from a previous scan.
    var subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
        if (results.isNotEmpty) {
          ScanResult r = results.last; // the most recently found device
          bluetoothDevices.add(r);
          //d["mac"] = device.device.remoteId.str;
          //d["name"] = device.device.advName;
          if (ls.add(r.device.advName)) {
            devs.add({
              "mac": r.device.remoteId.str,
              "name": r.device.advName,
              "rssi": 1,
            });
          }

          print('::::::1 ${r.device.remoteId}: "${r.device.advName}" found!');
          // print('::::::2 ${r.device.advName}: "${r.device.servicesList}"');
          // print('::::::3 ${r.advertisementData.appearance}: ---');
          // print('::::::4 ${r.advertisementData.connectable}:  ---');
          // print('::::::5 ${r.advertisementData.manufacturerData}:  ---');
          // print('::::::6 ${r.advertisementData.msd}:  ---');
          // print('::::::7 ${r.advertisementData.serviceData}:  ---');
          // r.advertisementData.serviceData.forEach((key, value) {
          //   print("La clé: $key valeur: $value ");
          //   print(String.fromCharCodes(value as Iterable<int>));
          // });
          // ignore: collection_methods_unrelated_type
          //print(String.fromCharCodes(
          //  r.advertisementData.serviceData["fff0"] as Iterable<int>));
          // print('::::::8 ${r.advertisementData.serviceUuids}:  ---');
          // print('::::::9 ${r.advertisementData.txPowerLevel}:  ---');
          // print('::::::10 ${r.device.mtuNow}:  ---');
          // print('::::::11 ${r.device.platformName}:  ---');
          // print('::::::12 ${r.rssi}:  ---');
          print(
              '::::::2 ${r.device.platformName}: "${r.device.servicesList}" ---');
          //
          //decouverteServices(r.device);
          print(
              '::::::---::::::---::::::---::::::---::::::---::::::---::::::---::::::---::::::---');
          //
          // Reads all characteristics

          // Note: You must call discoverServices after every re-connection!
          //
          // r.device.connect();
          // //
          // r.device.discoverServices().then((services) {
          //   services.forEach((service) async {
          //     // do something with service
          //     print("les services: $service");
          //     //
          //     // Reads all characteristics
          //     var characteristics = service.characteristics;
          //     for (BluetoothCharacteristic c in characteristics) {
          //       if (c.properties.read) {
          //         List<int> value = await c.read();
          //         print("les characteristiques: $value");
          //         print(value);
          //       }
          //     }
          //   });
          // });
        }
      },
      onError: (e) => print(':::::: $e'),
    );

    // cleanup: cancel subscription when scanning stops
    FlutterBluePlus.cancelWhenScanComplete(subscription);

    // Wait for Bluetooth enabled & permission granted
    // In your real app you should use `FlutterBluePlus.adapterState.listen` to handle all states
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    // Start scanning w/ timeout
// Optional: use `stopScan()` as an alternative to timeout
    await FlutterBluePlus.startScan(
        //withServices: [Guid("180D")], // match any of the specified services
        //withNames: ["Bluno"], // *or* any of the specified names
        timeout: const Duration(seconds: 15));

    // wait for scanning to stop
    await FlutterBluePlus.isScanning.where((val) {
      print("Le scanne est fini !!!");
      //

      //
      var box = GetStorage();
      //
      box.write("devs", devs);
      //
      return val == false;
    }).first;
  }

  static sendAppareils(String token) async {
    //
    AppController controller = Get.find();
    //
    var box = GetStorage();
    //
    List devs = box.read("devs") ?? [];
    box.write("devs", []);
    //
    print("La liste de appareil: $devs");
    // devs.forEach((device) {
    //   Map d = {};
    //   d["mac"] = device.device.remoteId.str;
    //   d["name"] = device.device.advName;
    //   d["rssi"] = device.rssi;
    //   //d["token"] = token;
    //   ds.add(d);
    // });
    //
    controller.getAllDevices(token, devs);
  }
}
