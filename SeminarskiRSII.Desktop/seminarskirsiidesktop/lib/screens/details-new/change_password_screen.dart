import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seminarskirsiidesktop/providers/base_provider.dart';
import 'package:seminarskirsiidesktop/widgets/master_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final int userId;

  const ChangePasswordScreen({super.key, required this.userId});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = "";
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  Future<void> _changePassword() async {
    int id = widget.userId;

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = "Lozinke se ne podudaraju";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    final response = await http.put(
      Uri.parse("${BaseProvider.baseUrl}/Osoblje/ChangePassword/$id"),
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
      showCustomSnackBar(
        context,
        'Lozinka uspjesno promjenuta.',
        Colors.green,
      );
      Navigator.pop(context);
    } else {
      _showErrorSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Promjenite vasu lozinku',
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 550,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
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
                    'Izmjenite vasu lozinku',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _oldPasswordController,
                    labelText: 'Stara lozinka',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite vasu prethodnu lozinku';
                      }
                      return null;
                    },
                    isPassword: true,
                    toggleVisibility: () {
                      setState(() {
                        _showOldPassword = !_showOldPassword;
                      });
                    },
                    isPasswordVisible: _showOldPassword,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _newPasswordController,
                    labelText: 'Nova lozinka',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite novu lozinku';
                      }
                      return null;
                    },
                    isPassword: true,
                    toggleVisibility: () {
                      setState(() {
                        _showNewPassword = !_showNewPassword;
                      });
                    },
                    isPasswordVisible: _showNewPassword,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Potvrdite novu lozinku',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Potvrdite vasu novu lozinku';
                      }
                      return null;
                    },
                    isPassword: true,
                    toggleVisibility: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                    isPasswordVisible: _showConfirmPassword,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _changePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Promjenite vasu lozinku',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  if (_errorMessage.isNotEmpty) ...[
                    SizedBox(height: 10),
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
    bool isPassword = false,
    required Function toggleVisibility,
    required bool isPasswordVisible,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
            color: Colors.blueAccent, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.blue[50],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blueAccent,
                ),
                onPressed: () => toggleVisibility(),
              )
            : null,
      ),
      validator: validator,
    );
  }

  void showCustomSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        left: MediaQuery.of(context).size.width * 0.20,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3))
        .then((_) => overlayEntry.remove());
  }

  void _showErrorSnackBar() {
    showErrorToast(context, 'Error occurred. Please try again later.');
  }

  void showErrorToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        left: MediaQuery.of(context).size.width * 0.15,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3))
        .then((_) => overlayEntry.remove());
  }
}
