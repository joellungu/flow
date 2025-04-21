import 'dart:convert';

import 'package:get/get.dart';
//
import 'package:dio/dio.dart' as d;

//
final dio = d.Dio();

class Requete extends GetConnect {
  //
  //static String url =
  //  "https://app-b0919ce7-9436-4291-8b83-28a08589df42.cleverapps.io";
  //
  //static String url = "http://10.0.2.2:8080";
  //
  Map<String, String> headers = {'Content-Type': 'application/json'};
  //
  static String url = "http://192.168.100.253:8080";
  static String urlCricket = "http://192.168.100.253:8080/";
  //
  //static String url = "http://10.0.0.2:8080";
  //static String urlCricket = "http://10.0.0.2:8080/";
  //
  Future<Response> getE(String path) async {
    return get(
      "$url/$path",
      headers: headers,
    );
  }

  Future<Response> postE(String path, var e) async {
    return post("$url/$path", headers: headers, jsonEncode(e));
  }

  Future<Response> putE(String path, var e) async {
    return put("$url/$path", headers: headers, jsonEncode(e));
  }

  Future<Response> deleteE(String path) async {
    return delete(
      "$url/$path",
      headers: headers,
    );
  }

  //
  Future<d.Response> getEc(String path) async {
    return dio.get(
      "$urlCricket$path",
      options: d.Options(headers: headers),
    );
  }

  Future<d.Response> postEc(String path, var e) async {
    return dio.post("$urlCricket$path",
        options: d.Options(headers: headers), data: e);
  }

  Future<Response> putEc(String path, var e) async {
    return put("$urlCricket$path", headers: headers, jsonEncode(e));
  }

  Future<Response> deleteEc(String path) async {
    return delete(
      "$urlCricket$path",
      headers: headers,
    );
  }
}
