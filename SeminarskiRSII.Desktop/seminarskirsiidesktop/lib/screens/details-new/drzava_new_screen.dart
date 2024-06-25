import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
import '../../providers/base_provider.dart';

class NewDrzavaScreen extends StatefulWidget {
  const NewDrzavaScreen({Key? key}) : super(key: key);

  @override
  _NewDrzavaScreenState createState() => _NewDrzavaScreenState();
}

class _NewDrzavaScreenState extends State<NewDrzavaScreen> {
  TextEditingController _nazivController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String naziv;

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Drzava'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Naziv Drzave'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the Drzava';
                  }
                  return null;
                },
                onSaved: (value) {
                  naziv = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call your method to create Drzava here
                    _createDrzava();
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

  void _createDrzava() {
    // Implement your logic to create Drzava here
final request = DrzavaInsertRequest(
      naziv: naziv,
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/Drzava");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Drzava uspješno Dodata.'),
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
                  MaterialPageRoute(builder: (context) => const DrzavaListScreen()),
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
    _nazivController.dispose();
    super.dispose();
  }
}

class DrzavaInsertRequest {
  final String naziv;

    DrzavaInsertRequest({
    required this.naziv
  });

    Map<String, dynamic> toJson() {
    return {
      'naziv': naziv,
    };
  }
}