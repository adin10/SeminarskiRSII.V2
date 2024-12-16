// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
// import '../../providers/base_provider.dart';

// class NewDrzavaScreen extends StatefulWidget {
//   final dynamic drzava;

//   NewDrzavaScreen({Key? key, this.drzava}) : super(key: key);

//   @override
//   _NewDrzavaScreenState createState() => _NewDrzavaScreenState();
// }

// class _NewDrzavaScreenState extends State<NewDrzavaScreen> {
//   TextEditingController _nazivController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   late String naziv;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.drzava != null) {
//       _nazivController.text = widget.drzava['naziv'] ?? '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.drzava == null ? 'Create New Drzava' : 'Update Drzava',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//              width: 550,  // Set a fixed width for the form container
//             padding: const EdgeInsets.all(24.0),  // Add padding around the form
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                   offset: Offset(0, 5),  // Shadow for a floating effect
//                 ),
//               ],
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.drzava == null ? 'Enter New Drzava Details' : 'Update Drzava Details',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey[700],
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _nazivController,
//                     decoration: InputDecoration(
//                       labelText: 'Naziv Drzave',
//                       labelStyle: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blueAccent, width: 2),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       filled: true,
//                       fillColor: Colors.blue[50],
//                       contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter the name of the Drzava';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       naziv = value!;
//                     },
//                   ),
//                   SizedBox(height: 30),
//                   Center(  // Center the button within the form
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();
//                           if (widget.drzava == null) {
//                             _createDrzava();
//                           } else {
//                             _updateDrzava(widget.drzava['id']);
//                           }
//                         }
//                       },
//                       child: Text(
//                         widget.drzava == null ? 'Create Drzava' : 'Update Drzava',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.blueAccent,
//                         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _createDrzava() {
//     final request = DrzavaInsertRequest(naziv: naziv);
//     final requestBody = jsonEncode(request.toJson());
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Drzava");

//     http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Drzava successfully created.'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => const DrzavaListScreen()));
//       } else {
//         _showErrorSnackBar();
//       }
//     }).catchError((error) {
//       _showErrorSnackBar();
//     });
//   }

//   void _updateDrzava(int id) {
//     final request = DrzavaInsertRequest(naziv: naziv);
//     final requestBody = jsonEncode(request.toJson());
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Drzava/$id");

//     http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Drzava successfully updated.'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => const DrzavaListScreen()));
//       } else {
//         _showErrorSnackBar();
//       }
//     }).catchError((error) {
//       _showErrorSnackBar();
//     });
//   }

//   void _showErrorSnackBar() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Something went wrong. Please try again.'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nazivController.dispose();
//     super.dispose();
//   }
// }

// class DrzavaInsertRequest {
//   final String naziv;

//   DrzavaInsertRequest({required this.naziv});

//   Map<String, dynamic> toJson() {
//     return {'naziv': naziv};
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
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewDrzavaScreen extends StatefulWidget {
  final dynamic drzava;
  NewDrzavaScreen({Key? key, this.drzava}) : super(key: key);

  @override
  _NewDrzavaScreenState createState() => _NewDrzavaScreenState();
}

class _NewDrzavaScreenState extends State<NewDrzavaScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nazivController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.drzava != null) {
      _nazivController.text = widget.drzava['naziv'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.drzava == null ? 'Create New Country' : 'Update Country',
      child: Center(
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
                    widget.drzava == null
                        ? 'Enter New Country Details'
                        : 'Update Country Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _nazivController,
                    labelText: 'Naziv Drzave',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a country name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      child: Text(
                        widget.drzava == null
                            ? 'Create Country'
                            : 'Update Country',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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
            TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
      validator: validator,
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.drzava == null) {
        _createCountry();
      } else {
        _updateCountry(widget.drzava!['id']);
      }
    }
  }

  void _createCountry() {
    final requestBody = jsonEncode({'naziv': _nazivController.text});
    _submitData(requestBody, "${BaseProvider.baseUrl}/Drzava", 'POST');
  }

  void _updateCountry(int id) {
    final requestBody = jsonEncode({'naziv': _nazivController.text});
    _submitData(requestBody, "${BaseProvider.baseUrl}/Drzava/$id", 'PUT');
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
              ? 'Drzava successfully created.'
              : 'Drzava successfully updated.',
          Colors.green,
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DrzavaListScreen()));
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
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 24, // Icon size
                ),
                SizedBox(width: 8), // Space between icon and text
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
    Future.delayed(Duration(seconds: 3)).then((_) => overlayEntry.remove());
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
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.red, // Red background for the error
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.error,
                    color: Colors.white), // Error icon on the left
                SizedBox(width: 10), // Space between the icon and the text
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
    Future.delayed(Duration(seconds: 3)).then((_) => overlayEntry.remove());
  }
}
