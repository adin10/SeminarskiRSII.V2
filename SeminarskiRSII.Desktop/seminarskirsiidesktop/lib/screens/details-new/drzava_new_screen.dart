import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
import '../../providers/base_provider.dart';

class NewDrzavaScreen extends StatefulWidget {
  final dynamic drzava;

  NewDrzavaScreen({Key? key, this.drzava}) : super(key: key);

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
    if (widget.drzava != null) {
      _nazivController.text = widget.drzava['naziv'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.drzava == null ? 'Create New Drzava' : 'Update Drzava',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
             width: 550,  // Set a fixed width for the form container
            padding: const EdgeInsets.all(24.0),  // Add padding around the form
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),  // Shadow for a floating effect
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.drzava == null ? 'Enter New Drzava Details' : 'Update Drzava Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nazivController,
                    decoration: InputDecoration(
                      labelText: 'Naziv Drzave',
                      labelStyle: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
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
                  SizedBox(height: 30),
                  Center(  // Center the button within the form
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (widget.drzava == null) {
                            _createDrzava();
                          } else {
                            _updateDrzava(widget.drzava['id']);
                          }
                        }
                      },
                      child: Text(
                        widget.drzava == null ? 'Create Drzava' : 'Update Drzava',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Drzava successfully created.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const DrzavaListScreen()));
      } else {
        _showErrorSnackBar();
      }
    }).catchError((error) {
      _showErrorSnackBar();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Drzava successfully updated.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const DrzavaListScreen()));
      } else {
        _showErrorSnackBar();
      }
    }).catchError((error) {
      _showErrorSnackBar();
    });
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Something went wrong. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
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