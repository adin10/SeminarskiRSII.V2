import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/providers/base_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/izvjestaj_gosti_screen.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';

class IzvjestajGostProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  IzvjestajGostProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<GostIzvjestaj?> fetchIzvjestaj(int gostId) async {
  final url = Uri.parse("${BaseProvider.baseUrl}/Gost/gostIzvjestaj/$gostId");

  var response = await http!.get(
      url,
    );

 if (isValidResponse(response)) {
    var data = jsonDecode(response.body);
    return GostIzvjestaj.fromJson(data);
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
