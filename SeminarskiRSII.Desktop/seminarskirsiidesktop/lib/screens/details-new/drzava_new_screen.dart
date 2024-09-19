import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
import '../../providers/base_provider.dart';

class NewDrzavaScreen extends StatefulWidget {
  final dynamic drzava;  // Add drzava parameter

  NewDrzavaScreen({Key? key, this.drzava}) : super(key: key);  // Remove const and make drzava optional

  @override
  _NewDrzavaScreenState createState() => _NewDrzavaScreenState();
}

class _NewDrzavaScreenState extends State<NewDrzavaScreen> {
  TextEditingController _nazivController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String naziv;

  @override
  void initState() {
    super.initState();

    // If we're updating an existing Drzava, populate the form
    if (widget.drzava != null) {
      _nazivController.text = widget.drzava['naziv'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drzava == null ? 'Create New Drzava' : 'Update Drzava'),
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
                    // Call the appropriate method for creating or updating
                    if (widget.drzava == null) {
                      _createDrzava();
                    } else {
                      _updateDrzava(widget.drzava['id']);
                    }
                  }
                },
                child: Text(widget.drzava == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createDrzava() {
    final request = DrzavaInsertRequest(naziv: naziv);

    final requestBody = jsonEncode(request.toJson());
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Drzava");

    http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Drzava successfully created.'),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DrzavaListScreen()));
      } else {
        // Handle error
      }
    }).catchError((error) {
      // Handle error
    });
  }

  void _updateDrzava(int id) {
    final request = DrzavaInsertRequest(naziv: naziv);
    final requestBody = jsonEncode(request.toJson());
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Drzava/$id");

    http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Drzava successfully updated.'),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DrzavaListScreen()));
      } else {
        // Handle error
      }
    }).catchError((error) {
      // Handle error
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

  DrzavaInsertRequest({required this.naziv});

  Map<String, dynamic> toJson() {
    return {'naziv': naziv};
  }
}