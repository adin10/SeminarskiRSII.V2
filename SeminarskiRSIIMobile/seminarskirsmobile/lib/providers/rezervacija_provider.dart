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

  // Future<dynamic> get() async {
  //   var token = "";
  //   if (token == null) {
  //     throw Exception("Token not found");
  //   }

  //   var url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija");
    
  //   var response = await http!.get(url, 
  //   // headers: {
  //     // "Authorization": "Bearer $token",
  //   // }
  //   );

  //   if (response.statusCode < 400) {
  //     var data = jsonDecode(response.body);
  //     return data;
  //   } else {
  //     throw Exception("User not allowed");
  //   }
  // }

  Future<List<dynamic>?> get({int? gostID}) async {
  try {
    // Make the API request with the gostID parameter
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
}