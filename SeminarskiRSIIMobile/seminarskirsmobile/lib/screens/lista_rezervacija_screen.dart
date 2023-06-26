

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/providers/globals.dart';
import 'package:seminarskirsmobile/providers/rezervacija_provider.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/recenzija_screen.dart';

import '../main.dart';

class ListaRezervacijaScreen extends StatefulWidget {
  static const String listaRezervacijaRouteName = '/listaRezervacija';

  const ListaRezervacijaScreen({Key? key}) : super(key: key);

  @override
  State<ListaRezervacijaScreen> createState() =>
      _ListaRezervacijaScreenState();
}

class _ListaRezervacijaScreenState extends State<ListaRezervacijaScreen> {
  RezervacijaProvider? _rezervacijaProvider;
  List<dynamic> data = []; // Update data variable type to List<dynamic>

  @override
  void initState() {
    super.initState();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    // final gostID = 10;
    loadData(loggedUserID);
  }

// Future<void> loadData() async {
//   List<dynamic>? tmpData = await _rezervacijaProvider?.get(); // Update the type to List<dynamic>?
//   setState(() {
//     data = tmpData ?? []; // Assign tmpData to data variable, and handle null case
//   });
// }

Future<void> loadData(int gostID) async {
  List<dynamic>? tmpData = await _rezervacijaProvider?.get(gostID: gostID);
  setState(() {
    data = tmpData ?? [];
  });
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista rezervacija za gosta "),
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
                child: data.isNotEmpty ? PageView(
                  children: data.map<Widget>((x) {
                    return Card(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1/1, // Omjer 1:1 za kvadratnu sliku
                            child: Expanded(
                              child: Container(
                                child: Image.memory(
                                  base64Decode(x["soba"]["slika"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("Pocetak rezervacije: ${x["datumRezervacije"]}"),
                          Text("Zavrsetak rezervacije: ${x["zavrsetakRezervacije"]}"),
                          Text("Broj sobe: ${x["soba"]["brojSobe"]}"),
                          Text("Gost: ${x["gost"]["ime"]}"),
                          ElevatedButton(
                            onPressed: () {
                              IdGetter.Id = x["sobaId"];
                              Navigator.pushNamed(
                                context,
                                RecenzijaScreen.dodajRecenzijuRouteName,
                                  arguments: {
                                    'selectedRoomId': x["sobaId"]
                                  },
                              );
                            },
                            child: Text("Ostavite recenziju"),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ) : Container(),
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
