import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/base_provider.dart';
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
import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/gosti_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/novosti_list_screen.dart';
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
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/profileHotel.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Form content
//           Center(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(labelText: 'Username'),
//                     controller: _usernameController,
//                   ),
//                   SizedBox(height: 8),
//                   TextField(
//                     decoration: InputDecoration(labelText: 'Password'),
//                     obscureText: true,
//                     controller: _passwordController,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       var username = _usernameController.text;
//                       var password = _passwordController.text;
//                       print('login $username i $password');

//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const NovostiListScreen()));
//                     },
//                     child: Text('Submit'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Username and password cannot be empty.");
      return;
    }

    final Uri url = Uri.parse("${BaseProvider.baseUrl}/Login/authenticateAdministration");
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {'username': username, 'password': password};

    try {
       final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Login successful, navigate to the desired screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NovostiListScreen()),
        );
      } else {
        // Login failed
        final Map<String, dynamic> responseBody = json.decode(response.body);
        String errorMessage = responseBody['message'] ?? 'Login failed. Please try again.';
        _showErrorDialog(context, errorMessage);
      }
    } catch (error) {
      _showErrorDialog(context, "An error occurred. Please try again later.");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profileHotel.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form content
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _login(context),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}