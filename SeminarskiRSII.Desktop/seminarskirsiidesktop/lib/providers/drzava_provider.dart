import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';
import 'base_provider.dart';

class DrzavaProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  DrzavaProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<dynamic> get(dynamic searchObject) async {
    var url = Uri.parse("${BaseProvider.baseUrl}/Drzava");

    var response = await http!.get(
      url,
    );

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return throw Exception("Something wenw wrong");
    }
  }

  Future<void> delete(String id) async {
    final url = Uri.parse("${BaseProvider.baseUrl}/Drzava/$id");

    final response = await http!.delete(url);

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to delete item');
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
