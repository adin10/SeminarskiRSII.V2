import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/soba_list_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/base_provider.dart';

class NewSobaScreen extends StatefulWidget {
  const NewSobaScreen({Key? key}) : super(key: key);

  @override
  _NewSobaScreenState createState() => _NewSobaScreenState();
}

class _NewSobaScreenState extends State<NewSobaScreen> {
  TextEditingController _brojSobe = TextEditingController();
  TextEditingController _brojSprata = TextEditingController();
  TextEditingController _opisSobe = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late int brojSobe;
  late int brojSprata;
  late String opisSobe;
  late String slika;
  late int sobaStatusId;
  File? _selectedImage;
  List<dynamic> statusiSoba = []; // List to hold countries

  @override
  void initState() {
    super.initState();
    _fetchSobaStatus();
  }

  Future<void> _fetchSobaStatus() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus"); // Replace with your endpoint

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        setState(() {
          statusiSoba = json.decode(response.body);
        });
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    }
  }

   Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj Novu Sobu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _brojSprata,
                decoration: InputDecoration(labelText: 'Broj Sprata'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sprat number';
                  }
                  return null;
                },
                onSaved: (value) {
                  brojSprata = int.parse(value!);
                },
              ),
              TextFormField(
                controller: _brojSobe,
                decoration: InputDecoration(labelText: 'Broj Sobe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Room Number';
                  }
                  return null;
                },
                onSaved: (value) {
                  brojSobe = int.parse(value!);
                },
              ),
              TextFormField(
                controller: _opisSobe,
                decoration: InputDecoration(labelText: 'Opis Sobe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Room Description';
                  }
                  return null;
                },
                onSaved: (value) {
                  opisSobe = value!;
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Statusi'),
                items: statusiSoba.map<DropdownMenuItem<int>>((status) {
                  return DropdownMenuItem<int>(
                    value: status['id'],
                    child: Text(status['status']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    sobaStatusId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select Status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  color: Colors.grey[200],
                  height: 200,
                  width: double.infinity,
                  child: _selectedImage == null
                      ? Icon(Icons.add_a_photo, size: 100, color: Colors.grey[700])
                      : Image.file(_selectedImage!, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call your method to create Drzava here
                    _createSoba();
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

  void _createSoba() {
    // Implement your logic to create Grad here
    final request = SobaInsertRequest(
      brojSobe: brojSobe,
      brojSprata: brojSobe,
      opisSobe: opisSobe,
      slika: _selectedImage != null ? base64Encode(_selectedImage!.readAsBytesSync()) : '',
      sobaStatusId: sobaStatusId,
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/Soba");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Soba uspješno Dodata.'),
            behavior: SnackBarBehavior.floating, // Display at the top
          ),
        );
        // Uspješno poslan zahtjev
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SobaListScreen()),
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
    _brojSprata.dispose();
    _brojSobe.dispose();
    _opisSobe.dispose();
    super.dispose();
  }
}

class SobaInsertRequest {
  final int brojSprata;
  final int brojSobe;
  final String opisSobe;
  final String slika;
  final int sobaStatusId;

  SobaInsertRequest({
    required this.brojSprata,
    required this.brojSobe,
    required this.opisSobe,
    required this.slika,
    required this.sobaStatusId,
  });

  Map<String, dynamic> toJson() {
    return {
      'brojSprata': brojSprata,
      'brojSobe': brojSobe,
      'opisSobe': opisSobe,
      'slika': slika,
      'sobaStatusId': sobaStatusId
    };
  }
}