import 'package:get/get.dart';

class AttenteController extends GetxController with StateMixin<List> {

  load() async {
    change([], status: RxStatus.success());
  }
}