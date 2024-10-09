import 'package:flow/utils/requete.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class ContactsController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  getAllContact(List numeraux) async {
    change([], status: RxStatus.loading());
    Response response = await requete.postE("utilisateur/contacts", numeraux);
    if(response.isOk){
      change(response.body, status: RxStatus.success());
    }else{
      change(response.body, status: RxStatus.success());
    }
  }
}