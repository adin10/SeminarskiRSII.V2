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
// import 'package:seminarskirsmobile/providers/rezervacija_provider.dart';
// import 'package:seminarskirsmobile/providers/sobe_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:seminarskirsmobile/screens/novosti_screen.dart';

// class RezervacijScreen extends StatefulWidget {
//   static const String dodajRezervacijuRouteName = '/dodajRezervaciju';
//   const RezervacijScreen({Key? key}) : super(key: key);

//   @override
//   State<RezervacijScreen> createState() => _RezervacijScreenState();
// }

// class _RezervacijScreenState extends State<RezervacijScreen> {
//   RezervacijaProvider? _rezervacijaProvider = null;
//   dynamic data = {};
//   @override
//   void initState() {
//     super.initState();
//     _rezervacijaProvider = context.read<RezervacijaProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _rezervacijaProvider?.get();
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
// import 'package:http/http.dart' as http;

// import '../providers/base_provider.dart';

// class RezervacijScreen extends StatefulWidget {
//     static const String dodajRezervacijuRouteName = '/dodajRezervaciju';
//   const RezervacijScreen({Key? key}) : super(key: key);
//   @override
//   _RezervacijScreenState createState() => _RezervacijScreenState();
// }

// // class RezervacijScreen extends StatefulWidget {
// //   static const String dodajRezervacijuRouteName = '/dodajRezervaciju';
// //   const RezervacijScreen({Key? key}) : super(key: key);

// //   @override
// //   State<RezervacijScreen> createState() => _RezervacijScreenState();
// // }

// class _RezervacijScreenState extends State<RezervacijScreen> {
//   final _formKey = GlobalKey<FormState>();

//   int? gostId;
//   int? sobaId;
//   DateTime? datumRezervacije;
//   DateTime? zavrsetakRezervacije;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rezervacija'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Gost ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite Gost ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   gostId = int.tryParse(value!);
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Soba ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite Soba ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   sobaId = int.tryParse(value!);
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Datum rezervacije'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite datum rezervacije';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   // Ovdje možete pretvoriti vrijednost iz tekst polja u DateTime objekt
//                   // Primjer: datumRezervacije = DateTime.parse(value!);
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Završetak rezervacije'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite završetak rezervacije';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   // Ovdje možete pretvoriti vrijednost iz tekst polja u DateTime objekt
//                   // Primjer: zavrsetakRezervacije = DateTime.parse(value!);
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Ovdje možete izvršiti slanje podataka na server
//                     _submitForm();
//                   }
//                 },
//                 child: Text('Pošalji'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _submitForm() {
//     // Izradite svoj HTTP zahtjev s podacima iz forme
//     final request = RezervacijaInsertRequest(
//       gostId: gostId,
//       sobaId: sobaId,
//       datumRezervacije: datumRezervacije!,
//       zavrsetakRezervacije: zavrsetakRezervacije!,
//     );

//     // Pretvorite objekt request u JSON string
//     final requestBody = jsonEncode(request);

//     // Izvršite HTTP POST zahtjev na server
//     final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija");
//     http.post(url, body: requestBody).then((response) {
//       if (response.statusCode == 200) {
//         // Uspješno poslan zahtjev
//         // Ovdje možete dodati odgovarajući postupak za prikaz poruke ili navigaciju na drugi ekran
//       } else {
//         // Pogreška pri slanju zahtjeva
//         // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
//       }
//     }).catchError((error) {
//       // Pogreška prilikom izvršavanja HTTP zahtjeva
//       // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
//     });
//   }
// }

// class RezervacijaInsertRequest {
//   final int? gostId;
//   final int? sobaId;
//   final DateTime datumRezervacije;
//   final DateTime zavrsetakRezervacije;

//   RezervacijaInsertRequest({
//     required this.gostId,
//     required this.sobaId,
//     required this.datumRezervacije,
//     required this.zavrsetakRezervacije,
//   });
// }


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../providers/base_provider.dart';

// class RezervacijScreen extends StatefulWidget {
//   static const String dodajRezervacijuRouteName = '/dodajRezervaciju';
//   const RezervacijScreen({Key? key}) : super(key: key);

