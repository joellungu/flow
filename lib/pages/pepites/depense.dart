import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

import 'montant.dart';

class Depense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(),
      body: QRCodeDartScanView(
        scanInvertedQRCode: true,
        // enable scan invert qr code ( default = false)
        typeScan: TypeScan.live,
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.red.shade700, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // if TypeScan.takePicture will try decode when click to take a picture(default TypeScan.live)
        // intervalScan: const Duration(seconds:1)
        // onResultInterceptor: (old,new){
        //  do any rule to controll onCapture.
        // }
        // takePictureButtonBuilder: (context,controller,isLoading){ // if typeScan == TypeScan.takePicture you can customize the button.
        //    if(loading) return CircularProgressIndicator();
        //    return ElevatedButton(
        //       onPressed:controller.takePictureAndDecode,
        //       child:Text('Take a picture'),
        //    );
        // }
        // resolutionPreset: = QrCodeDartScanResolutionPreset.high,
        // formats: [ // You can restrict specific formats.
        //  BarcodeFormat.qrCode,
        //  BarcodeFormat.aztec,
        //  BarcodeFormat.dataMatrix,
        //  BarcodeFormat.pdf417,
        //  BarcodeFormat.code39,
        //  BarcodeFormat.code93,
        //  BarcodeFormat.code128,
        //  BarcodeFormat.ean8,
        //  BarcodeFormat.ean13,
        // ],
        onCapture: (Result result) {
          debugPrint("Resultat: ${result.text}");
          Get.to(Montant(int.parse(result.text)));
          // do anything with result
          // result.text
          // result.rawBytes
          // result.resultPoints
          // result.format
          // result.numBits
          // result.resultMetadata
          // result.time
        },
      ),
    );
  }
  //
}
