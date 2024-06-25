import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
import '../../providers/base_provider.dart';

class NewGradScreen extends StatefulWidget {
  const NewGradScreen({Key? key}) : super(key: key);

  @override
  _NewGradScreenState createState() => _NewGradScreenState();
}

class _NewGradScreenState extends State<NewGradScreen> {
  TextEditingController _nazivController = TextEditingController();
  TextEditingController _postanskiBrojController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String naziv;
  late String postanskiBroj;
  late int drzavaId;
  List<dynamic> drzave = []; // List to hold countries

  @override
  void initState() {
    super.initState();
    _fetchDrzave();
  }

  Future<void> _fetchDrzave() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Drzava"); // Replace with your endpoint

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        setState(() {
          drzave = json.decode(response.body);
        });
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj Novi Grad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nazivController,
                decoration: InputDecoration(labelText: 'Naziv Grada'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the Grad';
                  }
                  return null;
                },
                onSaved: (value) {
                  naziv = value!;
                },
              ),
              TextFormField(
                controller: _postanskiBrojController,
                decoration: InputDecoration(labelText: 'Postanski broj'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the postanski broj';
                  }
                  return null;
                },
                onSaved: (value) {
                  postanskiBroj = value!;
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Drzava'),
                items: drzave.map<DropdownMenuItem<int>>((drzava) {
                  return DropdownMenuItem<int>(
                    value: drzava['id'],
                    child: Text(drzava['naziv']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    drzavaId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a Drzava';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call your method to create Drzava here
                    _createGrad();
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

  void _createGrad() {
    // Implement your logic to create Grad here
    final request = GradInsertRequest(
      nazivGrada: naziv,
      postanskiBroj: postanskiBroj,
      drzavaId: drzavaId,
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/Grad");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Grad uspješno Dodat.'),
            behavior: SnackBarBehavior.floating, // Display at the top
          ),
        );
        // Uspješno poslan zahtjev
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GradListScreen()),
        );
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
    _postanskiBrojController.dispose();
    super.dispose();
  }
}

class GradInsertRequest {
  final String nazivGrada;
  final String postanskiBroj;
  final int drzavaId;

  GradInsertRequest({
    required this.nazivGrada,
    required this.postanskiBroj,
    required this.drzavaId,
  });

  Map<String, dynamic> toJson() {
    return {
      'nazivGrada': nazivGrada,
      'postanskiBroj': postanskiBroj,
      'drzavaId': drzavaId,
    };
  }
}