//   @override
//   _RezervacijScreenState createState() => _RezervacijScreenState();
// }

// class _RezervacijScreenState extends State<RezervacijScreen> {
//   final _formKey = GlobalKey<FormState>();

//   int? gostId;
//   int? sobaId;
//   DateTime? datumRezervacije;
//   DateTime? zavrsetakRezervacije;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rezervacija'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Gost ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite Gost ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     gostId = int.tryParse(value);
//                   }
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Soba ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite Soba ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     sobaId = int.tryParse(value);
//                   }
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Datum rezervacije'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite datum rezervacije';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   // Ovdje možete pretvoriti vrijednost iz tekst polja u DateTime objekt
//                   // Primjer: datumRezervacije = DateTime.parse(value!);
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Završetak rezervacije'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite završetak rezervacije';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   // Ovdje možete pretvoriti vrijednost iz tekst polja u DateTime objekt
//                   // Primjer: zavrsetakRezervacije = DateTime.parse(value!);
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Ovdje možete izvršiti slanje podataka na server
//                     _submitForm();
//                   }
//                 },
//                 child: Text('Pošalji'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _submitForm() {
//     // Izradite svoj HTTP zahtjev s podacima iz forme
//     final request = RezervacijaInsertRequest(
//       gostId: gostId,
//       sobaId: sobaId,
//       datumRezervacije: datumRezervacije!,
//       zavrsetakRezervacije: zavrsetakRezervacije!,
//     );

//     // Pretvorite objekt request u JSON string
//     final requestBody = jsonEncode(request);

//     // Izvršite HTTP POST zahtjev na server
//     final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija");
//     http.post(url, body: requestBody).then((response) {
//       if (response.statusCode == 200) {
//         // Uspješno poslan zahtjev
//         // Ovdje možete dodati odgovarajući postupak za prikaz poruke ili navigaciju na drugi ekran
//       } else {
//         // Pogreška pri slanju zahtjeva
//         // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
//       }
//     }).catchError((error) {
//       // Pogreška prilikom izvršavanja HTTP zahtjeva
//       // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
//     });
//   }
// }

// class RezervacijaInsertRequest {
//   final int? gostId;
//   final int? sobaId;
//   final DateTime datumRezervacije;
//   final DateTime zavrsetakRezervacije;

//   RezervacijaInsertRequest({
//     required this.gostId,
//     required this.sobaId,
//     required this.datumRezervacije,
//     required this.zavrsetakRezervacije,
//   });
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../providers/base_provider.dart';

// class RezervacijScreen extends StatefulWidget {
//   static const String dodajRezervacijuRouteName = '/dodajRezervaciju';
//   const RezervacijScreen({Key? key}) : super(key: key);

//   @override
//   _RezervacijScreenState createState() => _RezervacijScreenState();
// }

// class _RezervacijScreenState extends State<RezervacijScreen> {
//   final _formKey = GlobalKey<FormState>();

//   int? gostId;
//   int? sobaId;
//   String? datumRezervacijeText;
//   String? zavrsetakRezervacijeText;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rezervacija'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Gost ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite Gost ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     gostId = int.tryParse(value);
//                   }
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Soba ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite Soba ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     sobaId = int.tryParse(value);
//                   }
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Datum rezervacije'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite datum rezervacije';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   datumRezervacijeText = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Završetak rezervacije'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite završetak rezervacije';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   zavrsetakRezervacijeText = value;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Ovdje možete izvršiti slanje podataka na server
//                     _submitForm();
//                   }
//                 },
//                 child: Text('Pošalji'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _submitForm() {
//     // Provjerite jesu li unosi datuma postavljeni
//     if (datumRezervacijeText == null || zavrsetakRezervacijeText == null) {
//       // Prikazati poruku o grešci ili poduzeti odgovarajuće radnje
//       return;
//     }

//     // Pretvorite unose datuma u DateTime objekte
//     final datumRezervacije = DateTime.parse(datumRezervacijeText!);
//     final zavrsetakRezervacije = DateTime.parse(zavrsetakRezervacijeText!);

