
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

  // final GetUserResponse userData = args['userData'] as GetUserResponse;
  // final int userId = args['userId'] as int;
  final int? selectedRoomId = args['selectedRoomId'] as int?; // Retrieve the selected room ID
    return Scaffold(
      appBar: AppBar(
        title: Text('Recenzija'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Soba ID'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Unesite Soba ID';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     if (value != null && value.isNotEmpty) {
              //       sobaId = int.tryParse(value);
              //     }
              //   },
              // ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ocjena'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite vasu ocjenu';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    ocjena = int.tryParse(value);
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Komentar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite vas komentar';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    komentar = value;
                  }
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Ovdje možete izvršiti slanje podataka na server
                    _submitForm(selectedRoomId!);
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

  void _submitForm(int selectedRoomId) {
    // Provjerite jesu li unosi datuma postavljeni
  //   if (datumRezervacije == null || zavrsetakRezervacije == null) {
  //     // Prikazati poruku o grešci ili poduzeti odgovarajuće radnje
  //     return;
  //   }
  //    if (zavrsetakRezervacije!.isBefore(datumRezervacije!)) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Greška'),
  //         content: Text('Završetak rezervacije ne može biti prije datuma rezervacije.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: Text('U redu'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   return;
  // }

    // Izradite svoj HTTP zahtjev s podacima iz forme
    final request = RecenzijaInsertRequest(
      gostId: loggedUserID,
      sobaId: selectedRoomId,
      ocjena: ocjena!,
      komentar: komentar!,
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());


      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/Recenzija");
    http.post(url,
     body: requestBody,
     headers: {'Content-Type': 'application/json'})
    .then((response) {
      if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recenzija uspješno obavljena.'),
          behavior: SnackBarBehavior.floating, // Display at the top
        ),
      );
        // Uspješno poslan zahtjev
        // Ovdje možete dodati odgovarajući postupak za prikaz poruke ili navigaciju na drugi ekran
    //     Navigator.pushNamed(context, SobeScreen.sobeRouteName,
    //          arguments: {
    //   'userData': userdata,
    //   'userId': userId ,
    //  },);
            Navigator.pushNamed(context, ListaRezervacijaScreen.listaRezervacijaRouteName);
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


