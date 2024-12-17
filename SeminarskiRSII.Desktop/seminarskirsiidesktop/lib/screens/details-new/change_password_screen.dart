// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ChangePasswordScreen extends StatefulWidget {
//   final int userId; // User ID for identifying the user

//   ChangePasswordScreen({required this.userId});

//   @override
//   _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _oldPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _isLoading = false;
//   String _errorMessage = "";

//   Future<void> _changePassword() async {
//     if (_newPasswordController.text != _confirmPasswordController.text) {
//       setState(() {
//         _errorMessage = "New passwords do not match";
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });

//     final response = await http.put(
//       Uri.parse('https://your-api-url/Osoblje/ChangePassword/${widget.userId}'),
//       body: {
//         'OldPassword': _oldPasswordController.text,
//         'NewPassword': _newPasswordController.text,
//       },
//     );

//     setState(() {
//       _isLoading = false;
//     });

//     if (response.statusCode == 200) {
//       // Successfully updated the password
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Password updated successfully"),
//       ));
//       Navigator.pop(context);
//     } else {
//       // Handle error
//       setState(() {
//         _errorMessage = "Failed to update password. Please try again.";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             if (_errorMessage.isNotEmpty)
//               Text(
//                 _errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//             TextField(
//               controller: _oldPasswordController,
//               decoration: const InputDecoration(
//                 labelText: 'Old Password',
//                 obscureText: true,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _newPasswordController,
//               decoration: const InputDecoration(
//                 labelText: 'New Password',
//                 obscureText: true,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _confirmPasswordController,
//               decoration: const InputDecoration(
//                 labelText: 'Confirm New Password',
//                 obscureText: true,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _changePassword,
//               child: _isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text('Change Password'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
