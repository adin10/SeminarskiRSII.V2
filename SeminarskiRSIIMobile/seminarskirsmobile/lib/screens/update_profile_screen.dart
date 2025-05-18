import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/providers/base_provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/updateProfile';
  final GetUserResponse userData;

  UpdateProfileScreen({required this.userData});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _telefonController = TextEditingController();
  final _usernameController = TextEditingController();
  final _imeController = TextEditingController();
  final _prezimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = widget.userData;

    _emailController.text = userData.email ?? '';
    _telefonController.text = userData.telefon ?? '';
    _usernameController.text = userData.korisnickoIme ?? '';
    _imeController.text = userData.ime ?? '';
    _prezimeController.text = userData.prezime ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text("Uredite vase podatke"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Color(0xFFE7F6F2),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                        "Email", _emailController, 'Email je obavezno polje'),
                    _buildTextField("Telefon", _telefonController,
                        'Telefon je obavezno polje'),
                    _buildTextField("Korisničko ime", _usernameController,
                        'Korisničko ime je obavezno polje'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _updateUser(userData.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text("Spasi promjene",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String errorMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFD9E4DD),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return errorMessage;
          return null;
        },
      ),
    );
  }

  void _updateUser(int userId) {
    if (!_formKey.currentState!.validate()) return;

    final body = jsonEncode({
      "email": _emailController.text,
      "telefon": _telefonController.text,
      "korisnickoIme": _usernameController.text,
    });

    final uri = Uri.parse("${BaseProvider.baseUrl}/Gost/UpdateProfile/$userId");
    final ioc = HttpClient()
      ..badCertificateCallback = (cert, host, port) => true;
    final http = IOClient(ioc);

    http.put(uri,
        body: body, headers: {'Content-Type': 'application/json'}).then((res) {
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Podaci uspješno ažurirani!')),
        );

        final updatedUser = GetUserResponse(
          id: userId,
          email: _emailController.text,
          telefon: _telefonController.text,
          korisnickoIme: _usernameController.text,
          ime: _imeController.text,
          prezime: _prezimeController.text,
        );

        Navigator.pop(context, updatedUser);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Greška prilikom ažuriranja podataka.')),
        );
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Došlo je do greške: $err')),
      );
    });
  }
}
