import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';

class VoucherController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxDouble total = 0.0.obs;
  //
  RxList couponsEnregistre = [].obs;
  //
  RxString coupon = "".obs;
  //
  getAllCoupons() async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("coupon/all");
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
}
