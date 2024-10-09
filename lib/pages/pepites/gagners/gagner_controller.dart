import 'package:get/get.dart';

class GagnerController extends GetxController with StateMixin<List> {

  load() async {
    change([], status: RxStatus.success());
  }
}