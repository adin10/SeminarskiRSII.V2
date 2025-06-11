// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/providers/globals.dart';
// import 'package:seminarskirsmobile/providers/rezervacija_provider.dart';
// import '../main.dart';
// import 'recenzija_screen.dart';

// class ListaRezervacijaScreen extends StatefulWidget {
//   static const String listaRezervacijaRouteName = '/listaRezervacija';

//   const ListaRezervacijaScreen({Key? key}) : super(key: key);

//   @override
//   State<ListaRezervacijaScreen> createState() => _ListaRezervacijaScreenState();
// }

// class _ListaRezervacijaScreenState extends State<ListaRezervacijaScreen> {
//   RezervacijaProvider? _rezervacijaProvider;
//   List<dynamic> data = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _rezervacijaProvider = context.read<RezervacijaProvider>();
//     loadData(loggedUserID);
//   }

//   Future<void> loadData(int gostID) async {
//     List<dynamic>? tmpData = await _rezervacijaProvider?.get(gostID: gostID);
//     setState(() {
//       data = tmpData ?? [];
//       isLoading = false;
//     });
//   }

//   String formatDate(String dateString) {
//     try {
//       final date = DateTime.parse(dateString);
//       return DateFormat('dd.MM.yyyy').format(date);
//     } catch (e) {
//       return dateString;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Vaša lista rezervacija"),
//         backgroundColor: Colors.teal,
//       ),
//       body: SafeArea(
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.teal.shade100, Colors.teal.shade50],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       if (data.isNotEmpty)
//                         Align(
//                           alignment: Alignment.centerLeft,
//                         ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.85,
//                         child: data.isNotEmpty
//                             ? PageView(
//                                 children: data.map<Widget>((reservation) {
//                                   final datumRezervacije = DateTime.parse(
//                                     reservation["datumRezervacije"],
//                                   );
//                                   final zavrsetakRezervacije = DateTime.parse(
//                                     reservation["zavrsetakRezervacije"],
//                                   );
//                                   return Card(
//                                     margin: const EdgeInsets.all(10.0),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     elevation: 5,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                       children: [
//                                         ClipRRect(
//                                           borderRadius:
//                                               const BorderRadius.vertical(
//                                             top: Radius.circular(
//                                               12.0,
//                                             ),
//                                           ),
//                                           child: AspectRatio(
//                                             aspectRatio: 1 / 1,
//                                             child: Image.memory(
//                                               base64Decode(
//                                                 reservation["soba"]["slika"],
//                                               ),
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(
//                                             16.0,
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               _buildInfoRow(
//                                                   "Broj sobe",
//                                                   reservation["soba"]
//                                                           ["brojSobe"]
//                                                       .toString(),
//                                                   icon: Icons.numbers),
//                                               _buildInfoRow(
//                                                   "Datum rezervacije",
//                                                   formatDate(reservation[
//                                                       "datumRezervacije"]),
//                                                   icon: Icons.calendar_today),
//                                               _buildInfoRow(
//                                                   "Kraj rezervacije",
//                                                   formatDate(reservation[
//                                                       "zavrsetakRezervacije"]),
//                                                   icon: Icons.calendar_today),
//                                               _buildInfoRow(
//                                                   "Usluge",
//                                                   reservation[
//                                                           "rezervacijaUsluge"]
//                                                       .map<String>(
//                                                         (usluga) =>
//                                                             usluga["usluga"]
//                                                                     ["naziv"]
//                                                                 as String,
//                                                       )
//                                                       .join(", "),
//                                                   icon: Icons.room_service),
//                                               _buildInfoRow("Ukupna cijena",
//                                                   "${reservation["cijena"]} KM",
//                                                   isBold: true,
//                                                   icon: Icons.attach_money),

//                                               const SizedBox(
//                                                 height: 16,
//                                               ),
//                                               Center(
//                                                 child: DateTime.now().isAfter(
//                                                   zavrsetakRezervacije,
//                                                 )
//                                                     ? ElevatedButton(
//                                                         onPressed: () {
//                                                           IdGetter.Id =
//                                                               reservation[
//                                                                   "sobaId"];
//                                                           Navigator.pushNamed(
//                                                             context,
//                                                             RecenzijaScreen
//                                                                 .dodajRecenzijuRouteName,
//                                                             arguments: {
//                                                               'selectedRoomId':
//                                                                   reservation[
//                                                                       "sobaId"],
//                                                             },
//                                                           );
//                                                         },
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           backgroundColor:
//                                                               Colors.teal,
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                               8.0,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: const Text(
//                                                           "Ostavite recenziju",
//                                                         ),
//                                                       )
//                                                     : DateTime.now().isBefore(
//                                                         datumRezervacije,
//                                                       )
//                                                         ? ElevatedButton(
//                                                             onPressed:
//                                                                 () async {
//                                                               final confirmed =
//                                                                   await showDialog<
//                                                                       bool>(
//                                                                 context:
//                                                                     context,
//                                                                 builder: (
//                                                                   context,
//                                                                 ) =>
//                                                                     AlertDialog(
//                                                                   title:
//                                                                       const Text(
//                                                                     "Potvrda",
//                                                                   ),
//                                                                   content:
//                                                                       const Text(
//                                                                     "Da li ste sigurni da želite otkazati rezervaciju?",
//                                                                   ),
//                                                                   actions: [
//                                                                     TextButton(
//                                                                       onPressed:
//                                                                           () =>
//                                                                               Navigator.of(
//                                                                         context,
//                                                                       ).pop(
//                                                                         false,
//                                                                       ),
//                                                                       child:
//                                                                           const Text(
//                                                                         "Ne",
//                                                                       ),
//                                                                     ),
//                                                                     ElevatedButton(
//                                                                       onPressed:
//                                                                           () =>
//                                                                               Navigator.of(
//                                                                         context,
//                                                                       ).pop(
//                                                                         true,
//                                                                       ),
//                                                                       style: ElevatedButton
//                                                                           .styleFrom(
//                                                                         backgroundColor:
//                                                                             Colors.red,
//                                                                       ),
//                                                                       child:
//                                                                           const Text(
//                                                                         "Da",
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               );

//                                                               if (confirmed ==
//                                                                   true) {
//                                                                 final rezervacijaProvider =
//                                                                     context.read<
//                                                                         RezervacijaProvider>();
//                                                                 final isCancelled =
//                                                                     await rezervacijaProvider
//                                                                         .otkazi(
//                                                                   reservation[
//                                                                           "id"]
//                                                                       .toString(),
//                                                                 );
//                                                                 if (isCancelled) {
//                                                                   setState(() {
//                                                                     data.removeWhere(
//                                                                       (
//                                                                         item,
//                                                                       ) =>
//                                                                           item[
//                                                                               "id"] ==
//                                                                           reservation[
//                                                                               "id"],
//                                                                     );
//                                                                   });
//                                                                   ScaffoldMessenger
//                                                                       .of(
//                                                                     context,
//                                                                   ).showSnackBar(
//                                                                     const SnackBar(
//                                                                       content:
//                                                                           Text(
//                                                                         "Rezervacija otkazana.",
//                                                                       ),
//                                                                     ),
//                                                                   );
//                                                                 } else {
//                                                                   ScaffoldMessenger
//                                                                       .of(
//                                                                     context,
//                                                                   ).showSnackBar(
//                                                                     const SnackBar(
//                                                                       content:
//                                                                           Text(
//                                                                         "Greška pri otkazivanju rezervacije.",
//                                                                       ),
//                                                                     ),
//                                                                   );
//                                                                 }
//                                                               }
//                                                             },
//                                                             style:
//                                                                 ElevatedButton
//                                                                     .styleFrom(
//                                                               backgroundColor:
//                                                                   Colors.red,
//                                                               foregroundColor:
//                                                                   Colors.white,
//                                                               shape:
//                                                                   RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                   8.0,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             child: const Text(
//                                                               "Otkazite rezervaciju",
//                                                             ),
//                                                           )
//                                                         : const SizedBox(),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
//                               )
//                             : const Center(
//                                 child: Text(
//                                   "Nema dostupnih rezervacija",
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

// Widget _buildInfoRow(String label, String value,
//     {bool isBold = false, IconData? icon}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 5.0),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 4,
//           child: Row(
//             children: [
//               if (icon != null) ...[
//                 Icon(icon, size: 18, color: Colors.teal),
//                 const SizedBox(width: 10),
//               ],
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           flex: 4,
//           child: Text(
//             value,
//             style: TextStyle(
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// class IdGetter {
//   static int Id = 0;
// }


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
  bool isLoading = true;

  // Dodano: PageController i trenutna stranica
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    _pageController = PageController();
    loadData(loggedUserID);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadData(int gostID) async {
    List<dynamic>? tmpData = await _rezervacijaProvider?.get(gostID: gostID);
    setState(() {
      data = tmpData ?? [];
      isLoading = false;
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
        title: const Text("Vaša lista rezervacija"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
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
                      ),
                    // Promjena: PageView i indikatori u Expanded + Column
                    Expanded(
                      child: data.isNotEmpty
                          ? Column(
                              children: [
                                // PageView
                                Expanded(
                                  child: PageView(
                                    controller: _pageController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentPage = index;
                                      });
                                    },
                                    children: data.map<Widget>((reservation) {
                                      final datumRezervacije = DateTime.parse(
                                        reservation["datumRezervacije"],
                                      );
                                      final zavrsetakRezervacije = DateTime.parse(
                                        reservation["zavrsetakRezervacije"],
                                      );
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
                                                    reservation["soba"]["slika"],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  _buildInfoRow(
                                                      "Broj sobe",
                                                      reservation["soba"]["brojSobe"].toString(),
                                                      isBold: true,
                                                      icon: Icons.numbers),
                                                  _buildInfoRow(
                                                      "Datum rezervacije",
                                                      formatDate(reservation["datumRezervacije"]),
                                                      isBold: true,
                                                      icon: Icons.calendar_today),
                                                  _buildInfoRow(
                                                      "Kraj rezervacije",
                                                      formatDate(reservation["zavrsetakRezervacije"]),
                                                      isBold: true,
                                                      icon: Icons.calendar_today),
                                                  _buildInfoRow(
                                                      "Usluge",
                                                      reservation["rezervacijaUsluge"]
                                                          .map<String>(
                                                            (usluga) => usluga["usluga"]["naziv"] as String,
                                                          )
                                                          .join(", "),
                                                      isBold: true,
                                                      icon: Icons.room_service),
                                                  _buildInfoRow("Ukupna cijena",
                                                      "${reservation["cijena"]} KM",
                                                      isBold: true,
                                                      icon: Icons.attach_money),
                                                  const SizedBox(height: 16),
                                                  Center(
                                                    child: DateTime.now().isAfter(zavrsetakRezervacije)
                                                        ? ElevatedButton(
                                                            onPressed: () {
                                                              IdGetter.Id = reservation["sobaId"];
                                                              Navigator.pushNamed(
                                                                context,
                                                                RecenzijaScreen.dodajRecenzijuRouteName,
                                                                arguments: {
                                                                  'selectedRoomId': reservation["sobaId"],
                                                                },
                                                              );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: Colors.teal,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8.0),
                                                              ),
                                                            ),
                                                            child: const Text("Ostavite recenziju"),
                                                          )
                                                        : DateTime.now().isBefore(datumRezervacije)
                                                            ? ElevatedButton(
                                                                onPressed: () async {
                                                                  final confirmed = await showDialog<bool>(
                                                                    context: context,
                                                                    builder: (context) => AlertDialog(
                                                                      title: const Text("Potvrda"),
                                                                      content: const Text(
                                                                          "Da li ste sigurni da želite otkazati rezervaciju?"),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () => Navigator.of(context).pop(false),
                                                                          child: const Text("Ne"),
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed: () => Navigator.of(context).pop(true),
                                                                          style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors.red,
                                                                          ),
                                                                          child: const Text("Da"),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );

                                                                  if (confirmed == true) {
                                                                    final rezervacijaProvider =
                                                                        context.read<RezervacijaProvider>();
                                                                    final isCancelled = await rezervacijaProvider.otkazi(
                                                                      reservation["id"].toString(),
                                                                    );
                                                                    if (isCancelled) {
                                                                      setState(() {
                                                                        data.removeWhere((item) => item["id"] == reservation["id"]);
                                                                      });
                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                        const SnackBar(
                                                                          content: Text("Rezervacija otkazana."),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                        const SnackBar(
                                                                          content: Text("Greška pri otkazivanju rezervacije."),
                                                                        ),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: Colors.red,
                                                                  foregroundColor: Colors.white,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                  ),
                                                                ),
                                                                child: const Text("Otkazite rezervaciju"),
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
                                  ),
                                ),
                                // Indikatori ispod PageView-a (ali izvan Carda!)
                                if (data.length > 1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(data.length, (index) {
                                        return AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          margin: EdgeInsets.symmetric(horizontal: 4),
                                          width: _currentPage == index ? 16 : 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: _currentPage == index
                                                ? Colors.teal
                                                : Colors.teal.shade100,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                              ],
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

Widget _buildInfoRow(String label, String value,
    {bool isBold = false, IconData? icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: Colors.teal),
                const SizedBox(width: 10),
              ],
              Text(
                label,
                style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

class IdGetter {
  static int Id = 0;
}
