import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'base_provider.dart';

class RezervacijaProvider with ChangeNotifier {
  HttpClient client = new HttpClient();
  IOClient? http;
  RezervacijaProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<List<dynamic>?> get({int? gostID}) async {
    try {
      final response = await http!.get(
        Uri.parse('${BaseProvider.baseUrl}/Rezervacija?gostID=$gostID'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<bool> otkazi(String id) async {
  try {
    final response = await http!.delete(
      Uri.parse("${BaseProvider.baseUrl}/Rezervacija/$id"),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

}
