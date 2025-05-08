// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/main.dart';
// import 'package:seminarskirsmobile/providers/sobe_provider.dart';
// import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

// class SobeScreen extends StatefulWidget {
//   static const String sobeRouteName = '/sobe';

//   const SobeScreen({Key? key}) : super(key: key);

//   @override
//   State<SobeScreen> createState() => _SobeScreenState();
// }

// class _SobeScreenState extends State<SobeScreen> {
//   SobaProvider? _sobaProvider;
//   dynamic data = {};

//   @override
//   void initState() {
//     super.initState();
//     _sobaProvider = context.read<SobaProvider>();
//     // loadData();
//   }

//   // Future<void> loadData() async {
//   //   var tmpData = await _sobaProvider?.getCjenovnik(null);
//   //   setState(() {
//   //     data = tmpData;
//   //   });
//   // }

//   Future<void> loadData(DateTime datumOd, DateTime datumDo) async {
//   final filters = {
//     'datumOd': datumOd.toIso8601String(),
//     'datumDo': datumDo.toIso8601String(),
//   };

//   var tmpData = await _sobaProvider?.getCjenovnik(filters);
//   setState(() {
//     data = tmpData;
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     final GetUserResponse? userData =
//         ModalRoute.of(context)?.settings.arguments as GetUserResponse?;

//     if (userData == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Error')),
//         body: const Center(
//           child: Text('Missing user data. Please go back and try again.'),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sobe"),
//         backgroundColor: Colors.teal,
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.teal.shade100, Colors.teal.shade50],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: data.isNotEmpty
//                     ? PageView(
//                         children: data.map<Widget>((x) {
//                           return Card(
//                             child: Column(
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.all(16.0),
//                                   child: Text(
//                                     "Pregled svih slobodnih soba",
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 AspectRatio(
//                                   aspectRatio: 1 / 1,
//                                   child: Container(
//                                     child: Image.memory(
//                                       base64Decode(x["soba"]["slika"]),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Broj sprata: ${x["soba"]["brojSprata"]}",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       Text(
//                                         "Broj sobe: ${x["soba"]["brojSobe"]}",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       Text(
//                                         "Opis sobe: ${x["soba"]["opisSobe"]}",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       Text(
//                                         "Cijena: ${x["cijena"]} ${x["valuta"]}",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0),
//                                   child: Container(
//                                     width: double.infinity,
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         final roomId = x["soba"]["id"] as int?;
//                                         if (roomId == null) {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             const SnackBar(
//                                                 content: Text(
//                                                     'Greška: ID sobe nije dostupan.')),
//                                           );
//                                           return;
//                                         }
//                                         IdGetter.Id = roomId;
//                                         Navigator.pushNamed(
//                                           context,
//                                           RezervacijScreen
//                                               .dodajRezervacijuRouteName,
//                                           arguments: {
//                                             'userData': userData,
//                                             'userId': userData.id,
//                                             'selectedRoomId': roomId,
//                                           },
//                                         );
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 16.0),
//                                         backgroundColor: Colors.teal,
//                                         textStyle:
//                                             const TextStyle(fontSize: 18),
//                                       ),
//                                       child: const Text("Rezerviši sobu"),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       )
//                     : const Center(
//                         child: Text(
//                           "Nema dostupnih soba",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class IdGetter {
//   static int Id = 0;
// }


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
  GetUserResponse? userData;
  DateTime? datumOd;
  DateTime? datumDo;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _sobaProvider = context.read<SobaProvider>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null) {
        userData = args['userData'] as GetUserResponse?;
        datumOd = args['datumOd'] as DateTime?;
        datumDo = args['datumDo'] as DateTime?;

        if (datumOd != null && datumDo != null) {
          loadData(datumOd!, datumDo!);
        }
      }

      _isInitialized = true;
    }
  }

  Future<void> loadData(DateTime datumOd, DateTime datumDo) async {
    final filters = {
      'datumOd': datumOd.toIso8601String(),
      'datumDo': datumDo.toIso8601String(),
    };

    var tmpData = await _sobaProvider?.getCjenovnik(filters);
    setState(() {
      data = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Greška')),
        body: const Center(
          child: Text('Nedostaju podaci o korisniku. Vratite se nazad.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobe"),
        backgroundColor: Colors.teal,
      ),
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
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    child: Image.memory(
                                      base64Decode(x["soba"]["slika"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Broj sprata: ${x["soba"]["brojSprata"]}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Broj sobe: ${x["soba"]["brojSobe"]}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Opis sobe: ${x["soba"]["opisSobe"]}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Cijena: ${x["cijena"]} ${x["valuta"]}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final roomId = x["soba"]["id"] as int?;
                                        if (roomId == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Greška: ID sobe nije dostupan.')),
                                          );
                                          return;
                                        }
                                        IdGetter.Id = roomId;
                                        Navigator.pushNamed(
                                          context,
                                          RezervacijScreen
                                              .dodajRezervacijuRouteName,
                                          arguments: {
                                            'userData': userData,
                                            'userId': userData!.id,
                                            'selectedRoomId': roomId,
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        backgroundColor: Colors.teal,
                                        textStyle:
                                            const TextStyle(fontSize: 18),
                                      ),
                                      child: const Text("Rezerviši sobu"),
                                    ),
                                  ),
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
