import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';

class MarqueController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxString coupon = "".obs;
  //
  getAllDeals() async {
    //
    change([], status: RxStatus.loading());
    //
    String marque = "marque";
    Response response = await requete.getE("coupon/all/$marque");
    //
    if (response.isOk) {
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
      //
      change(response.body, status: RxStatus.success());
    } else {
      //
      print("rep: ${response.statusCode}");
      print("rep: ${response.body}");
      change([], status: RxStatus.empty());
    }
  }

  //
  load() async {
    change([], status: RxStatus.success());
  }
}
