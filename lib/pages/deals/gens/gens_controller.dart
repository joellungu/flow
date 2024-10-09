import 'package:get/get.dart';

class GensController extends GetxController with StateMixin<List> {
  //
  load() async {
    change([], status: RxStatus.success());
  }
}
