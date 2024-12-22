import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:seminarskirsmobile/providers/globals.dart';
import 'package:seminarskirsmobile/providers/novosti_provider.dart';
import 'package:seminarskirsmobile/providers/recenzija_provider.dart';
import 'package:seminarskirsmobile/providers/rezervacija_provider.dart';
import 'package:seminarskirsmobile/providers/sobe_provider.dart';
import 'package:seminarskirsmobile/providers/base_provider.dart';
import 'package:seminarskirsmobile/screens/change_password_screen.dart';
import 'package:seminarskirsmobile/screens/lista_rezervacija_screen.dart';
import 'package:seminarskirsmobile/screens/menu_options_screen.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/postavke_screen.dart';
import 'package:seminarskirsmobile/screens/recenzija_screen.dart';
import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';
import 'package:seminarskirsmobile/screens/signup_screen.dart';
import 'package:seminarskirsmobile/screens/sobe_screen.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SobaProvider()),
        ChangeNotifierProvider(create: (_) => NovostiProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
        ChangeNotifierProvider(create: (_) => RecenzijaProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: HomePage(),
        routes: {
          SobeScreen.sobeRouteName: (context) => SobeScreen(),
          NovostiScreen.novostiRouteName: (context) => NovostiScreen(),
          RezervacijScreen.dodajRezervacijuRouteName: (context) =>
              RezervacijScreen(),
          ListaRezervacijaScreen.listaRezervacijaRouteName: (context) =>
              ListaRezervacijaScreen(),
          RecenzijaScreen.dodajRecenzijuRouteName: (context) =>
              RecenzijaScreen(),
          OptionsScreen.optionsRouteName: (context) => OptionsScreen(),
          PostavkeScreen.routeName: (context) => PostavkeScreen(),
          ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
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
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/soba.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(children: [
                Positioned(
                  top: 150,
                  left: 70,
                  child: Center(
                      child: Text(
                    "HOTEL AS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 200),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          // Username Field
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
                                        fontSize: 14, color: Colors.grey))),
                          ),
                          SizedBox(height: 20),
                          // Password Field
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
                                      fontSize: 14, color: Colors.grey)),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Login Button
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 200, 216, 199),
                                Color.fromARGB(255, 200, 216, 199)
                              ]),
                            ),
                            child: InkWell(
                              onTap: () {
                                login(context, usernameController.text,
                                    passwordController.text);
                              },
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 10),

                              // Sign Up Button
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.lightBlueAccent,
                                    ],
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    print("Sign Up button tapped!");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
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
      final basicAuth =
          'Basic ' + base64Encode(utf8.encode(usernameAndPassword));

      final response = await http.post(
        Uri.parse("${BaseProvider.baseUrl}/Login/authenticate"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
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
      final userId = finalData.id;
      loggedUserID = userId;

      Navigator.pushNamed(
        context,
        OptionsScreen.optionsRouteName,
        arguments: {'userData': finalData},
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
      return GetUserResponse(
          id: 1,
          email: '',
          ime: '',
          korisnickoIme: '',
          prezime: '',
          telefon: '');
    }
  }
}

class GetUserResponse {
  final int id;
  final String ime;
  final String korisnickoIme;
  final String prezime;
  final String email;
  final String telefon;

  GetUserResponse(
      {required this.id,
      required this.email,
      required this.ime,
      required this.korisnickoIme,
      required this.prezime,
      required this.telefon});

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
