import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';
import 'base_provider.dart';

class GostiProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  GostiProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<dynamic> get({String? ime, String? prezime, bool? status}) async {
  var queryParams = <String, String>{};

  if (ime != null && ime.isNotEmpty) {
    queryParams['ime'] = ime;
  }
  if (prezime != null && prezime.isNotEmpty) {
    queryParams['prezime'] = prezime;
  }

  if (status != null) {
    queryParams['status'] = status.toString();
  }

  var url = Uri.parse("${BaseProvider.baseUrl}/Gost").replace(queryParameters: queryParams);

  var response = await http!.get(url);

  if (isValidResponse(response)) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Something went wrong");
  }
}

Future<void> update(int id, Map<String, dynamic> data) async {
  final url = "${BaseProvider.baseUrl}/Gost/$id";
  final response = await http!.put(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(data),
  );
  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw Exception("Greška pri izmjeni podataka gosta");
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
