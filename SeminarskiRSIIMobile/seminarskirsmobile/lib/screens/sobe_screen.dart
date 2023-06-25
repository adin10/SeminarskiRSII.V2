// // import 'package:flutter/material.dart';
// // class SobeScreen extends StatefulWidget  {
// //    static const String sobeRouteName = '/sobe';
// //   const SobeScreen({Key? key}) : super(key: key);

// //   @override
// //   State<SobeScreen> createState() => SobeScreen();
// // }

// // class _SobeScreenState extends State<SobeScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Empty Page'),
// //       ),
// //       body: Container(
// //         child: Center(
// //           child: Text(
// //             'This is an empty page',
// //             style: TextStyle(fontSize: 20.0),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/providers/sobe_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:seminarskirsmobile/screens/novosti_screen.dart';
// import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

// class SobeScreen extends StatefulWidget {
//   static const String sobeRouteName = '/sobe';
//   const SobeScreen({Key? key}) : super(key: key);

//   @override
//   State<SobeScreen> createState() => _SobeScreenState();
// }

// class _SobeScreenState extends State<SobeScreen> {
//   SobaProvider? _sobaProvider = null;
//   dynamic data = {};
//   @override
//   void initState() {
//     super.initState();
//     _sobaProvider = context.read<SobaProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _sobaProvider?.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Sobe"),
//           backgroundColor: Color.fromARGB(255, 200, 216, 199),
//         ),
//         body: SafeArea(
//             child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/green.jpg"),
//                     fit: BoxFit.cover,
//                     // fit:BoxFit.fill,
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Column(children: [
//                   Container(
//                       height: 40,
//                       width: 100,
//                       margin: EdgeInsets.fromLTRB(30, 10, 510, 0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(2),
//                         gradient: LinearGradient(colors: [
//                           Color.fromARGB(144, 187, 219, 184),
//                           Color.fromARGB(255, 217, 215, 208)
//                         ]),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(
//                               context, NovostiScreen.novostiRouteName);
//                           // login(context, usernameController.text,
//                           //     passwordController.text);
//                         },
//                         child: Center(child: Text("Novosti")),
//                       ),
//                     ),
//                     // SizedBox(height: 50),
//                     Container(
//                       height: 200,
//                       width: 600,
//                       child: DataTable(
//                         columnSpacing: 12,
//                         horizontalMargin: 12,
//                         columns: [
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Id",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Broj sprata",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Broj sobe",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Opis sobe",
//                                       style: TextStyle(fontSize: 14)))),
//                                       DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Status sobe",
//                                       style: TextStyle(fontSize: 14)))),
//                                        DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Akcija",
//                                       style: TextStyle(fontSize: 14)))),
//                         ],
//                         rows: _buildPlanAndProgrammeList(),
//                       ),
//                     ),
//                   ]),
//                 ))));
//   }

//   List<DataRow> _buildPlanAndProgrammeList() {
//     if (data.length == 0) {
//       return [
//         DataRow(cells: [
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//            DataCell(Text("No data...")),
//         ])
//       ];
//     }

//     List<DataRow> list = data
//         .map((x) => DataRow(
//               cells: [
//                 DataCell(Text(x["id"]?.toString() ?? "0")),
//                 DataCell(Text(x["brojSprata"]?.toString() ?? "0",style: TextStyle(fontSize: 14))),
//                 DataCell(
//                     Text(x["brojSobe"]?.toString() ?? "0", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                     Text(x["opisSobe"] ?? "", style: TextStyle(fontSize: 14))),
//                     DataCell(
//                     Text(x["sobaStatus"]["status"] ?? "", style: TextStyle(fontSize: 14))),
//                      DataCell(TextButton(
//                   child: Text("Detalji",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold)),
//                   onPressed: () {
//                     IdGetter.Id = x["id"];
//                     Navigator.pushNamed(
//                         context, RezervacijScreen.dodajRezervacijuRouteName,
//                         arguments: IdGetter.Id);
//                   },
//                 )),
//               ],
//             ))
//         .toList()
//         .cast<DataRow>();
//     return list;
//   }
// }

// class IdGetter {
//   static int Id = 0;
// }




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/providers/sobe_provider.dart';
// import 'package:seminarskirsmobile/screens/novosti_screen.dart';
// import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

// class SobeScreen extends StatefulWidget {
//   static const String sobeRouteName = '/sobe';

//   const SobeScreen({Key? key}) : super(key: key);

//   @override
//   State<SobeScreen> createState() => _SobeScreenState();
// }

// class _SobeScreenState extends State<SobeScreen> {
//   SobaProvider? _sobaProvider = null;
//   dynamic data = {};

//   @override
//   void initState() {
//     super.initState();
//     _sobaProvider = context.read<SobaProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _sobaProvider?.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sobe"),
//         backgroundColor: Color.fromARGB(255, 200, 216, 199),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/green.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Column(
//               children: data.map<Widget>((x) {
//                 return Card(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 200,
//                         width: 200,
//                         child: Image.memory(
//                           base64Decode(x["slika"]),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text("ID: ${x["id"]}"),
//                       Text("Broj sprata: ${x["brojSprata"]}"),
//                       Text("Broj sobe: ${x["brojSobe"]}"),
//                       Text("Opis sobe: ${x["opisSobe"]}"),
//                       Text("Status sobe: ${x["sobaStatus"]["status"]}"),
//                       ElevatedButton(
//                         onPressed: () {
//                           IdGetter.Id = x["id"];
//                           Navigator.pushNamed(
//                             context,
//                             RezervacijScreen.dodajRezervacijuRouteName,
//                             arguments: IdGetter.Id,
//                           );
//                         },
//                         child: Text("Detalji"),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class IdGetter {
//   static int Id = 0;
// }




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/providers/sobe_provider.dart';
// import 'package:seminarskirsmobile/screens/novosti_screen.dart';
// import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

// class SobeScreen extends StatefulWidget {
//   static const String sobeRouteName = '/sobe';

//   const SobeScreen({Key? key}) : super(key: key);

//   @override
//   State<SobeScreen> createState() => _SobeScreenState();
// }

// class _SobeScreenState extends State<SobeScreen> {
//   SobaProvider? _sobaProvider = null;
//   dynamic data = {};

//   @override
//   void initState() {
//     super.initState();
//     _sobaProvider = context.read<SobaProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _sobaProvider?.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sobe"),
//         backgroundColor: Color.fromARGB(255, 200, 216, 199),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/green.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: data.isNotEmpty ? PageView(
//                   children: data.map<Widget>((x) {
//                     return Card(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 200,
//                             width: 200,
//                             child: Image.memory(
//                               base64Decode(x["slika"]),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text("ID: ${x["id"]}"),
//                           Text("Broj sprata: ${x["brojSprata"]}"),
//                           Text("Broj sobe: ${x["brojSobe"]}"),
//                           Text("Opis sobe: ${x["opisSobe"]}"),
//                           Text("Status sobe: ${x["sobaStatus"]["status"]}"),
//                           ElevatedButton(
//                             onPressed: () {
//                               IdGetter.Id = x["id"];
//                               Navigator.pushNamed(
//                                 context,
//                                 RezervacijScreen.dodajRezervacijuRouteName,
//                                 arguments: IdGetter.Id,
//                               );
//                             },
//                             child: Text("Detalji"),
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ) : Container(),
//               ),
//               SizedBox(height: 10),
//               // Icon(
//               //   // Icons.arrow_downward,
//               //   // size: 36,
//               //   // color: Colors.black,
//               // ),
//               SizedBox(height: 10),
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


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/providers/sobe_provider.dart';
// import 'package:seminarskirsmobile/screens/novosti_screen.dart';
// import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

// class SobeScreen extends StatefulWidget {
//   static const String sobeRouteName = '/sobe';

//   const SobeScreen({Key? key}) : super(key: key);

//   @override
//   State<SobeScreen> createState() => _SobeScreenState();
// }

// class _SobeScreenState extends State<SobeScreen> {
//   SobaProvider? _sobaProvider = null;
//   dynamic data = {};

//   @override
//   void initState() {
//     super.initState();
//     _sobaProvider = context.read<SobaProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _sobaProvider?.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sobe"),
//         backgroundColor: Color.fromARGB(255, 200, 216, 199),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/green.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: data.isNotEmpty ? PageView(
//                   children: data.map<Widget>((x) {
//                     return Card(
//                       child: Column(
//                         children: [
//                           FractionallySizedBox(
//                             widthFactor: 1.0, // Proširuje sliku na cijelu širinu
//                             child: Container(
//                               height: 200,
//                               child: Image.memory(
//                                 base64Decode(x["slika"]),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text("ID: ${x["id"]}"),
//                           Text("Broj sprata: ${x["brojSprata"]}"),
//                           Text("Broj sobe: ${x["brojSobe"]}"),
//                           Text("Opis sobe: ${x["opisSobe"]}"),
//                           Text("Status sobe: ${x["sobaStatus"]["status"]}"),
//                           ElevatedButton(
//                             onPressed: () {
//                               IdGetter.Id = x["id"];
//                               Navigator.pushNamed(
//                                 context,
//                                 RezervacijScreen.dodajRezervacijuRouteName,
//                                 arguments: IdGetter.Id,
//                               );
//                             },
//                             child: Text("Detalji"),
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ) : Container(),
//               ),
//               SizedBox(height: 10),
//               // Icon(
//               //   // Icons.arrow_downward,
//               //   // size: 36,
//               //   // color: Colors.black,
//               // ),
//               SizedBox(height: 10),
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
                                  base64Decode(x["slika"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("ID: ${x["id"]}"),
                          Text("Broj sprata: ${x["brojSprata"]}"),
                          Text("Broj sobe: ${x["brojSobe"]}"),
                          Text("Opis sobe: ${x["opisSobe"]}"),
                          Text("Status sobe: ${x["sobaStatus"]["status"]}"),
                          ElevatedButton(
                            onPressed: () {
                              IdGetter.Id = x["id"];
                              Navigator.pushNamed(
                                context,
                                RezervacijScreen.dodajRezervacijuRouteName,
                                  arguments: {
                                    'userData': userData,
                                    'userId': userId,
                                  },
                              );
                            },
                            child: Text("Rezervisi sobu"),
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
