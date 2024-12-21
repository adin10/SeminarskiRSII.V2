
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/providers/sobe_provider.dart';
import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

class SobeScreen extends StatefulWidget {
  static const String sobeRouteName = '/sobe';

  const SobeScreen({Key? key}) : super(key: key);

  @override
  State<SobeScreen> createState() => _SobeScreenState();
}

class _SobeScreenState extends State<SobeScreen> {
  SobaProvider? _sobaProvider;
  dynamic data = {};

  @override
  void initState() {
    super.initState();
    _sobaProvider = context.read<SobaProvider>();
    loadData();
  }

  Future<void> loadData() async {
    var tmpData = await _sobaProvider?.get(null);
    setState(() {
      data = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GetUserResponse? userData =
        ModalRoute.of(context)?.settings.arguments as GetUserResponse?;

    // Handle missing arguments
    if (userData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Missing user data. Please go back and try again.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobe"),
        backgroundColor: const Color.fromARGB(255, 200, 216, 199),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
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
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    "Pregled svih slobodnih soba",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 1 / 1, // Square image
                                  child: Container(
                                    child: Image.memory(
                                      base64Decode(x["slika"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("Broj sprata: ${x["brojSprata"]}"),
                                Text("Broj sobe: ${x["brojSobe"]}"),
                                Text("Opis sobe: ${x["opisSobe"]}"),
                                ElevatedButton(
                                  onPressed: () {
                                    IdGetter.Id = x["id"];
                                    Navigator.pushNamed(
                                      context,
                                      RezervacijScreen.dodajRezervacijuRouteName,
                                      arguments: {
                                        'userData': userData,
                                        'userId': userData.id, // Use id from GetUserResponse
                                        'selectedRoomId': x["id"],
                                      },
                                    );
                                  },
                                  child: const Text("Rezerviši sobu"),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    : const Center(
                        child: Text(
                          "Nema dostupnih soba",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
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
