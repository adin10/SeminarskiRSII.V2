import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/sobaosoblje_list_screen.dart';
import '../../providers/base_provider.dart';

class NewSobaOsobljeScreen extends StatefulWidget {
  const NewSobaOsobljeScreen({Key? key}) : super(key: key);

  @override
  _NewSobaOsobljeScreenState createState() => _NewSobaOsobljeScreenState();
}

class _NewSobaOsobljeScreenState extends State<NewSobaOsobljeScreen> {
  final _formKey = GlobalKey<FormState>();
  late int sobaId;
  late int osobljeId;
  List<dynamic> sobe = []; // List to hold countries
  List<dynamic> osoblje = []; // List to hold countries

  @override
  void initState() {
    super.initState();
    _fetchSobe();
    _fetchOsoblje();
  }

  Future<void> _fetchSobe() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Soba"); // Replace with your endpoint

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        setState(() {
          sobe = json.decode(response.body);
        });
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodjeli sobu uposleniku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Soba'),
                items: sobe.map<DropdownMenuItem<int>>((soba) {
                  return DropdownMenuItem<int>(
                    value: soba['id'],
                    child: Text(soba['brojSobe'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    sobaId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select Soba';
                  }
                  return null;
                },
              ),
               DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Osoblje'),
                items: osoblje.map<DropdownMenuItem<int>>((osoba) {
                  return DropdownMenuItem<int>(
                    value: osoba['id'],
                    child: Text("${osoba['ime']} ${osoba['prezime']}"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    osobljeId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select Uposlenik';
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
                    _createSobaOsoblje();
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

  void _createSobaOsoblje() {
    // Implement your logic to create Grad here
    final request = SobaOsobljeInsertRequest(
      sobaId: sobaId,
      osobljeId: osobljeId
    );

    // Pretvorite objekt request u JSON string
    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    // Izvršite HTTP POST zahtjev na server
    final url = Uri.parse("${BaseProvider.baseUrl}/SobaOsoblje");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Soba uspjesno dodjeljena uposleniku.'),
            behavior: SnackBarBehavior.floating, // Display at the top
          ),
        );
        // Uspješno poslan zahtjev
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SobaOsobljeListScreen()),
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
    super.dispose();
  }
}

class SobaOsobljeInsertRequest {
  final int sobaId;
  final int osobljeId;

  SobaOsobljeInsertRequest({
    required this.sobaId,
    required this.osobljeId
  });

  Map<String, dynamic> toJson() {
    return {
      'sobaId': sobaId,
      'osobljeId': osobljeId
    };
  }
}