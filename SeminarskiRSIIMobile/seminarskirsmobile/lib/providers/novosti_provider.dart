import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'base_provider.dart';

class NovostiProvider with ChangeNotifier {
  HttpClient client = new HttpClient();
  IOClient? http;
  NovostiProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<dynamic> getList() async {
    var token = "";
    if (token == null) {
      throw Exception("Token not found");
    }

    var url = Uri.parse("${BaseProvider.baseUrl}/Novosti");
    
    var response = await http!.get(url, 
    // headers: {
      // "Authorization": "Bearer $token",
    // }
    );

    if (response.statusCode < 400) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("User not allowed");
    }
  }
}