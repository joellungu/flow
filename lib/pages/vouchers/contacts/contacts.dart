import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:get/get.dart';

import 'contacts_controller.dart';

class MesContacts extends GetView<ContactsController> {
  List<Contact> contacts = [];
  List<String> nums = [];
  //
  MesContacts(this.contacts, this.nums){
    //
    controller.getAllContact(nums);
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes contacts"),
        centerTitle: true,
      ),
      body: controller.obx((state) {

        //
        List conts = state!;

        return ListView(
          padding: EdgeInsets.all(20),
          children: List.generate(contacts.length, (index) {
            Contact contact = contacts[index];
            //
            if(contact.phones.isNotEmpty) {
              //
              String tel = contact.phones[0].number.replaceAll(" ", "");
              //
              if(tel[0] == "0"){
                //
                tel = tel.replaceFirst("0", "00243");
              } else if (tel[0] == "+") {
                tel = tel.replaceFirst("+", "00");
              } else {
                //nums.add(num);
              }
              print("contact: $tel");
              //
              if (conts.contains(tel)) {
                //
                return ListTile(
                  onTap: () {
                    //Envoyer le voucher au contact.
                  },
                  leading: Icon(Icons.person),
                  title: Text(contact.displayName),
                  subtitle: Text("${contact.phones.isNotEmpty
                      ? contact.phones[0].number
                      : ''}"),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }),
        );
      },
      onEmpty: Container(),
        onLoading: Center(
          child: Container(
            height: 40,
            width: 40,
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

}