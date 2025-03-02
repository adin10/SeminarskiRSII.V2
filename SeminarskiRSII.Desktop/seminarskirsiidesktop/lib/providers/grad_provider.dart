import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';
import 'base_provider.dart';

class GradProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  GradProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<dynamic> get(Map<String, dynamic>? searchObject) async {
  var uri = Uri.parse("${BaseProvider.baseUrl}/Grad").replace(
    queryParameters: searchObject != null ? 
      searchObject.map((key, value) => MapEntry(key, value.toString())) 
      : {},
  );

  print("Request URL: $uri"); // Debugging

  var response = await http!.get(uri);

  if (isValidResponse(response)) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Something went wrong");
  }
}

  Future<void> delete(String id) async {
    final url = Uri.parse("${BaseProvider.baseUrl}/Grad/$id");

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
