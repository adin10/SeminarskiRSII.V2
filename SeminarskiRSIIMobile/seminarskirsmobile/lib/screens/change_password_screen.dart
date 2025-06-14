import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsmobile/providers/base_provider.dart';
import 'package:seminarskirsmobile/providers/globals.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/changePassword';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promjena lozinke"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color(0xFFE7F6F2),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Promjenite vasu lozinku",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C3333),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              label: 'Stara lozinka',
                              controller: _oldPasswordController,
                              errorMessage: 'Stara lozinka je obavezno polje',
                              obscureText: true,
                            ),
                            _buildTextField(
                              label: 'Nova lozinka',
                              controller: _newPasswordController,
                              errorMessage: 'Nova lozinka je obavezno polje',
                              obscureText: true,
                            ),
                            _buildTextField(
                              label: 'Povrdite novu lozinku',
                              controller: _confirmPasswordController,
                              errorMessage: 'Passwordi se ne slazu',
                              obscureText: true,
                              customValidator: (value) =>
                                  value == _newPasswordController.text,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _changePassword,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.teal,
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Promjeni lozinku",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String errorMessage,
    bool obscureText = false,
    bool Function(String)? customValidator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF2C3333),
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: const Color(0xFFD9E4DD),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF395B64),
              width: 2,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          if (customValidator != null && !customValidator(value)) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }

  void _changePassword() {
    if (!_formKey.currentState!.validate()) return;

    final requestBody = jsonEncode({
      'OldPassword': _oldPasswordController.text,
      'NewPassword': _newPasswordController.text,
      'confirmNewPassword': _confirmPasswordController.text,
    });

    _submitData(requestBody);
  }

  void _submitData(String requestBody) {
    final uri =
        Uri.parse("${BaseProvider.baseUrl}/Gost/ChangePassword/$loggedUserID");
    final ioc = HttpClient()
      ..badCertificateCallback = (cert, host, port) => true;
    final http = IOClient(ioc);

    http.put(uri,
        body: requestBody,
        headers: {'Content-Type': 'application/json'}).then((res) {
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Lozinka uspjesno promjenuta",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Greska prilikom izmjene lozinke",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    });
  }
}
