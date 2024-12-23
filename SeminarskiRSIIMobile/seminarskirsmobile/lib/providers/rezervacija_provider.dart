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
        // Handle API error response
        return null;
      }
    } catch (error) {
      // Handle network or other errors
      return null;
    }
  }

  Future<void> delete(String id) async {
    final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija/$id"); 

    final response = await http!.delete(url);

    if (response.statusCode == 200) {
      print('Successfully deleted');
      notifyListeners();
    } else {
      throw Exception('Failed to delete item');
    }
  }

}