//     // Izradite svoj HTTP zahtjev s podacima iz forme
//     final request = RezervacijaInsertRequest(
//       gostId: gostId,
//       sobaId: sobaId,
//       datumRezervacije: datumRezervacije,
//       zavrsetakRezervacije: zavrsetakRezervacije,
//     );

//     // Pretvorite objekt request u JSON string
//     final requestBody = jsonEncode(request);

//     // Izvršite HTTP POST zahtjev na server
//     final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija");
//     http.post(url, body: requestBody).then((response) {
//       if (response.statusCode == 200) {
//         // Uspješno poslan zahtjev
//         // Ovdje možete dodati odgovarajući postupak za prikaz poruke ili navigaciju na drugi ekran
//       } else {
//         // Pogreška pri slanju zahtjeva
//         // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
//       }
//     }).catchError((error) {
//       // Pogreška prilikom izvršavanja HTTP zahtjeva
//       // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
//     });
//   }
// }

// class RezervacijaInsertRequest {
//   final int? gostId;
//   final int? sobaId;
//   final DateTime datumRezervacije;
//   final DateTime zavrsetakRezervacije;

//   RezervacijaInsertRequest({
//     required this.gostId,
//     required this.sobaId,
//     required this.datumRezervacije,
//     required this.zavrsetakRezervacije,
//   });
// }


// ___________________________

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:seminarskirsmobile/screens/sobe_screen.dart';
// import 'dart:convert';

// import '../providers/base_provider.dart';

// class RezervacijScreen extends StatefulWidget {
//   static const String dodajRezervacijuRouteName = '/dodajRezervaciju';
//   const RezervacijScreen({Key? key}) : super(key: key);

//   @override
//   _RezervacijScreenState createState() => _RezervacijScreenState();
// }

// class _RezervacijScreenState extends State<RezervacijScreen> {
//   final _formKey = GlobalKey<FormState>();

//   int? gostId;
//   int? sobaId;
//   DateTime? datumRezervacije;
//   DateTime? zavrsetakRezervacije;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rezervacija'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Gost ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite Gost ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     gostId = int.tryParse(value);
//                   }
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Soba ID'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite Soba ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     sobaId = int.tryParse(value);
//                   }
//                 },
//               ),
//               DateTimeField(
//                 decoration: InputDecoration(labelText: 'Datum rezervacije'),
//                 format: DateFormat('yyyy-MM-dd'),
//                 onShowPicker: (context, currentValue) async {
//                   final date = await showDatePicker(
//                     context: context,
//                     firstDate: DateTime(2000),
//                     initialDate: currentValue ?? DateTime.now(),
//                     lastDate: DateTime(2100),
//                   );
//                   if (date != null) {
//                     return date;
//                   }
//                   return currentValue;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     datumRezervacije = value;
//                   });
//                 },
//               ),
//               DateTimeField(
//                 decoration: InputDecoration(labelText: 'Završetak rezervacije'),
//                 format: DateFormat('yyyy-MM-dd'),
//                 onShowPicker: (context, currentValue) async {
//                   final date = await showDatePicker(
//                     context: context,
//                     firstDate: DateTime(2000),
//                     initialDate: currentValue ?? DateTime.now(),
//                     lastDate: DateTime(2100),
//                   );
//                   if (date != null) {
//                     return date;
//                   }
//                   return currentValue;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     zavrsetakRezervacije = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     _submitForm();
//                   }
//                 },
//                 child: Text('Pošalji'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _submitForm() {
//     if (datumRezervacije == null || zavrsetakRezervacije == null) {
//       return;
//     }

//     final request = RezervacijaInsertRequest(
//       gostId: gostId,
//       sobaId: sobaId,
//       datumRezervacije: datumRezervacije!,
//       zavrsetakRezervacije: zavrsetakRezervacije!,
//     );

//     final requestBody = jsonEncode(request);

//     final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija");
//     http.post(url, body: requestBody).then((response) {
//       if (response.statusCode == 200) {
//         // Uspješno poslan zahtjev
//         Navigator.pushNamed(context, SobeScreen.sobeRouteName); // Dodana linija za navigaciju
//       } else {
//         // Pogreška pri slanju zahtjeva
//       }
//     }).catchError((error) {
//       // Pogreška prilikom izvršavanja HTTP zahtjeva
//     });
//   }
// }

