import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import '../../providers/base_provider.dart';
import '../lists/cjenovnik_list_screen.dart';

class NewCjenovnikScreen extends StatefulWidget {
  final dynamic cjenovnik; // Pass the existing cjenovnik for editing

  const NewCjenovnikScreen({Key? key, this.cjenovnik}) : super(key: key);

  @override
  _NewCjenovnikScreenState createState() => _NewCjenovnikScreenState();
}

class _NewCjenovnikScreenState extends State<NewCjenovnikScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cijenaController = TextEditingController();
  TextEditingController _brojDanaController = TextEditingController();
  String? selectedSoba;
  List<dynamic> sobe = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadSobe();

    if (widget.cjenovnik != null) {
      _cijenaController.text = widget.cjenovnik['cijena']?.toString() ?? '';
      _brojDanaController.text = widget.cjenovnik['brojDana']?.toString() ?? '';
      selectedSoba = widget.cjenovnik['soba']?['id'].toString();
    }
  }

Future loadSobe() async {
  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = IOClient(ioc);
  final url = Uri.parse("${BaseProvider.baseUrl}/Soba"); // Assuming this is your API endpoint for rooms

  final response = await http.get(url);
  if (response.statusCode == 200) {
    setState(() {
      sobe = jsonDecode(response.body);
    });
  } else {
    // Handle error
    print('Error loading rooms: ${response.statusCode}');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cjenovnik == null ? 'Dodaj Cjenovnik' : 'Izmijeni Cjenovnik'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
                  DropdownButtonFormField<String>(
                value: selectedSoba,
                decoration: InputDecoration(labelText: 'Broj Sobe'),
                items: sobe.map((soba) {
                  return DropdownMenuItem<String>(
                    value: soba['id'].toString(),
                    child: Text(soba['brojSobe'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSoba = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Soba';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cijenaController,
                decoration: InputDecoration(labelText: 'Cijena'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite cijenu';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _brojDanaController,
                decoration: InputDecoration(labelText: 'Broj dana'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Molimo unesite broj dana';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.cjenovnik == null) {
                      _createCjenovnik();
                    } else {
                      _updateCjenovnik(widget.cjenovnik['id']);
                    }
                  }
                },
                child: Text(widget.cjenovnik == null ? 'Dodaj' : 'Izmijeni'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createCjenovnik() {
    final request = {
      'sobaId': int.parse(selectedSoba!),
      'cijena': double.parse(_cijenaController.text),
      'brojDana': int.parse(_brojDanaController.text),
    };

    final requestBody = jsonEncode(request);
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik"); // Adjust the URL

    http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cjenovnik successfully created.'),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CjenovnikListScreen()));
      } else {
        // Handle error
        print("Error creating Cjenovnik: ${response.body}");
      }
    }).catchError((error) {
      print("Error: $error");
    });
  }

  void _updateCjenovnik(int id) {
    final request = {
      'sobaId': int.parse(selectedSoba!),
      'cijena': double.parse(_cijenaController.text),
      'brojDana': int.parse(_brojDanaController.text),
    };
    final requestBody = jsonEncode(request);
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik/$id"); // Adjust the URL

    http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cjenovnik successfully updated.'),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CjenovnikListScreen()));
      } else {
        // Handle error
        print("Error updating Cjenovnik: ${response.body}");
      }
    }).catchError((error) {
      print("Error: $error");
    });
  }

    @override
  void dispose() {
    _cijenaController.dispose();
    _brojDanaController.dispose();
    super.dispose();
  }
}