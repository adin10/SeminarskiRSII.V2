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
import 'package:seminarskirsmobile/screens/recommendation_screen.dart';
import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';
import 'package:seminarskirsmobile/screens/signup_screen.dart';
import 'package:seminarskirsmobile/screens/sobe_screen.dart';
import 'package:seminarskirsmobile/screens/update_profile_screen.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SobaProvider()),
        ChangeNotifierProvider(create: (_) => NovostiProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
        ChangeNotifierProvider(create: (_) => RecenzijaProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
          // UpdateProfileScreen.routeName: (context) => UpdateProfileScreen(),
          RecommendationScreen.routeName: (context) => RecommendationScreen(),
        },
      onGenerateRoute: (settings) {
          if (settings.name == UpdateProfileScreen.routeName) {
            final args = settings.arguments as GetUserResponse;

            return MaterialPageRoute(
              builder: (context) => UpdateProfileScreen(userData: args),
            );
          }
          if (settings.name == RecommendationScreen.routeName) {
            return MaterialPageRoute(
                builder: (context) => RecommendationScreen());
          }
          return null;
        },
      ),
    ));

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
              child: Stack(
                children: [
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "HOTEL AS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 4,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 180),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person, color: Colors.grey),
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock, color: Colors.grey),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 65, 105, 225),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 60, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 5,
                                    ),
                                    onPressed: () {
                                      login(context, usernameController.text,
                                          passwordController.text);
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Nemate kreiran profil?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    side: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Kreiraj profil",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
        throw Exception('Pogresan Username ili Lozinka');
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
        telefon: '',
      );
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

  GetUserResponse({
    required this.id,
    required this.email,
    required this.ime,
    required this.korisnickoIme,
    required this.prezime,
    required this.telefon,
  });

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
