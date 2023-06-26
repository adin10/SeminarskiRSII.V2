
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:seminarskirsmobile/providers/globals.dart';
import 'package:seminarskirsmobile/providers/novosti_provider.dart';
import 'package:seminarskirsmobile/providers/rezervacija_provider.dart';
import 'package:seminarskirsmobile/providers/sobe_provider.dart';
import 'package:seminarskirsmobile/providers/base_provider.dart';
import 'package:seminarskirsmobile/screens/lista_rezervacija_screen.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';
import 'package:seminarskirsmobile/screens/sobe_screen.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SobaProvider()),
        ChangeNotifierProvider(create: (_) => NovostiProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijaProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: HomePage(),
        routes: {
          SobeScreen.sobeRouteName: (context) => SobeScreen(),
          NovostiScreen.novostiRouteName: (context) => NovostiScreen(),
          RezervacijScreen.dodajRezervacijuRouteName: (context) => RezervacijScreen(),
          ListaRezervacijaScreen.listaRezervacijaRouteName: (context) => ListaRezervacijaScreen(),
        },
        onGenerateRoute: (settings) {},
      ),
    ));

final style = TextStyle(fontSize: 62, fontWeight: FontWeight.bold);

class HomePage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 784,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/aeroplane.png"),
                      fit: BoxFit.cover)
                  ),
              child: Stack(children: [
                Positioned(
                  top: 160,
                  left: 70,
                  child: Center(
                      child: Text(
                    "HOTEL AS",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 250),
                    child: Container(
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: Colors.grey))),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            obscureText: true,
                          ),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.fromLTRB(2, 10, 2, 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 244, 227, 222),
                                Color.fromARGB(255, 217, 215, 208)
                              ])),
                          child: InkWell(
                            onTap: () {
                                  // Navigator.pushNamed(context, SobeScreen.sobeRouteName);
                              login(context, usernameController.text,
                                  passwordController.text);
                            },
                            child: Center(child: Text("Login")),
                          ),
                        )
                      ]),
                    ))
              ]),
            ),
          ],
        ),
      ),
    );
  }

Future<GetUserResponse> login(
  BuildContext context, String username, String password) async {
  try {
          final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
    final usernameAndPassword = '$username:$password';
    final basicAuth = 'Basic ' + base64Encode(utf8.encode(usernameAndPassword));

    final response = await http.post(
        Uri.parse("${BaseProvider.baseUrl}/Login/authenticate"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': basicAuth, // Add Basic Authentication header
      },
      body: jsonEncode({"Username": username, "Password": password}),
        );

    if (response.statusCode == 401) {
      throw Exception('Invalid credentials');
    }
    if (response.statusCode != 200) {
      throw Exception('Wrong username or password');
    }

    final finalData = GetUserResponse.fromJson(jsonDecode(response.body));
    final userId = finalData.id; // Dohvaćanje ID-ja korisnika
    loggedUserID = userId;
    Navigator.pushNamed(context, SobeScreen.sobeRouteName,
     arguments: {
      'userData': finalData,
      'userId': finalData.id,
     },
    );
    return finalData;
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
    return GetUserResponse(id: 1, email: '', ime: '', korisnickoIme: '', prezime: '', telefon: '');
  }
  }
}

class GetUserResponse {
  final int id;
  // final String username;
  final String ime;
  final String korisnickoIme;
  final String prezime;
  final String email;
  final String telefon;

  GetUserResponse({required this.id ,required this.email, required this.ime, required this.korisnickoIme, required this.prezime, required this.telefon});

  factory GetUserResponse.fromJson(Map<String, dynamic> json) {
    return GetUserResponse(
      id: json['id'],
      email: json['email'],
      ime: json['ime'],
      korisnickoIme: json['korisnickoIme'],
      prezime: json['prezime'],
      telefon: json['telefon'],
    );
  }
}
