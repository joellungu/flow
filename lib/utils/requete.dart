import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart' as d;
//final dio = d.Dio();

class Requete extends GetConnect {
  //
  static String url =
      "https://app-b0919ce7-9436-4291-8b83-28a08589df42.cleverapps.io";
  //
  //static String url = "http://10.0.2.2:8080";
  //
  //static String url = "http://192.168.100.253:8080";
  //
  Map<String, String> headers = {'Content-Type': 'application/json'};
  //
  //static String urlCricket = "http://192.168.100.253:8080";
  static String urlCricket = "https://cricketserver-5f8fa4dbc848.herokuapp.com";
  //
  //static String url = "http://192.168.100.27:8080";
  //static String url = "http://192.168.1.185/www/sursa";
  Future<http.Response> getE(String path) async {
    return http.get(
      Uri.parse("$url/$path"),
      headers: headers,
    );
  }

  Future<http.Response> postE(String path, var e) async {
    return http.post(Uri.parse("$url/$path"),
        headers: headers, body: jsonEncode(e));
  }

  Future<http.Response> putE(String path, var e) async {
    return http.put(Uri.parse("$url/$path"),
        headers: headers, body: jsonEncode(e));
  }

  Future<http.Response> deleteE(String path) async {
    return http.delete(
      Uri.parse("$url/$path"),
      headers: headers,
    );
  }

  //
  Future<http.Response> getEc(String path) async {
    return http.get(
      Uri.parse("$urlCricket/$path"),
      headers: headers,
    );
  }

  Future<http.Response> postEc(String path, var e) async {
    return http.post(Uri.parse("$urlCricket/$path"),
        headers: headers, body: jsonEncode(e));
  }

  Future<http.Response> putEc(String path, var e) async {
    return http.put(Uri.parse("$urlCricket/$path"),
        headers: headers, body: jsonEncode(e));
  }

  Future<http.Response> deleteEc(String path) async {
    return http.delete(
      Uri.parse("$urlCricket/$path"),
      headers: headers,
    );
  }
}
