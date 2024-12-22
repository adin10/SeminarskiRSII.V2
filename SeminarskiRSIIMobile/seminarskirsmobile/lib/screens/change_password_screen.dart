// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:seminarskirsmobile/providers/base_provider.dart';
// import 'package:seminarskirsmobile/providers/globals.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   static const String routeName = '/changePassword';

//   @override
//   _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _oldPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   late final int userId;
//   bool _isLoading = false;
//   String _errorMessage = "";

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Change Your Password"),
//         backgroundColor: Color.fromARGB(255, 200, 216, 199),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 8,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Change Password",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 16),

//                       // Form for password change
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             _buildTextField('Old Password',
//                                 _oldPasswordController, 'Lozinka is required',
//                                 obscureText: true),
//                             _buildTextField('New Password',
//                                 _newPasswordController, 'Lozinka is required',
//                                 obscureText: true),
//                             _buildTextField(
//                                 'Confirm Password',
//                                 _confirmPasswordController,
//                                 'Lozinka is required',
//                                 obscureText: true),
//                             SizedBox(height: 20),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 10.0),
//                               child: ElevatedButton(
//                                 onPressed: _changePassword,
//                                 child: Text("Change Your Password"),
//                                 style: ElevatedButton.styleFrom(
//                                   foregroundColor: Colors.white,
//                                   minimumSize: Size(double.infinity, 50),
//                                   backgroundColor:
//                                       Color.fromARGB(255, 200, 216, 199),
//                                   textStyle: TextStyle(fontSize: 18),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildPasswordField({
//     required TextEditingController controller,
//     required String label,
//     required bool obscureText,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         validator: validator,
//       ),
//     );
//   }

//   Widget _buildTextField(
//       String label, TextEditingController controller, String errorMessage,
//       {TextInputType inputType = TextInputType.text,
//       bool obscureText = false,
//       String? compareValue}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(
//               color: Colors.blueAccent, fontWeight: FontWeight.bold),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           filled: true,
//           fillColor: Colors.blue[50],
//         ),
//         keyboardType: inputType,
//         obscureText: obscureText,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return errorMessage;
//           }
//           if (compareValue != null && value != compareValue) {
//             return 'Lozinke se ne podudaraju';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   void _changePassword() {
//     int id = loggedUserID;
//     final requestBody = jsonEncode({
//       'OldPassword': _oldPasswordController.text,
//       'NewPassword': _newPasswordController.text,
//       'confirmNewPassword': _confirmPasswordController.text,
//     });
//     _submitData(
//         requestBody, "${BaseProvider.baseUrl}/Gost/ChangePassword/$id", 'PUT');
//   }

//   void _submitData(String requestBody, String url, String method) {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final uri = Uri.parse(url);

//     final Future response = http.put(uri,
//         body: requestBody, headers: {'Content-Type': 'application/json'});

//     response.then((res) {
//       if (res.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Registration successful!')),
//         );

//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           '/',
//           (Route<dynamic> route) => false,
//         );
//       } else {
//         final responseData = jsonDecode(response as String);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(responseData['message'] ?? 'Registration failed')),
//         );
//       }
//     });
//   }
// }


// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:seminarskirsmobile/providers/base_provider.dart';
// import 'package:seminarskirsmobile/providers/globals.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   static const String routeName = '/changePassword';

//   @override
//   _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _oldPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Change Password"),
//         backgroundColor: const Color(0xFF395B64),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Card(
//                 elevation: 8,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 color: const Color(0xFFE7F6F2),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Change Your Password",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF2C3333),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             _buildTextField(
//                               label: 'Old Password',
//                               controller: _oldPasswordController,
//                               errorMessage: 'Old password is required',
//                               obscureText: true,
//                             ),
//                             _buildTextField(
//                               label: 'New Password',
//                               controller: _newPasswordController,
//                               errorMessage: 'New password is required',
//                               obscureText: true,
//                             ),
//                             _buildTextField(
//                               label: 'Confirm Password',
//                               controller: _confirmPasswordController,
//                               errorMessage: 'Passwords do not match',
//                               obscureText: true,
//                               compareValue: _newPasswordController.text,
//                             ),
//                             const SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: _changePassword,
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: Colors.white,
//                                 backgroundColor: const Color(0xFF395B64),
//                                 minimumSize: Size(double.infinity, 50),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "Change Password",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required String errorMessage,
//     bool obscureText = false,
//     String? compareValue,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(
//             color: Color(0xFF2C3333),
//             fontWeight: FontWeight.bold,
//           ),
//           filled: true,
//           fillColor: const Color(0xFFD9E4DD),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(
//               color: Color(0xFF395B64),
//               width: 2,
//             ),
//           ),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return errorMessage;
//           }
//           if (compareValue != null && value != compareValue) {
//             return 'Passwords do not match';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   void _changePassword() {
//     if (!_formKey.currentState!.validate()) return;

//     final requestBody = jsonEncode({
//       'OldPassword': _oldPasswordController.text,
//       'NewPassword': _newPasswordController.text,
//       'confirmNewPassword': _confirmPasswordController.text,
//     });

//     _submitData(requestBody);
//   }

//   void _submitData(String requestBody) {
//     final uri = Uri.parse("${BaseProvider.baseUrl}/Gost/ChangePassword/$loggedUserID");
//     final ioc = HttpClient()..badCertificateCallback = (cert, host, port) => true;
//     final http = IOClient(ioc);

//     http.put(uri, body: requestBody, headers: {'Content-Type': 'application/json'}).then((res) {
//       if (res.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Password changed successfully!')),
//         );
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to change password.')),
//         );
//       }
//     });
//   }
// }


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
        title: Text("Change Password"),
        backgroundColor: Colors.teal,
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
                        "Change Your Password",
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
                              label: 'Old Password',
                              controller: _oldPasswordController,
                              errorMessage: 'Old password is required',
                              obscureText: true,
                            ),
                            _buildTextField(
                              label: 'New Password',
                              controller: _newPasswordController,
                              errorMessage: 'New password is required',
                              obscureText: true,
                            ),
                            _buildTextField(
                              label: 'Confirm Password',
                              controller: _confirmPasswordController,
                              errorMessage: 'Passwords do not match',
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
                                "Change Password",
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
    final ioc = HttpClient()..badCertificateCallback = (cert, host, port) => true;
    final http = IOClient(ioc);

    http.put(uri, body: requestBody, headers: {'Content-Type': 'application/json'}).then((res) {
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully!')),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to change password.')),
        );
      }
    });
  }
}
