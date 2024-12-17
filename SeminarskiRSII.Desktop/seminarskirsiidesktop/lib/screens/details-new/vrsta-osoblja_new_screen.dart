// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
// import '../../providers/base_provider.dart';

// class NewVrstaOsobljaScreen extends StatefulWidget {
//   final dynamic vrstaOsoblja; // For edit functionality

//   const NewVrstaOsobljaScreen({Key? key, this.vrstaOsoblja}) : super(key: key);

//   @override
//   _NewVrstaOsobljaScreenState createState() => _NewVrstaOsobljaScreenState();
// }

// class _NewVrstaOsobljaScreenState extends State<NewVrstaOsobljaScreen> {
//   TextEditingController _pozicijaController = TextEditingController();
//   TextEditingController _zaduzenjaController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.vrstaOsoblja != null) {
//       _pozicijaController.text = widget.vrstaOsoblja['pozicija'] ?? '';
//       _zaduzenjaController.text = widget.vrstaOsoblja['zaduzenja'] ?? '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.vrstaOsoblja != null ? 'Edit Vrsta osoblja' : 'Create New Vrsta osoblja'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _pozicijaController,
//                 decoration: InputDecoration(labelText: 'Pozicija'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the position';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _zaduzenjaController,
//                 decoration: InputDecoration(labelText: 'Zaduzenja'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the zaduzenja';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _createOrUpdateVrstaOsoblja();
//                   }
//                 },
//                 child: Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _createOrUpdateVrstaOsoblja() async {
//     final requestBody = jsonEncode({
//       'pozicija': _pozicijaController.text,
//       'zaduzenja': _zaduzenjaController.text,
//     });

//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);

//     try {
//       if (widget.vrstaOsoblja == null) {
//         // Creating new entry (POST request)
//         final url = Uri.parse("${BaseProvider.baseUrl}/VrstaOsoblja");
//         await http.post(url, body: requestBody, headers: {"Content-Type": "application/json"});
//       } else {
//         // Updating existing entry (PUT request)
//         final url = Uri.parse("${BaseProvider.baseUrl}/VrstaOsoblja/${widget.vrstaOsoblja['id']}");
//         await http.put(url, body: requestBody, headers: {"Content-Type": "application/json"});
//       }
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const VrstaOsobljaListScreen()));
//     } catch (error) {
//       print(error); // Handle error
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsiidesktop/providers/drzava_provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewVrstaOsobljaScreen extends StatefulWidget {
  final dynamic vrstaOsoblja; // For edit functionality

  const NewVrstaOsobljaScreen({Key? key, this.vrstaOsoblja}) : super(key: key);

  @override
  _NewVrstaOsobljaScreenState createState() => _NewVrstaOsobljaScreenState();
}

class _NewVrstaOsobljaScreenState extends State<NewVrstaOsobljaScreen> {
  final TextEditingController _pozicijaController = TextEditingController();
  final TextEditingController _zaduzenjaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.vrstaOsoblja != null) {
      _pozicijaController.text = widget.vrstaOsoblja['pozicija'] ?? '';
      _zaduzenjaController.text = widget.vrstaOsoblja['zaduzenja'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.vrstaOsoblja == null
          ? 'Create New Vrsta Osoblja'
          : 'Update Vrsta Osoblja',
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
                    widget.vrstaOsoblja == null
                        ? 'Enter New Vrsta Osoblja'
                        : 'Update Vrsta Osoblja',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _pozicijaController,
                    labelText: 'Pozicija',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pozicija';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _zaduzenjaController,
                    labelText: 'Zaduzenje',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter zaduzenje';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        widget.vrstaOsoblja == null
                            ? 'Create Vrsta Osoblja'
                            : 'Update Vrsta Osoblja',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
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
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      validator: validator,
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.vrstaOsoblja == null) {
        _createVrstaOsoblja();
      } else {
        _updateVrstaOsoblja(widget.vrstaOsoblja!['id']);
      }
    }
  }

  void _createVrstaOsoblja() {
    final requestBody = jsonEncode({
      'pozicija': _pozicijaController.text,
      'zaduzenja': _zaduzenjaController.text
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/VrstaOsoblja", 'POST');
  }

  void _updateVrstaOsoblja(int id) {
    final requestBody = jsonEncode({
      'pozicija': _pozicijaController.text,
      'zaduzenja': _zaduzenjaController.text
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/VrstaOsoblja/$id", 'PUT');
  }

  void _submitData(String requestBody, String url, String method) {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final uri = Uri.parse(url);

    final Future response = method == 'POST'
        ? http.post(uri,
            body: requestBody, headers: {'Content-Type': 'application/json'})
        : http.put(uri,
            body: requestBody, headers: {'Content-Type': 'application/json'});

    response.then((res) {
      if (res.statusCode == 200) {
        showCustomSnackBar(
          context,
          method == 'POST'
              ? 'Vrsta Osoblja successfully created.'
              : 'Vrsta Osoblja successfully updated.',
          Colors.green,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const VrstaOsobljaListScreen()));
      } else {
        _showErrorSnackBar();
      }
    }).catchError((_) => _showErrorSnackBar());
  }

  void showCustomSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top:
            20, // Adjust this value to position the toast at the desired height
        left: MediaQuery.of(context).size.width * 0.20, // Center horizontally
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
                  size: 24, // Icon size
                ),
                const SizedBox(width: 8), // Space between icon and text
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
    // Remove the toast after a duration
    Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
  }

  void _showErrorSnackBar() {
    showErrorToast(context, 'Error occurred. Please try again later.');
  }

  void showErrorToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20, // Position the toast at the top
        left: MediaQuery.of(context).size.width *
            0.15, // Center horizontally with reduced width
        width: MediaQuery.of(context).size.width * 0.7, // Reduced width
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.red, // Red background for the error
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.error,
                    color: Colors.white), // Error icon on the left
                const SizedBox(width: 10), // Space between the icon and the text
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

    // Automatically remove the toast after a duration
    Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
  }
}
