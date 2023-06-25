// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }




import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
// import 'dart:js';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
// import 'package:stranivarimobile/providers/applications_provider.dart';
// import 'package:stranivarimobile/providers/base_provider.dart';
// import 'package:stranivarimobile/providers/event_notifications_provider.dart';
// import 'package:stranivarimobile/providers/event_plan_and_programme_provider.dart';
// import 'package:stranivarimobile/providers/event_provider.dart';
// import 'package:stranivarimobile/providers/event_schools_provider.dart';
// import 'package:stranivarimobile/providers/games_provider.dart';
// import 'package:stranivarimobile/providers/school_material_provider.dart';
// import 'package:stranivarimobile/providers/school_volunteers_provider.dart';
// import 'package:stranivarimobile/providers/send_application_provider.dart';
// import 'package:stranivarimobile/screens/applications/applications_screen.dart';
// import 'package:stranivarimobile/screens/events/events_list_screen.dart';
// import 'package:stranivarimobile/screens/games/games_screen.dart';
// import 'package:stranivarimobile/screens/material/school_material_screen.dart';
// import 'package:stranivarimobile/screens/notifications/event_notifications_screen.dart';
// import 'package:stranivarimobile/screens/plan_and_programme/event_plan_and_programee_screen.dart';
// import 'package:stranivarimobile/screens/schools/event_schools_list_screen.dart';
import 'package:http/http.dart' as http;
import 'package:seminarskirsmobile/providers/novosti_provider.dart';
import 'package:seminarskirsmobile/providers/rezervacija_provider.dart';
import 'package:seminarskirsmobile/providers/sobe_provider.dart';
import 'package:seminarskirsmobile/providers/base_provider.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';
import 'package:seminarskirsmobile/screens/sobe_screen.dart';
// import 'package:stranivarimobile/screens/volunteers/school_volunteers_screen.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SobaProvider()),
        ChangeNotifierProvider(create: (_) => NovostiProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijaProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: HomePage(),
        routes: {
          SobeScreen.sobeRouteName: (context) => SobeScreen(),
          NovostiScreen.novostiRouteName: (context) => NovostiScreen(),
          RezervacijScreen.dodajRezervacijuRouteName: (context) => RezervacijScreen(),
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