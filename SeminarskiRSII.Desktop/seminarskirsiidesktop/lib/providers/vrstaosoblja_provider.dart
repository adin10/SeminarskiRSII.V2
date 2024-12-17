
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';
import 'base_provider.dart';

class VrstaOsobljaProvider with ChangeNotifier{
  HttpClient client = HttpClient();
  IOClient? http;
  VrstaOsobljaProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }
  
  Future<dynamic> get(dynamic searchObject) async {
    var url = Uri.parse("${BaseProvider.baseUrl}/VrstaOsoblja");
    // var headers = CreateHeaders();
    // var response = await http!.get(url, headers: headers);
        var response = await http!.get(url,);
        print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
    if(isValidResponse(response)){
    var data = jsonDecode(response.body);
    return data;
    }
    else{
      return throw Exception("Something wenw wrong");
    }
  }

      Future<void> delete(String id) async {
    final url = Uri.parse("${BaseProvider.baseUrl}/VrstaOsoblja/$id"); // Adjust the URL as needed

    final response = await http!.delete(url);

    if (response.statusCode == 200) {
      // Optionally handle successful deletion here
      print('Successfully deleted');
      notifyListeners(); // Notify listeners if you want to refresh data
    } else {
      throw Exception('Failed to delete item');
    }
  }

  bool isValidResponse(Response response){
    if(response.statusCode < 299){
      return true;
    }
    else if(response.statusCode == 401){
      throw Exception("Unauthorized");
    }
    else{
      throw Exception("Something went wrong");
    }
  }

  Map<String,String> CreateHeaders(){
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String basicAuth = "Basic ${base64Encode(utf8.encode('$username:$password'))}";
    var headers = {
      "Content-Type" : "Application/json",
      "Authorization" : basicAuth
    };
    return headers;
  }
}