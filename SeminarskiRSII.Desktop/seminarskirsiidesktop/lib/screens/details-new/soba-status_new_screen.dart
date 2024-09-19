import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/sobastatus_list_screen.dart';
import '../../providers/base_provider.dart';

class NewSobaStatusScreen extends StatefulWidget {
  final Map<String, dynamic>? sobaStatus;

  const NewSobaStatusScreen({Key? key, this.sobaStatus}) : super(key: key);

  @override
  _NewSobaStatusScreenState createState() => _NewSobaStatusScreenState();
}

class _NewSobaStatusScreenState extends State<NewSobaStatusScreen> {
  late TextEditingController _statusController;
  late TextEditingController _opisController;
  final _formKey = GlobalKey<FormState>();
  late String status;
  late String opis;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data if editing
    _statusController = TextEditingController(
      text: widget.sobaStatus != null ? widget.sobaStatus!['status'] : '',
    );
    _opisController = TextEditingController(
      text: widget.sobaStatus != null ? widget.sobaStatus!['opis'] : '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sobaStatus != null
            ? 'Edit Soba Status'
            : 'Create New Soba Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Soba Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the status of the room';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _opisController,
                decoration: InputDecoration(labelText: 'Soba Opis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description of the status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.sobaStatus == null) {
                      _createSobaStatus();
                    } else {
                      _updateSobaStatus(widget.sobaStatus!['id']);
                    }
                  }
                },
                child: Text(widget.sobaStatus != null ? 'Update' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

void _createSobaStatus() {
  final request = SobaStatusInsertRequest(
    status: _statusController.text,  // Use controller text
    opis: _opisController.text,      // Use controller text
  );

  final requestBody = jsonEncode(request.toJson());
  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = IOClient(ioc);
  final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus");

  http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Soba Status successfully created.'),
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SobaStatusListScreen()));
    } else {
      // Handle error
    }
  }).catchError((error) {
    // Handle error
  });
}

void _updateSobaStatus(int id) {
  final request = SobaStatusInsertRequest(
    status: _statusController.text,  // Use controller text
    opis: _opisController.text,      // Use controller text
  );

  final requestBody = jsonEncode(request.toJson());
  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = IOClient(ioc);
  final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus/$id");

  http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Soba Status successfully updated.'),
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SobaStatusListScreen()));
    } else {
      // Handle error
    }
  }).catchError((error) {
    // Handle error
  });
}

  @override
  void dispose() {
    _statusController.dispose();
    _opisController.dispose();
    super.dispose();
  }
}

class SobaStatusInsertRequest {
  final String status;
  final String opis;

  SobaStatusInsertRequest({required this.status, required this.opis});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'opis': opis,
    };
  }
}