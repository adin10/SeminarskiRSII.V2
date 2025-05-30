import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';
import 'base_provider.dart';

class RecenzijaProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  RecenzijaProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

Future<List<dynamic>> get(dynamic searchObject) async {
  var queryString = "";

  if (searchObject != null) {
    final queryParameters = <String, String>{};

    searchObject.forEach((key, value) {
      if (value != null && value.toString().isNotEmpty) {
        queryParameters[key] = value.toString();
      }
    });

    queryString = "?" + Uri(queryParameters: queryParameters).query;
  }

  final url = Uri.parse("${BaseProvider.baseUrl}/Recenzija$queryString");
      print("RecenzijaProvider -> Requesting URL: $url");


  final response = await http!.get(url);

  if (isValidResponse(response)) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Something went wrong");
  }
}
  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<dynamic> update(int id) async {
    var url = Uri.parse("${BaseProvider.baseUrl}/Recenzija/ObrisiKomentar/$id");

    // var jsonRequest = jsonEncode(data);
    var response = await http!.put(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Greška prilikom ažuriranja: ${response.body}");
    }
  }

  Map<String, String> CreateHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";
    var headers = {
      "Content-Type": "Application/json",
      "Authorization": basicAuth
    };
    return headers;
  }
}
