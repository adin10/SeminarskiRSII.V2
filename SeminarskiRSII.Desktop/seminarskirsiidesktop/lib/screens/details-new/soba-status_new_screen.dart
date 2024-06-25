import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/sobastatus_list_screen.dart';
import '../../providers/base_provider.dart';

class NewSobaStatusScreen extends StatefulWidget {
  const NewSobaStatusScreen({Key? key}) : super(key: key);

  @override
  _NewSobaStatusScreenState createState() => _NewSobaStatusScreenState();
}

class _NewSobaStatusScreenState extends State<NewSobaStatusScreen> {
  TextEditingController _statusController = TextEditingController();
  TextEditingController _opisController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String status;
  late String opis;

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Soba Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the status of room';
                  }
                  return null;
                },
                onSaved: (value) {
                  status = value!;
                },
              ),
              TextFormField(
                controller: _opisController,
                decoration: InputDecoration(labelText: 'Soba Opis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description of status';
                  }
                  return null;
                },
                onSaved: (value) {
                  opis = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call your method to create Drzava here
                    _createStatus();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createStatus() {
    // Implement your logic to create Drzava here
final request = SobaStatusInsertRequest(
      status: status,
      opis: opis
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Status uspješno Dodat.'),
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
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SobaStatusListScreen()),
                );
        // Navigator.pushNamed(
        //     context, DrzavaListScreen.drzavaRouteName);
      } else {
        // Pogreška pri slanju zahtjeva
        // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
      }
    }).catchError((error) {
      // Pogreška prilikom izvršavanja HTTP zahtjeva
      // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
    });
  }

  @override
  void dispose() {
    _statusController.dispose();
    _opisController.dispose();
    super.dispose();
  }
}

class SobaStatusInsertRequest {
  final String status;
  final String opis;

    SobaStatusInsertRequest({
    required this.status,
    required this.opis
  });

    Map<String, dynamic> toJson() {
    return {
      'status': status,
      'opis': opis
    };
  }
}