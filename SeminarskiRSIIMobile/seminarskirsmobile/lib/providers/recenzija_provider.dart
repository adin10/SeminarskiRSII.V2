import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'base_provider.dart';

class RecenzijaProvider with ChangeNotifier {
  HttpClient client = new HttpClient();
  IOClient? http;
  RecenzijaProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<List<dynamic>?> get() async {
  try {
    final response = await http!.get(
      Uri.parse('${BaseProvider.baseUrl}/Recenzija'),
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

Future<List<dynamic>> getListBySobaId(int sobaId) async {
  final url = Uri.parse('${BaseProvider.baseUrl}/Recenzija/GetListBySobaId?sobaId=$sobaId');
  
  final response = await http!.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Greška prilikom dohvata recenzija.");
  }
}
}