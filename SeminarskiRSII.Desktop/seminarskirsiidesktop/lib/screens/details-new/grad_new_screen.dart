import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import '../../providers/base_provider.dart';
import '../lists/gradovi_list_screen.dart';

class NewGradScreen extends StatefulWidget {
  final dynamic grad;  // Add grad parameter

  NewGradScreen({Key? key, this.grad}) : super(key: key);  // Remove const and make grad optional

  @override
  _NewGradScreenState createState() => _NewGradScreenState();
}

class _NewGradScreenState extends State<NewGradScreen> {
  TextEditingController _nazivGradaController = TextEditingController();
  TextEditingController _postanskiBrojController = TextEditingController();
  String? _selectedDrzava;
  final _formKey = GlobalKey<FormState>();

  List<dynamic> _drzave = []; // List to hold Drzava data

  @override
  void initState() {
    super.initState();
    _fetchDrzave();
    if (widget.grad != null) {
      _nazivGradaController.text = widget.grad['nazivGrada'] ?? '';
      _postanskiBrojController.text = widget.grad['postanskiBroj']?.toString() ?? '';
      _selectedDrzava = widget.grad['drzava']?['id'].toString(); // Set the selected Drzava ID
    }
  }

  Future<void> _fetchDrzave() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Drzava");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _drzave = jsonDecode(response.body);
        });
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.grad == null ? 'Create New Grad' : 'Update Grad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nazivGradaController,
                decoration: InputDecoration(labelText: 'Naziv Grada'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the Grad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _postanskiBrojController,
                decoration: InputDecoration(labelText: 'Postanski Broj'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the postal code';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedDrzava,
                decoration: InputDecoration(labelText: 'Drzava'),
                items: _drzave.map((drzava) {
                  return DropdownMenuItem<String>(
                    value: drzava['id'].toString(),
                    child: Text(drzava['naziv']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDrzava = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                    if (widget.grad == null) {
                      _createGrad();
                    } else {
                      _updateGrad(widget.grad['id']);
                    }
                  }
                },
                child: Text(widget.grad == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createGrad() {
    final request = GradInsertRequest(
      nazivGrada: _nazivGradaController.text,
      postanskiBroj: int.parse(_postanskiBrojController.text),
      drzavaId: int.parse(_selectedDrzava!),
    );

    final requestBody = jsonEncode(request.toJson());
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Grad");

    http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Grad successfully created.'),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GradListScreen()));
      } else {
        // Handle error
      }
    }).catchError((error) {
      // Handle error
    });
  }

  void _updateGrad(int id) {
    final request = GradInsertRequest(
      nazivGrada: _nazivGradaController.text,
      postanskiBroj: int.parse(_postanskiBrojController.text),
      drzavaId: int.parse(_selectedDrzava!),
    );
    final requestBody = jsonEncode(request.toJson());
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Grad/$id");

    http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Grad successfully updated.'),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GradListScreen()));
      } else {
        // Handle error
      }
    }).catchError((error) {
      // Handle error
    });
  }

  @override
  void dispose() {
    _nazivGradaController.dispose();
    _postanskiBrojController.dispose();
    super.dispose();
  }
}

class GradInsertRequest {
  final String nazivGrada;
  final int postanskiBroj;
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