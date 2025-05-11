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
        title: const Text("Lista rezervacija"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                if (data.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 16, 0),
                      child: Text(
                        "Vaša lista rezervacija",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: data.isNotEmpty
                      ? PageView(
                          children: data.map<Widget>((reservation) {
                            final datumRezervacije =
                                DateTime.parse(reservation["datumRezervacije"]);
                            final zavrsetakRezervacije = DateTime.parse(
                                reservation["zavrsetakRezervacije"]);
                            return Card(
                              margin: const EdgeInsets.all(10.0),
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
                                        _buildInfoRow(
                                            "Broj sobe",
                                            reservation["soba"]["brojSobe"]
                                                .toString()),
                                        _buildInfoRow(
                                            "Datum rezervacije",
                                            formatDate(reservation[
                                                "datumRezervacije"])),
                                        _buildInfoRow(
                                            "Kraj rezervacije",
                                            formatDate(reservation[
                                                "zavrsetakRezervacije"])),
                                        _buildInfoRow(
                                            "Usluge",
                                            reservation["rezervacijaUsluge"]
                                                .map<String>((usluga) =>
                                                    usluga["usluga"]["naziv"]
                                                        as String)
                                                .join(", ")),
                                        _buildInfoRow(
                                          "Ukupna cijena",
                                          "${reservation["cijena"]} KM",
                                          isBold: true,
                                        ),
                                        const SizedBox(height: 16),
                                        Center(
                                          child: DateTime.now()
                                                  .isAfter(zavrsetakRezervacije)
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    IdGetter.Id =
                                                        reservation["sobaId"];
                                                    Navigator.pushNamed(
                                                      context,
                                                      RecenzijaScreen
                                                          .dodajRecenzijuRouteName,
                                                      arguments: {
                                                        'selectedRoomId':
                                                            reservation[
                                                                "sobaId"]
                                                      },
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.teal,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                      "Ostavite recenziju"),
                                                )
                                              : DateTime.now().isBefore(
                                                      datumRezervacije)
                                                  ? ElevatedButton(
                                                      onPressed: () async {
                                                        final confirmed =
                                                            await showDialog<
                                                                bool>(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                "Potvrda"),
                                                            content: const Text(
                                                                "Da li ste sigurni da želite otkazati rezervaciju?"),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false),
                                                                child:
                                                                    const Text(
                                                                        "Ne"),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                                child:
                                                                    const Text(
                                                                        "Da"),
                                                              ),
                                                            ],
                                                          ),
                                                        );

                                                        if (confirmed == true) {
                                                          final rezervacijaProvider =
                                                              context.read<
                                                                  RezervacijaProvider>();
                                                          final isCancelled =
                                                              await rezervacijaProvider
                                                                  .otkazi(
                                                            reservation["id"]
                                                                .toString(),
                                                          );
                                                          if (isCancelled) {
                                                            setState(() {
                                                              data.removeWhere(
                                                                  (item) =>
                                                                      item[
                                                                          "id"] ==
                                                                      reservation[
                                                                          "id"]);
                                                            });
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    "Rezervacija otkazana."),
                                                              ),
                                                            );
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    "Greška pri otkazivanju rezervacije."),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                          "Otkazite rezervaciju"),
                                                    )
                                                  : const SizedBox(),
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
      ),
    );
  }
}

Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ],
    ),
  );
}

class IdGetter {
  static int Id = 0;
}
