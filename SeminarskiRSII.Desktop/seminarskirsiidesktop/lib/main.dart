// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/cjenovnik_provider.dart';
import 'package:seminarskirsiidesktop/providers/drzava_provider.dart';
import 'package:seminarskirsiidesktop/providers/gosti_provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/providers/novosti_provider.dart';
import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
import 'package:seminarskirsiidesktop/providers/recenzija_provider.dart';
import 'package:seminarskirsiidesktop/providers/rezervacija_provider.dart';
import 'package:seminarskirsiidesktop/providers/soba_provider.dart';
import 'package:seminarskirsiidesktop/providers/sobaosoblje_provider.dart';
import 'package:seminarskirsiidesktop/providers/sobastatus_provider.dart';
import 'package:seminarskirsiidesktop/providers/vrstaosoblja_provider.dart';
import 'package:seminarskirsiidesktop/screens/drzava_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/gosti_list_screen.dart';
import 'package:seminarskirsiidesktop/utils/util.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GostiProvider()),
      ChangeNotifierProvider(create: (_) => OsobljeProvider()),
      ChangeNotifierProvider(create: (_) => GradProvider()),
      ChangeNotifierProvider(create: (_) => DrzavaProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
      ChangeNotifierProvider(create: (_) => RecenzijaProvider()),
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => SobaStatusProvider()),
      ChangeNotifierProvider(create: (_) => VrstaOsobljaProvider()),
      ChangeNotifierProvider(create: (_) => CjenovnikProvider()),
      ChangeNotifierProvider(create: (_) => SobaProvider()),
      ChangeNotifierProvider(create: (_) => SobaOsobljeProvider())
    ],
    child: const MyMaterialApp(),
    //  child: MaterialApp(
    //     debugShowCheckedModeBanner: true,
    //     routes: {
    //       DrzavaListScreen.drzavaRouteName: (context) => const DrzavaListScreen()    
    //     },
    //     onGenerateRoute: (settings) {},
    //   ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyAppBar(),
      home: const MyMaterialApp(),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Counter();
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 1;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('You have pushed button $_count times'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: Text('Increment'),
        )
      ],
    );
  }
}

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          color: Colors.blue,
          child: Text('Example'),
          alignment: Alignment.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text('data1'), Text('data2'), Text('data3')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text('red novi 1'), Text('red novi 2')],
        ),
      ],
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'RSII Material App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage());
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  // late GostiProvider _gostiProvider;
  @override
  Widget build(BuildContext context) {
    // _gostiProvider = context.read<GostiProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Card(
            child: Column(children: [
              Image.asset(
                'assets/images/soba.jpg',
                height: 150,
                width: 150,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Username'),
                controller: _usernameController,
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                controller: _passwordController,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    print('login $username i $password');

                    // Authorization.username = username;
                    // Authorization.password = password;
                    // try {
                      // var data = await _gostiProvider.get(null);
                      // print("data,$data");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GostiListScreen()));
                    // } on Exception catch (e) {
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext contex) => AlertDialog(
                      //           title: Text("error"),
                      //           content: Text(e.toString()),
                      //           actions: [
                      //             TextButton(
                      //                 onPressed: () => {Navigator.pop(context)},
                      //                 child: Text("OK"))
                      //           ],
                      //         ));
                    // }
                  },
                  child: Text('Submit'))
            ]),
          ),
        ),
      ),
    );
  }
}
