import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
import '../../providers/base_provider.dart';

class NewVrstaOsobljaScreen extends StatefulWidget {
  const NewVrstaOsobljaScreen({Key? key}) : super(key: key);

  @override
  _NewVrstaOsobljaScreenState createState() => _NewVrstaOsobljaScreenState();
}

class _NewVrstaOsobljaScreenState extends State<NewVrstaOsobljaScreen> {
  TextEditingController _pozicijaController = TextEditingController();
  TextEditingController _zaduzenjaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String pozicija;
  late String zaduzenja;

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Vrsta osoblja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _pozicijaController,
                decoration: InputDecoration(labelText: 'Pozicija'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the position';
                  }
                  return null;
                },
                onSaved: (value) {
                  pozicija = value!;
                },
              ),
              TextFormField(
                controller: _zaduzenjaController,
                decoration: InputDecoration(labelText: 'Zaduzenja'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the zaduzenja';
                  }
                  return null;
                },
                onSaved: (value) {
                  zaduzenja = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call your method to create Drzava here
                    _createVrstaOsoblja();
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

  void _createVrstaOsoblja() {
    // Implement your logic to create Drzava here
final request = VrstaOsobljaInsertRequest(
      pozicija: pozicija,
      zaduzenja: zaduzenja
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/VrstaOsoblja");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vrsta Osoblja uspješno Dodata.'),
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
                  MaterialPageRoute(builder: (context) => const VrstaOsobljaListScreen()),
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
    _pozicijaController.dispose();
    _zaduzenjaController.dispose();
    super.dispose();
  }
}

class VrstaOsobljaInsertRequest {
  final String pozicija;
  final String zaduzenja;

    VrstaOsobljaInsertRequest({
    required this.pozicija,
    required this.zaduzenja
  });

    Map<String, dynamic> toJson() {
    return {
      'pozicija': pozicija,
      'zaduzenja': zaduzenja
    };
  }
}