import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/providers/base_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/izvjestaj_sobe_screen.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';

class IzvjestajSobaProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  IzvjestajSobaProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<SobaIzvjestaj?> fetchIzvjestaj(int sobaId) async {
  final url = Uri.parse("${BaseProvider.baseUrl}/Soba/sobaIzvjestaj/$sobaId");

  var response = await http!.get(
      url,
    );

 if (isValidResponse(response)) {
    var data = jsonDecode(response.body);
    return SobaIzvjestaj.fromJson(data);
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
