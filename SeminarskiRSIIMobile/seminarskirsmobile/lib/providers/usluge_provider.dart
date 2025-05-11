import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as httpClient;

class UslugeProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  UslugeProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

bool isValidResponse(httpClient.Response response) {
  if (response.statusCode < 299) {
    return true;
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized");
  } else {
    throw Exception("Something went wrong");
  }
}

Future<dynamic> get(dynamic searchObject) async {
  var url = Uri.parse("${BaseProvider.baseUrl}/Usluge");

  var response = await http!.get(url);

  if (isValidResponse(response)) {

    if (response.body.isNotEmpty) {
      try {
        var data = jsonDecode(response.body);
        return data;
      } catch (e) {
        throw Exception("Failed to decode response body: $e");
      }
    } else {
      throw Exception("Empty or null response body");
    }
  } else {
    throw Exception("Something went wrong");
  }
}
}
