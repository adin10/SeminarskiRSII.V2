import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:convert';
import 'package:seminarskirsmobile/providers/base_provider.dart';
import 'package:seminarskirsmobile/providers/grad_provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController imeController = TextEditingController();
  final TextEditingController prezimeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController korisnickoImeController = TextEditingController();
  final TextEditingController lozinkaController = TextEditingController();
  final TextEditingController potvrdiLozinkuController = TextEditingController();

  int? selectedGrad;
  List<dynamic> _gradoviList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchGradove();
  }

Future<void> _fetchGradove() async {
  setState(() {
    _isLoading = true;
  });
  try {
    var fetchedGradovi = await GradProvider().get('');
    
    if (fetchedGradovi == null) {
      throw Exception("No data received");
    }

    setState(() {
      _gradoviList = fetchedGradovi;
    });
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load gradovi: $error')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Text(
                  'Create Your Account',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              // Fields
              _buildTextField('Ime', imeController, 'Ime is required'),
              _buildTextField('Prezime', prezimeController, 'Prezime is required'),
              _buildTextField('Email', emailController, 'Valid email is required', inputType: TextInputType.emailAddress),
              _buildTextField('Telefon', telefonController, 'Telefon is required', inputType: TextInputType.phone),
              // Dropdown for Grad
              const SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _buildDropdownField(
                      labelText: 'Gradovi',
                      value: selectedGrad,
                      items: _gradoviList.map<DropdownMenuItem<int>>((grad) {
                        return DropdownMenuItem<int>(
                          value: grad['id'],
                          child: Text(grad['nazivGrada']),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedGrad = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a country';
                        }
                        return null;
                      },
                    ),
              SizedBox(height: 16),
              _buildTextField('Korisnicko Ime', korisnickoImeController, 'Korisnicko Ime is required'),
              _buildTextField('Lozinka', lozinkaController, 'Lozinka is required', obscureText: true),
              _buildTextField('Potvrdi Lozinku', potvrdiLozinkuController, 'Lozinke se ne podudaraju',
                  obscureText: true, compareValue: lozinkaController.text),
              SizedBox(height: 20),
              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: _registerUser,
                  child: Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Color.fromARGB(255, 200, 216, 199),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
        
  void _registerUser() {
    final requestBody = jsonEncode({
       'ime': imeController.text,
       'prezime': prezimeController.text,
       'email': emailController.text,
        'telefon': telefonController.text,
        'gradId': selectedGrad,
        'korisnickoIme': korisnickoImeController.text,
        'lozinka': lozinkaController.text,
        'potvrdiLozinku': potvrdiLozinkuController.text,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Gost", 'POST');
  }

  void _submitData(String requestBody, String url, String method) {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final uri = Uri.parse(url);

    final Future response = http.post(uri,
        body: requestBody, headers: {'Content-Type': 'application/json'});

    response.then((res) {
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (Route<dynamic> route) => false,
        );
      } else {
        final responseData = jsonDecode(response as String);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(responseData['message'] ?? 'Registration failed')),
        );
      }
    });
  }

   Widget _buildDropdownField({
    required String labelText,
    required int? value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    required String? Function(int?) validator,
  }) {
    return DropdownButtonFormField<int>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
            const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.blue[50],
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String errorMessage,
      {TextInputType inputType = TextInputType.text, bool obscureText = false, String? compareValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
           labelStyle:
            const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.blue[50],
        ),
        keyboardType: inputType,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          if (compareValue != null && value != compareValue) {
            return 'Lozinke se ne podudaraju';
          }
          return null;
        },
      ),
    );
  }
}