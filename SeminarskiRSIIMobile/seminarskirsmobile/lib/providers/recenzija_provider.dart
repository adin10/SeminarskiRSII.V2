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
    // Make the API request with the gostID parameter
    final response = await http!.get(
      Uri.parse('${BaseProvider.baseUrl}/Recenzija'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // Handle API error response
      return null;
    }
  } catch (error) {
    // Handle network or other errors
    return null;
  }
}
}