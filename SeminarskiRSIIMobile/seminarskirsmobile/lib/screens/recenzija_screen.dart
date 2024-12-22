// import 'dart:io';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/io_client.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';
// import '../main.dart';
// import '../providers/base_provider.dart';
// import '../providers/globals.dart';
// import 'lista_rezervacija_screen.dart';

// class RecenzijaScreen extends StatefulWidget {
//   static const String dodajRecenzijuRouteName = '/dodajRecenziju';
//   const RecenzijaScreen({Key? key}) : super(key: key);

//   @override
//   _RecenzijaScreenState createState() => _RecenzijaScreenState();
// }

// class _RecenzijaScreenState extends State<RecenzijaScreen> {
//   final _formKey = GlobalKey<FormState>();

//   int? gostId;
//   int? sobaId;
//   int? ocjena;
//   String? komentar;

//   @override
//   Widget build(BuildContext context) {
//   final Map<String, dynamic>? args =
//       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

//   if (args == null) {

//     return Scaffold(
//       body: Center(
//         child: Text('Error: Missing arguments'),
//       ),
//     );
//   }

//   final int? selectedRoomId = args['selectedRoomId'] as int?;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recenzija'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 "Unesite vasu ocjenu i komentar",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Ocjena'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite vasu ocjenu';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     ocjena = int.tryParse(value);
//                   }
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Komentar'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite vas komentar';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     komentar = value;
//                   }
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     _submitForm(selectedRoomId!);
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

//   void _submitForm(int selectedRoomId) {
//     // Izradite svoj HTTP zahtjev s podacima iz forme
//     final request = RecenzijaInsertRequest(
//       gostId: loggedUserID,
//       sobaId: selectedRoomId,
//       ocjena: ocjena!,
//       komentar: komentar!,
//     );
//     // Pretvorite objekt request u JSON string
//     final requestBody = jsonEncode(request.toJson());

//       final ioc = new HttpClient();
//       ioc.badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//       final http = new IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Recenzija");
//     http.post(url,
//      body: requestBody,
//      headers: {'Content-Type': 'application/json'})
//     .then((response) {
//       if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Recenzija uspješno obavljena.'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//             Navigator.pushNamed(context, ListaRezervacijaScreen.listaRezervacijaRouteName);
//       } else {
//       }
//     }).catchError((error) {
//     });
//   }

//   String formatDate(DateTime date) {
//     return "${date.day}.${date.month}.${date.year}";
//   }
// }

// class RecenzijaInsertRequest {
//   final int? gostId;
//   final int? sobaId;
//   final int? ocjena;
//   final String komentar;

//   RecenzijaInsertRequest({
//     required this.gostId,
//     required this.sobaId,
//     required this.ocjena,
//     required this.komentar,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'gostId': gostId,
//       'sobaId': sobaId,
//       'ocjena': ocjena,
//       'komentar': komentar,
//     };
//   }
// }


import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../main.dart';
import '../providers/base_provider.dart';
import '../providers/globals.dart';
import 'lista_rezervacija_screen.dart';

class RecenzijaScreen extends StatefulWidget {
  static const String dodajRecenzijuRouteName = '/dodajRecenziju';
  const RecenzijaScreen({Key? key}) : super(key: key);

  @override
  _RecenzijaScreenState createState() => _RecenzijaScreenState();
}

class _RecenzijaScreenState extends State<RecenzijaScreen> {
  final _formKey = GlobalKey<FormState>();

  int? gostId;
  int? sobaId;
  int? ocjena;
  String? komentar;
  bool _isSubmitting = false; // To track the form submission state

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        body: Center(
          child: Text('Error: Missing arguments'),
        ),
      );
    }

    final int? selectedRoomId = args['selectedRoomId'] as int?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recenzija'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Unesite vašu ocjenu i komentar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              // Rating input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ocjena',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.star_border),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite vašu ocjenu';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    ocjena = int.tryParse(value);
                  }
                },
              ),
              SizedBox(height: 16.0),

              // Comment input
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Komentar',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.comment),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite vaš komentar';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    komentar = value;
                  }
                },
              ),
              SizedBox(height: 20.0),

              // Submit button
              ElevatedButton(
                onPressed: _isSubmitting
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _submitForm(selectedRoomId!);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0), backgroundColor: Colors.teal,
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: _isSubmitting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Pošalji'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(int selectedRoomId) async {
    setState(() {
      _isSubmitting = true;
    });

    final request = RecenzijaInsertRequest(
      gostId: loggedUserID,
      sobaId: selectedRoomId,
      ocjena: ocjena!,
      komentar: komentar!,
    );

    final requestBody = jsonEncode(request.toJson());

    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final httpClient = new IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Recenzija");

    try {
      final response = await httpClient.post(
        url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Recenzija uspješno obavljena.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pushNamed(context, ListaRezervacijaScreen.listaRezervacijaRouteName);
      } else {
        _showErrorMessage('Greška pri slanju recenzije');
      }
    } catch (e) {
      _showErrorMessage('Greška pri slanju zahtjeva');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class RecenzijaInsertRequest {
  final int? gostId;
  final int? sobaId;
  final int? ocjena;
  final String komentar;

  RecenzijaInsertRequest({
    required this.gostId,
    required this.sobaId,
    required this.ocjena,
    required this.komentar,
  });

  Map<String, dynamic> toJson() {
    return {
      'gostId': gostId,
      'sobaId': sobaId,
      'ocjena': ocjena,
      'komentar': komentar,
    };
  }
}
