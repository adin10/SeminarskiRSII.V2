import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsmobile/screens/menu_options_screen.dart';
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
  bool _isSubmitting = false;

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
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.teal,
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: _isSubmitting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Ostavite recenziju'),
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
        // Navigator.pushNamed(
        //     context, ListaRezervacijaScreen.listaRezervacijaRouteName);
Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ListaRezervacijaScreen(),
          ),
          ModalRoute.withName(OptionsScreen.optionsRouteName),
        );
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
