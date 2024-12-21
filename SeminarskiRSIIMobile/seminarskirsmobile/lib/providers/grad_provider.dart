import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as httpClient; // Use a different prefix

class GradProvider with ChangeNotifier {
  HttpClient client = HttpClient();
  IOClient? http;
  GradProvider() {
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
  var url = Uri.parse("${BaseProvider.baseUrl}/Grad");

  // Make the HTTP GET request
  var response = await http!.get(url);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  // Validate response
  if (isValidResponse(response)) {
    // Check if the response body is empty or null
    if (response.body.isNotEmpty) {
      try {
        var data = jsonDecode(response.body); // Decode response body
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
