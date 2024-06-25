import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/novosti_list_screen.dart';
import '../../providers/base_provider.dart';

class NewNovostScreen extends StatefulWidget {
  const NewNovostScreen({Key? key}) : super(key: key);

  @override
  _NewNovostScreenState createState() => _NewNovostScreenState();
}

class _NewNovostScreenState extends State<NewNovostScreen> {
  TextEditingController _naslovController = TextEditingController();
  TextEditingController _sadrzajController = TextEditingController();
  TextEditingController _datumController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String naslov;
  late String sadrzaj;
  late DateTime datumObjave;
  late int osobljeId;
  List<dynamic> osoblje = []; // List to hold countries

  @override
  void initState() {
    super.initState();
    _fetchOsoblje();
  }

  Future<void> _fetchOsoblje() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Osoblje"); // Replace with your endpoint

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        setState(() {
          osoblje = json.decode(response.body);
        });
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        datumObjave = picked;
        _datumController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj Novu Obavijest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _naslovController,
                decoration: InputDecoration(labelText: 'Naslov'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
                onSaved: (value) {
                  naslov = value!;
                },
              ),
              TextFormField(
                controller: _sadrzajController,
                decoration: InputDecoration(labelText: 'Sadrzaj'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the text of news';
                  }
                  return null;
                },
                onSaved: (value) {
                  sadrzaj = value!;
                },
              ),
              TextFormField(
                controller: _datumController,
                decoration: InputDecoration(labelText: 'Datum Objave'),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the date';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Autor'),
                items: osoblje.map<DropdownMenuItem<int>>((autor) {
                  return DropdownMenuItem<int>(
                    value: autor['id'],
                    child: Text("${autor['ime']} ${autor['prezime']}"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    osobljeId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select author';
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
                    _createNews();
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

  void _createNews() {
    // Implement your logic to create Grad here
    final request = NovostiInsertRequest(
      naslov: naslov,
      sadrzaj: sadrzaj,
      datumObjave: datumObjave,
      osobljeId: osobljeId
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/Novosti");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Novost uspješno Dodata.'),
            behavior: SnackBarBehavior.floating, // Display at the top
          ),
        );
        // Uspješno poslan zahtjev
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NovostiListScreen()),
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
    _naslovController.dispose();
    _sadrzajController.dispose();
     _datumController.dispose();
    super.dispose();
  }
}

class NovostiInsertRequest {
  final String naslov;
  final String sadrzaj;
  final DateTime datumObjave;
  final int osobljeId;

  NovostiInsertRequest({
    required this.naslov,
    required this.sadrzaj,
    required this.datumObjave,
    required this.osobljeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'naslov': naslov,
      'sadrzaj': sadrzaj,
      'datumObjave': datumObjave.toIso8601String(),
      'osobljeId': osobljeId
    };
  }
}