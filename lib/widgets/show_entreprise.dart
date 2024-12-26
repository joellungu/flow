import 'dart:convert';
import 'package:flow/utils/requete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class ShowEntreprise extends StatelessWidget {
  RxString entreprise;
  RxInt idEntreprise;
  //
  ShowEntreprise(this.entreprise, this.idEntreprise);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entreprise"),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            //color: Colors.yellow,
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: getAll(),
              builder: (c, t) {
                if (t.hasData) {
                  //
                  List entreprises = t.data as List;
                  //
                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: List.generate(entreprises.length, (e) {
                      //
                      Map d = entreprises[e];
                      //
                      return ListTile(
                        onTap: () {
                          //
                          print("data: $d");
                          entreprise.value = d['nom'];
                          idEntreprise.value = d['id'];
                          //
                          Get.back();
                          //
                        },
                        leading: SvgPicture.asset(
                          "assets/SolarDeliveryLineDuotone.svg",
                          height: 30,
                          width: 30,
                          semanticsLabel: 'Dart Logo',
                          color: Colors.black,
                        ),
                        title: RichText(
                          text: TextSpan(
                            text: "Kin Marche\n",
                            style: TextStyle(
                              color: HexColor("#2F565D"),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: "Super reduction",
                                style: TextStyle(
                                  color: Colors
                                      .blue.shade400, //HexColor("#2F565D"),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text("Jusqu'au 10/05/2025"),
                      );
                    }),
                  );
                } else if (t.hasError) {
                  return Container();
                }
                return Center(
                  child: Container(
                    height: 30,
                    width: 30,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  //
  Future<List> getAll() async {
    //
    Requete requete = Requete();
    //
    http.Response response = await requete.getE("entreprises");
    //
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202 ||
        response.statusCode == 203 ||
        response.statusCode == 204) {
      return jsonDecode(response.body);
    } else {
      //
      return [];
    }
  }
}
