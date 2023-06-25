
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/sobe_screen.dart';
import 'dart:convert';
import '../main.dart';
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
        title: Text('Rezervacija'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Gost ID'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return userId.toString();
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     if (value != null && value.isNotEmpty) {
              //       gostId = userId;
              //     }
              //   },
              // ),
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
                    _submitForm(userId);
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

  void _submitForm(int userId) {
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
      gostId: userId,
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


