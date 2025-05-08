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

Future<dynamic> getList({int? gostId}) async {
  var url = Uri.parse("${BaseProvider.baseUrl}/Novosti");

  if (gostId != null) {
    url = Uri.parse("${BaseProvider.baseUrl}/Novosti?GostId=$gostId");
  }

  var response = await http!.get(url);

  if (response.statusCode < 400) {
    var data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception("User not allowed");
  }
}

Future<void> markAsRead(int novostId, int gostId) async {
    var url = Uri.parse("${BaseProvider.baseUrl}/Novosti/markAsRead");

    var response = await http!.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'novostId': novostId,
        'gostId': gostId,
      }),
    );

    if (response.statusCode >= 400) {
      throw Exception("Greška prilikom označavanja kao pročitano.");
    }
  }
}