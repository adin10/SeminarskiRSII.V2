import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/providers/sobe_provider.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

import '../main.dart';

class SobeScreen extends StatefulWidget {
  static const String sobeRouteName = '/sobe';

  const SobeScreen({Key? key}) : super(key: key);

  @override
  State<SobeScreen> createState() => _SobeScreenState();
}

class _SobeScreenState extends State<SobeScreen> {
  SobaProvider? _sobaProvider = null;
  dynamic data = {};

  @override
  void initState() {
    super.initState();
    _sobaProvider = context.read<SobaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _sobaProvider?.get(null);
    setState(() {
      data = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      // Handle the case when arguments are not available
      // You can show an error message or navigate back to the previous screen
      return Scaffold(
        body: Center(
          child: Text('Error: Missing arguments'),
        ),
      );
    }

    final GetUserResponse userData = args['userData'] as GetUserResponse;
    final int userId = args['userId'] as int;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobe"),
        backgroundColor: Color.fromARGB(255, 200, 216, 199),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/green.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: data.isNotEmpty
                    ? PageView(
                        children: data.map<Widget>((x) {
                          return Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Pregled svih slobodnih soba",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio:
                                      1 / 1, // Omjer 1:1 za kvadratnu sliku
                                  child: Expanded(
                                    child: Container(
                                      child: Image.memory(
                                        base64Decode(x["slika"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Text("ID: ${x["id"]}"),
                                Text("Broj sprata: ${x["brojSprata"]}"),
                                Text("Broj sobe: ${x["brojSobe"]}"),
                                Text("Opis sobe: ${x["opisSobe"]}"),
                                // Text("Status sobe: ${x["sobaStatus"]["status"]}"),
                                ElevatedButton(
                                  onPressed: () {
                                    IdGetter.Id = x["id"];
                                    Navigator.pushNamed(
                                      context,
                                      RezervacijScreen
                                          .dodajRezervacijuRouteName,
                                      arguments: {
                                        'userData': userData,
                                        'userId': userId,
                                        'selectedRoomId': x["id"]
                                      },
                                    );
                                  },
                                  child: Text("Rezervisi sobu"),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    : Container(),
              ),
              SizedBox(height: 10),
              // Icon(
              //   // Icons.arrow_downward,
              //   // size: 36,
              //   // color: Colors.black,
              // ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class IdGetter {
  static int Id = 0;
}
