import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as httpClient; // Use a different prefix

class SobaProvider with ChangeNotifier {
  HttpClient client = new HttpClient();
  IOClient? http;
  SobaProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<dynamic> get(dynamic searchObject) async {
    var token = "";
    if (token == null) {
      throw Exception("Token not found");
    }

    var url = Uri.parse("${BaseProvider.baseUrl}/Soba");

    var response = await http!.get(
      url,
      // headers: {
      // "Authorization": "Bearer $token",
      // }
    );

    if (response.statusCode < 400) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("User not allowed");
    }
  }

  Future<dynamic> getCjenovnik(Map<String, String> params) async {

    var uri = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik");
    final newUri = uri.replace(queryParameters: params);

      var response = await http!.get(newUri);

    if (isValidResponse(response)) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Greška pri dohvaćanju slobodnih soba");
    }
  }

  Future<List<dynamic>> getFiltered(Map<String, String> params) async {
    var uri = Uri.parse("${BaseProvider.baseUrl}/Soba/GetSlobodneSobe");
    final newUri = uri.replace(queryParameters: params);
    var response = await http!.get(newUri);
    if (isValidResponse(response)) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Greška pri dohvaćanju slobodnih soba");
    }
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

  Future<List<dynamic>> getRecommendations() async {
    var url = Uri.parse("${BaseProvider.baseUrl}/soba/recommendation");
    var response = await http!.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load recommendations");
    }
  }
}
