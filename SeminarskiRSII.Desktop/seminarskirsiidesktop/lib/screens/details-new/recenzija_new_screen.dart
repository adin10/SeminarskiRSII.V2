import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/novosti_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/recenzija_list_screen.dart';
import '../../providers/base_provider.dart';

class NewRecenzijaScreen extends StatefulWidget {
  const NewRecenzijaScreen({Key? key}) : super(key: key);

  @override
  _NewRecenzijaScreenState createState() => _NewRecenzijaScreenState();
}

class _NewRecenzijaScreenState extends State<NewRecenzijaScreen> {
  final TextEditingController _komentarController = TextEditingController();
  final TextEditingController _ocjenaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late int ocjena;
  late String komentar;
  late int gostId;
  late int sobaId;
  List<dynamic> sobe = [];
  List<dynamic> gosti = [];

  @override
  void initState() {
    super.initState();
    _fetchSobe();
    _fetchGosti();
  }

  Future<void> _fetchSobe() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Soba");

    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
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

  Future<void> _fetchGosti() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Gost");

    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        setState(() {
          gosti = json.decode(response.body);
        });
      } else {}
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj Novu Recenziju'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Gost'),
                items: gosti.map<DropdownMenuItem<int>>((gost) {
                  return DropdownMenuItem<int>(
                    value: gost['id'],
                    child: Text("${gost['ime']} ${gost['prezime']}"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gostId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select gost';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'soba'),
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
                    return 'Please select soba';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ocjenaController,
                decoration: const InputDecoration(labelText: 'Ocjena'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the value';
                  }
                  return null;
                },
                onSaved: (value) {
                  ocjena = int.parse(value!);
                },
              ),
              TextFormField(
                controller: _komentarController,
                decoration: const InputDecoration(labelText: 'Komentar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the text';
                  }
                  return null;
                },
                onSaved: (value) {
                  komentar = value!;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _createNews();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createNews() {
    final request = RecenzijaInsertRequest(
        gostId: gostId, sobaId: sobaId, ocjena: ocjena, komentar: komentar);

    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Recenzija");
    http.post(url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recenzija uspješno Dodata.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecenzijaListScreen()),
        );
      } else {}
    }).catchError((error) {});
  }

  @override
  void dispose() {
    _ocjenaController.dispose();
    _komentarController.dispose();
    super.dispose();
  }
}

class RecenzijaInsertRequest {
  final int gostId;
  final int sobaId;
  final int ocjena;
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