// class RezervacijaInsertRequest {
//   final int? gostId;
//   final int? sobaId;
//   final DateTime datumRezervacije;
//   final DateTime zavrsetakRezervacije;

//   RezervacijaInsertRequest({
//     required this.gostId,
//     required this.sobaId,
//     required this.datumRezervacije,
//     required this.zavrsetakRezervacije,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'gostId': gostId,
//       'sobaId': sobaId,
//       'datumRezervacije': datumRezervacije.toIso8601String(),
//       'zavrsetakRezervacije': zavrsetakRezervacije.toIso8601String(),
//     };
//   }
// }





import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/sobe_screen.dart';
import 'dart:convert';
import '../providers/base_provider.dart';

class RezervacijScreen extends StatefulWidget {
  static const String dodajRezervacijuRouteName = '/dodajRezervaciju';
  const RezervacijScreen({Key? key}) : super(key: key);

  @override
  _RezervacijScreenState createState() => _RezervacijScreenState();
}

class _RezervacijScreenState extends State<RezervacijScreen> {
  final _formKey = GlobalKey<FormState>();

  int? gostId;
  int? sobaId;
  DateTime? datumRezervacije;
  DateTime? zavrsetakRezervacije;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervacija'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Gost ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite Gost ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    gostId = int.tryParse(value);
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Soba ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite Soba ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    sobaId = int.tryParse(value);
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Datum rezervacije'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite datum rezervacije';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      datumRezervacije = pickedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: datumRezervacije != null
                      ? formatDate(datumRezervacije!)
                      : '',
                ),
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Završetak rezervacije'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite završetak rezervacije';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      zavrsetakRezervacije = pickedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: zavrsetakRezervacije != null
                      ? formatDate(zavrsetakRezervacije!)
                      : '',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Ovdje možete izvršiti slanje podataka na server
                    _submitForm();
                  }
                },
                child: Text('Pošalji'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // Provjerite jesu li unosi datuma postavljeni
    if (datumRezervacije == null || zavrsetakRezervacije == null) {
      // Prikazati poruku o grešci ili poduzeti odgovarajuće radnje
      return;
    }
     if (zavrsetakRezervacije!.isBefore(datumRezervacije!)) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Greška'),
          content: Text('Završetak rezervacije ne može biti prije datuma rezervacije.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('U redu'),
            ),
          ],
        );
      },
    );
    return;
  }

    // Izradite svoj HTTP zahtjev s podacima iz forme
    final request = RezervacijaInsertRequest(
      gostId: gostId,
      sobaId: sobaId,
      datumRezervacije: datumRezervacije!,
      zavrsetakRezervacije: zavrsetakRezervacije!,
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());


      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija");
    http.post(url,
     body: requestBody,
     headers: {'Content-Type': 'application/json'})
    .then((response) {
      if (response.statusCode == 200) {
        // Uspješno poslan zahtjev
        // Ovdje možete dodati odgovarajući postupak za prikaz poruke ili navigaciju na drugi ekran
        Navigator.pushNamed(context, NovostiScreen.novostiRouteName,);
      } else {
        // Pogreška pri slanju zahtjeva
        // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
      }
    }).catchError((error) {
      // Pogreška prilikom izvršavanja HTTP zahtjeva
      // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
    });
  }

  String formatDate(DateTime date) {
    return "${date.day}.${date.month}.${date.year}";
  }
}

class RezervacijaInsertRequest {
  final int? gostId;
  final int? sobaId;
  final DateTime datumRezervacije;
  final DateTime zavrsetakRezervacije;

  RezervacijaInsertRequest({
    required this.gostId,
    required this.sobaId,
    required this.datumRezervacije,
    required this.zavrsetakRezervacije,
  });

  Map<String, dynamic> toJson() {
    return {
      'gostId': gostId,
      'sobaId': sobaId,
      'datumRezervacije': datumRezervacije.toIso8601String(),
      'zavrsetakRezervacije': zavrsetakRezervacije.toIso8601String(),
    };
  }
}


