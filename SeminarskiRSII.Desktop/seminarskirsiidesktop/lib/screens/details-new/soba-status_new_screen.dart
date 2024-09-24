import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/sobastatus_list_screen.dart';
import '../../providers/base_provider.dart';

class NewSobaStatusScreen extends StatefulWidget {
  final dynamic sobaStatus;

  NewSobaStatusScreen({Key? key, this.sobaStatus}) : super(key: key);

  @override
  _NewSobaStatusScreenState createState() => _NewSobaStatusScreenState();
}

class _NewSobaStatusScreenState extends State<NewSobaStatusScreen> {
  TextEditingController _statusController = TextEditingController();
  TextEditingController _opisController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.sobaStatus != null) {
      _statusController.text = widget.sobaStatus['status'] ?? '';
      _opisController.text = widget.sobaStatus['opis'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sobaStatus == null ? 'Create New Soba Status' : 'Update Soba Status',
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
            // width: MediaQuery.of(context).size.width * 0.8, // Responsive width
            width: 550,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sobaStatus == null ? 'Enter New Soba Status Details' : 'Update Soba Status Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _statusController,
                    decoration: InputDecoration(
                      labelText: 'Status',
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
                        return 'Please enter the status';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _opisController,
                    decoration: InputDecoration(
                      labelText: 'Opis',
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
                        return 'Please enter the description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (widget.sobaStatus == null) {
                            _createSobaStatus();
                          } else {
                            _updateSobaStatus(widget.sobaStatus['id']);
                          }
                        }
                      },
                      child: Text(
                        widget.sobaStatus == null ? 'Create Soba Status' : 'Update Soba Status',
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

  void _createSobaStatus() {
    final requestBody = jsonEncode({
      'status': _statusController.text,
      'opis': _opisController.text,
    });
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus");

    http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Soba Status successfully created.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SobaStatusListScreen()));
      } else {
        _showErrorSnackBar();
      }
    }).catchError((error) {
      _showErrorSnackBar();
    });
  }

  void _updateSobaStatus(int id) {
    final requestBody = jsonEncode({
      'status': _statusController.text,
      'opis': _opisController.text,
    });
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus/$id");

    http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Soba Status successfully updated.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SobaStatusListScreen()));
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
        content: Text('Error occurred. Please try again later.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}