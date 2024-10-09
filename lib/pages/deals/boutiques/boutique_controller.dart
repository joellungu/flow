import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';

class BoutiqueController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxString coupon = "".obs;
  //
  getAllDeals() async {
    //
    change([], status: RxStatus.loading());
    //
    String boutique = "boutique";
    Response response = await requete.getE("deal/all/$boutique");
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

  load() async {
    change([], status: RxStatus.success());
  }
}
