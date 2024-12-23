import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsmobile/screens/lista_rezervacija_screen.dart';
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
      return Scaffold(
        body: Center(
          child: Text('Error: Missing arguments'),
        ),
      );
    }

    final GetUserResponse userData = args['userData'] as GetUserResponse;
    final int userId = args['userId'] as int;
    final int? selectedRoomId = args['selectedRoomId'] as int?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervacija'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Unesite datume za vašu rezervaciju",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16.0),
              _buildDateField(
                label: 'Datum rezervacije',
                date: datumRezervacije,
                onDatePicked: (pickedDate) {
                  setState(() {
                    datumRezervacije = pickedDate;
                  });
                },
              ),
              _buildDateField(
                label: 'Završetak rezervacije',
                date: zavrsetakRezervacije,
                onDatePicked: (pickedDate) {
                  setState(() {
                    zavrsetakRezervacije = pickedDate;
                  });
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitForm(userId, userData, selectedRoomId!);
                  }
                },
                child: Text('Rezervisi'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  backgroundColor: Colors.teal,
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required Function(DateTime?) onDatePicked,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          border: OutlineInputBorder(),
        ),
        readOnly: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Unesite $label';
          }
          return null;
        },
        controller: TextEditingController(
          text: date != null ? formatDate(date) : '',
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            onDatePicked(pickedDate);
          }
        },
      ),
    );
  }

  void _submitForm(int userId, GetUserResponse userdata, int selectedRoomId) {
    if (datumRezervacije == null || zavrsetakRezervacije == null) {
      return;
    }
    if (zavrsetakRezervacije!.isBefore(datumRezervacije!)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Greška'),
            content: Text(
                'Završetak rezervacije ne može biti prije datuma rezervacije.'),
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

    final request = RezervacijaInsertRequest(
      gostId: userId,
      sobaId: selectedRoomId,
      datumRezervacije: datumRezervacije!,
      zavrsetakRezervacije: zavrsetakRezervacije!,
    );

    final requestBody = jsonEncode(request.toJson());
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rezervacija uspješno kreirana.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pushNamed(
            context, ListaRezervacijaScreen.listaRezervacijaRouteName);
      }
    }).catchError((error) {});
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
