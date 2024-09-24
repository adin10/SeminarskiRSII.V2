import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import '../../providers/base_provider.dart';
import '../lists/gradovi_list_screen.dart';

class NewGradScreen extends StatefulWidget {
  final dynamic grad;

  NewGradScreen({Key? key, this.grad}) : super(key: key);

  @override
  _NewGradScreenState createState() => _NewGradScreenState();
}

class _NewGradScreenState extends State<NewGradScreen> {
  TextEditingController _nazivGradaController = TextEditingController();
  TextEditingController _postanskiBrojController = TextEditingController();
  String? _selectedDrzava;
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _drzave = [];

  @override
  void initState() {
    super.initState();
    _fetchDrzave();
    if (widget.grad != null) {
      _nazivGradaController.text = widget.grad['nazivGrada'] ?? '';
      _postanskiBrojController.text = widget.grad['postanskiBroj']?.toString() ?? '';
      _selectedDrzava = widget.grad['drzava']?['id'].toString();
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
        title: Text(
          widget.grad == null ? 'Create New Grad' : 'Update Grad',
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
                    widget.grad == null ? 'Enter New Grad Details' : 'Update Grad Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nazivGradaController,
                    decoration: InputDecoration(
                      labelText: 'Naziv Grada',
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
                        return 'Please enter the name of the Grad';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _postanskiBrojController,
                    decoration: InputDecoration(
                      labelText: 'Postanski Broj',
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
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the postal code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedDrzava,
                    decoration: InputDecoration(
                      labelText: 'Drzava',
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
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
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
                      child: Text(
                        widget.grad == null ? 'Create Grad' : 'Update Grad',
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Grad successfully created.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const GradListScreen()));
      } else {
        _showErrorSnackBar();
      }
    }).catchError((error) {
      _showErrorSnackBar();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Grad successfully updated.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const GradListScreen()));
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

class GradInsertRequest {
  String nazivGrada;
  int postanskiBroj;
  int drzavaId;

  GradInsertRequest({required this.nazivGrada, required this.postanskiBroj, required this.drzavaId});

  Map<String, dynamic> toJson() => {
        'nazivGrada': nazivGrada,
        'postanskiBroj': postanskiBroj,
        'drzavaId': drzavaId,
      };
}