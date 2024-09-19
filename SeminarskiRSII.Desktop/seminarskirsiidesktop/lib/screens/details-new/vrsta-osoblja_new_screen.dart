import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
import '../../providers/base_provider.dart';

class NewVrstaOsobljaScreen extends StatefulWidget {
  final dynamic vrstaOsoblja; // For edit functionality

  const NewVrstaOsobljaScreen({Key? key, this.vrstaOsoblja}) : super(key: key);

  @override
  _NewVrstaOsobljaScreenState createState() => _NewVrstaOsobljaScreenState();
}

class _NewVrstaOsobljaScreenState extends State<NewVrstaOsobljaScreen> {
  TextEditingController _pozicijaController = TextEditingController();
  TextEditingController _zaduzenjaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.vrstaOsoblja != null) {
      _pozicijaController.text = widget.vrstaOsoblja['pozicija'] ?? '';
      _zaduzenjaController.text = widget.vrstaOsoblja['zaduzenja'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vrstaOsoblja != null ? 'Edit Vrsta osoblja' : 'Create New Vrsta osoblja'),
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
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _createOrUpdateVrstaOsoblja();
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

  void _createOrUpdateVrstaOsoblja() async {
    final requestBody = jsonEncode({
      'pozicija': _pozicijaController.text,
      'zaduzenja': _zaduzenjaController.text,
    });

    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);

    try {
      if (widget.vrstaOsoblja == null) {
        // Creating new entry (POST request)
        final url = Uri.parse("${BaseProvider.baseUrl}/VrstaOsoblja");
        await http.post(url, body: requestBody, headers: {"Content-Type": "application/json"});
      } else {
        // Updating existing entry (PUT request)
        final url = Uri.parse("${BaseProvider.baseUrl}/VrstaOsoblja/${widget.vrstaOsoblja['id']}");
        await http.put(url, body: requestBody, headers: {"Content-Type": "application/json"});
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => const VrstaOsobljaListScreen()));
    } catch (error) {
      print(error); // Handle error
    }
  }
}