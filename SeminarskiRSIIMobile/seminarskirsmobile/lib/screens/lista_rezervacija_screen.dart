import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/providers/globals.dart';
import 'package:seminarskirsmobile/providers/rezervacija_provider.dart';
import '../main.dart';
import 'recenzija_screen.dart';

class ListaRezervacijaScreen extends StatefulWidget {
  static const String listaRezervacijaRouteName = '/listaRezervacija';

  const ListaRezervacijaScreen({Key? key}) : super(key: key);

  @override
  State<ListaRezervacijaScreen> createState() => _ListaRezervacijaScreenState();
}

class _ListaRezervacijaScreenState extends State<ListaRezervacijaScreen> {
  RezervacijaProvider? _rezervacijaProvider;
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    loadData(loggedUserID);
  }

  Future<void> loadData(int gostID) async {
    List<dynamic>? tmpData = await _rezervacijaProvider?.get(gostID: gostID);
    setState(() {
      data = tmpData ?? [];
    });
  }

  String formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd.MM.yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Lista rezervacija"), backgroundColor: Colors.teal),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade100, Colors.teal.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lista rezervacija za gosta:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    if (data.isNotEmpty)
                      Text(
                        '${data[0]["gost"]["ime"]} ${data[0]["gost"]["prezime"]}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: data.isNotEmpty
                    ? PageView(
                        children: data.map<Widget>((reservation) {
                          return Card(
                            margin: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: Image.memory(
                                      base64Decode(
                                          reservation["soba"]["slika"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Broj sobe: ${reservation["soba"]["brojSobe"]}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Početak rezervacije: ${formatDate(reservation["datumRezervacije"])}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "Završetak rezervacije: ${formatDate(reservation["zavrsetakRezervacije"])}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            IdGetter.Id = reservation["sobaId"];
                                            Navigator.pushNamed(
                                              context,
                                              RecenzijaScreen
                                                  .dodajRecenzijuRouteName,
                                              arguments: {
                                                'selectedRoomId':
                                                    reservation["sobaId"]
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child:
                                              const Text("Ostavite recenziju"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    : const Center(
                        child: Text(
                          "Nema dostupnih rezervacija",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              ),
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
