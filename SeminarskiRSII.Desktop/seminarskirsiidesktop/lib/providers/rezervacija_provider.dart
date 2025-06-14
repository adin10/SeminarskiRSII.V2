import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';
import 'base_provider.dart';

class RezervacijaProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  RezervacijaProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  // Future<List<dynamic>> get(dynamic searchObject) async {
  //   var url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija");
  //   var response = await http!.get(
  //     url,
  //   );
  //   if (isValidResponse(response)) {
  //     var data = jsonDecode(response.body);
  //     return data;
  //   } else {
  //     return throw Exception("Something wenw wrong");
  //   }
  // }

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

  final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija$queryString");

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

    Future<void> delete(String id) async {
    final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija/$id");

    final response = await http!.delete(url);

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to delete item');
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
