import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';
import 'base_provider.dart';

class CjenovnikProvider with ChangeNotifier{
  HttpClient client = new HttpClient();
  IOClient? http;
  CjenovnikProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }
  
  Future<dynamic> get(dynamic searchObject) async {
    var url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik");
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
      return throw new Exception("Something wenw wrong");
    }
  }

  bool isValidResponse(Response response){
    if(response.statusCode < 299){
      return true;
    }
    else if(response.statusCode == 401){
      throw new Exception("Unauthorized");
    }
    else{
      throw new Exception("Something went wrong");
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