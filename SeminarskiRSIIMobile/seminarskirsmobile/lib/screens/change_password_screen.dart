import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seminarskirsmobile/providers/base_provider.dart';
import 'package:seminarskirsmobile/providers/globals.dart';
import 'package:http/http.dart' as http;


class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/changePassword'; // Route name

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final int userId;
  bool _isLoading = false;
  String _errorMessage = "";

  // Key for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Your Password"),
        backgroundColor: Color.fromARGB(255, 200, 216, 199),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Form for password change
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildPasswordField(
                              controller: _oldPasswordController,
                              label: 'Old Password',
                              obscureText: true,
                            ),
                            buildPasswordField(
                              controller: _newPasswordController,
                              label: 'New Password',
                              obscureText: true,
                            ),
                            buildPasswordField(
                              controller: _confirmPasswordController,
                              label: 'Confirm New Password',
                              obscureText: true,
                              validator: (value) {
                                if (value != _newPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),

                            // Change Password button
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: ElevatedButton(
                                onPressed: _changePassword,
                                child: Text("Change Your Password"),
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

  // Helper method to build a password text field
  Widget buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: validator,
      ),
    );
  }

  Future<void> _changePassword() async {
    int id = loggedUserID;
    print('poruka koji je ID');
    print(id);
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = "New passwords do not match";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    final response = await http.put(
      Uri.parse("${BaseProvider.baseUrl}/Gost/ChangePassword/$id"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'OldPassword': _oldPasswordController.text,
        'NewPassword': _newPasswordController.text,
        'confirmNewPassword': _confirmPasswordController.text
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password changed successfully!")),
      );
      Navigator.pop(context);
    } else {
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error while saving!")),
      );
    }
  }
}
