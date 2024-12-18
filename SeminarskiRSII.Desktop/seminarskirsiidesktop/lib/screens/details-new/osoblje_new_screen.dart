// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
// import 'package:seminarskirsiidesktop/screens/lists/osoblje_list_screen.dart';

// import '../../providers/base_provider.dart';

// class NewOsobljeScreen extends StatefulWidget {
//   final dynamic osoblje;

//   const NewOsobljeScreen({Key? key, this.osoblje}) : super(key: key);

//   @override
//   _NewOsobljeScreenState createState() => _NewOsobljeScreenState();
// }

// class _NewOsobljeScreenState extends State<NewOsobljeScreen> {
//   late OsobljeProvider _osobljeProvider;

//   final _formKey = GlobalKey<FormState>();

//   TextEditingController _imeController = TextEditingController();
//   TextEditingController _prezimeController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _korisnickoImeController = TextEditingController();
//   TextEditingController _telefonController = TextEditingController();

//   Uint8List? _slikaBytes;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _osobljeProvider = context.read<OsobljeProvider>();

//     if (widget.osoblje != null) {
//       _imeController.text = widget.osoblje['ime'] ?? '';
//       _prezimeController.text = widget.osoblje['prezime'] ?? '';
//       _emailController.text = widget.osoblje['email'] ?? '';
//       _korisnickoImeController.text = widget.osoblje['korisnickoIme'] ?? '';
//       _telefonController.text = widget.osoblje['telefon'] ?? '';
//       if (widget.osoblje['slika'] != null) {
//         _slikaBytes = base64Decode(widget.osoblje['slika']);
//       }
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       setState(() {
//         _slikaBytes = bytes;
//       });
//     }
//   }

//   Future<void> _createEmployee() async {
//     final request = {
//       "ime": _imeController.text,
//       "prezime": _prezimeController.text,
//       "email": _emailController.text,
//       "korisnickoIme": _korisnickoImeController.text,
//       "telefon": _telefonController.text,
//       "slika": _slikaBytes != null ? base64Encode(_slikaBytes!) : null,
//     };

//   try {
//     final requestBody = jsonEncode(request);
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Osoblje"); // Adjust the URL

//     await http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Osoblje successfully created.'),
//           behavior: SnackBarBehavior.floating,
//         ));
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const OsobljeListScreen()));
//       } else {
//         // Handle error
//         print("Error creating Osoblje: ${response.body}");
//       }
//     }).catchError((error) {
//       print("Error: $error");
//     });
//   } catch (e) {
//     print("Error: $e");
//   }
// }

// Future<void> _updateEmployee(int id) async {
//       final request = {
//       "ime": _imeController.text,
//       "prezime": _prezimeController.text,
//       "email": _emailController.text,
//       "korisnickoIme": _korisnickoImeController.text,
//       "telefon": _telefonController.text,
//       "slika": _slikaBytes != null ? base64Encode(_slikaBytes!) : null,
//     };
//   try {
//     final requestBody = jsonEncode(request);
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Osoblje/$id"); // Adjust the URL

//     await http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Osoblje successfully updated.'),
//           behavior: SnackBarBehavior.floating,
//         ));
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const OsobljeListScreen()));
//       } else {
//         // Handle error
//         print("Error updating Osoblje: ${response.body}");
//       }
//     }).catchError((error) {
//       print("Error: $error");
//     });
//   } catch (e) {
//     print("Error: $e");
//   }
// }

//   @override
//   void dispose() {
//     _imeController.dispose();
//     _prezimeController.dispose();
//     _emailController.dispose();
//     _korisnickoImeController.dispose();
//     _telefonController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.osoblje == null ? 'Add New Osoblje' : 'Edit Osoblje'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _imeController,
//                 decoration: InputDecoration(labelText: 'Ime'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Ime is required';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _prezimeController,
//                 decoration: InputDecoration(labelText: 'Prezime'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Prezime is required';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Email is required';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _korisnickoImeController,
//                 decoration: InputDecoration(labelText: 'Korisničko ime'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Korisničko ime is required';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _telefonController,
//                 decoration: InputDecoration(labelText: 'Telefon'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Telefon is required';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   _slikaBytes != null
//                       ? Image.memory(
//                           _slikaBytes!,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         )
//                       : Text("No Image Selected"),
//                   SizedBox(width: 16),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     child: Text('Pick Image'),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 40),
//                  ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     if (widget.osoblje == null) {
//                       _createEmployee();
//                     } else {
//                       _updateEmployee(widget.osoblje['id']);
//                     }
//                   }
//                 },
//                 child: Text(widget.osoblje == null ? 'Dodaj' : 'Izmijeni'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
// import 'package:seminarskirsiidesktop/screens/lists/osoblje_list_screen.dart';

// import '../../providers/base_provider.dart';

// class NewOsobljeScreen extends StatefulWidget {
//   final dynamic osoblje;

//   const NewOsobljeScreen({Key? key, this.osoblje}) : super(key: key);

//   @override
//   _NewOsobljeScreenState createState() => _NewOsobljeScreenState();
// }

// class _NewOsobljeScreenState extends State<NewOsobljeScreen> {
//   late OsobljeProvider _osobljeProvider;

//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _imeController = TextEditingController();
//   final TextEditingController _prezimeController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _korisnickoImeController = TextEditingController();
//   final TextEditingController _telefonController = TextEditingController();

//   Uint8List? _slikaBytes;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _osobljeProvider = context.read<OsobljeProvider>();

//     if (widget.osoblje != null) {
//       _imeController.text = widget.osoblje['ime'] ?? '';
//       _prezimeController.text = widget.osoblje['prezime'] ?? '';
//       _emailController.text = widget.osoblje['email'] ?? '';
//       _korisnickoImeController.text = widget.osoblje['korisnickoIme'] ?? '';
//       _telefonController.text = widget.osoblje['telefon'] ?? '';
//       if (widget.osoblje['slika'] != null) {
//         _slikaBytes = base64Decode(widget.osoblje['slika']);
//       }
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       setState(() {
//         _slikaBytes = bytes;
//       });
//     }
//   }

//   Future<void> _createEmployee() async {
//     final request = {
//       "ime": _imeController.text,
//       "prezime": _prezimeController.text,
//       "email": _emailController.text,
//       "korisnickoIme": _korisnickoImeController.text,
//       "telefon": _telefonController.text,
//       "slika": _slikaBytes != null ? base64Encode(_slikaBytes!) : null,
//     };

//     try {
//       final requestBody = jsonEncode(request);
//       final ioc = HttpClient();
//       ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//       final http = IOClient(ioc);
//       final url = Uri.parse("${BaseProvider.baseUrl}/Osoblje"); // Adjust the URL

//       await http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text('Osoblje successfully created.'),
//             behavior: SnackBarBehavior.floating,
//           ));
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const OsobljeListScreen()));
//         } else {
//           print("Error creating Osoblje: ${response.body}");
//         }
//       }).catchError((error) {
//         print("Error: $error");
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   Future<void> _updateEmployee(int id) async {
//     final request = {
//       "ime": _imeController.text,
//       "prezime": _prezimeController.text,
//       "email": _emailController.text,
//       "korisnickoIme": _korisnickoImeController.text,
//       "telefon": _telefonController.text,
//       "slika": _slikaBytes != null ? base64Encode(_slikaBytes!) : null,
//     };
//     try {
//       final requestBody = jsonEncode(request);
//       final ioc = HttpClient();
//       ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//       final http = IOClient(ioc);
//       final url = Uri.parse("${BaseProvider.baseUrl}/Osoblje/$id"); // Adjust the URL

//       await http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text('Osoblje successfully updated.'),
//             behavior: SnackBarBehavior.floating,
//           ));
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const OsobljeListScreen()));
//         } else {
//           print("Error updating Osoblje: ${response.body}");
//         }
//       }).catchError((error) {
//         print("Error: $error");
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _imeController.dispose();
//     _prezimeController.dispose();
//     _emailController.dispose();
//     _korisnickoImeController.dispose();
//     _telefonController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.osoblje == null ? 'Add New Osoblje' : 'Edit Osoblje'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Container(
//           width: 600,
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//               ),
//             ],
//           ),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 TextFormField(
//                   controller: _imeController,
//                   decoration: const InputDecoration(labelText: 'Ime', border: OutlineInputBorder()),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Ime is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _prezimeController,
//                   decoration: const InputDecoration(labelText: 'Prezime', border: OutlineInputBorder()),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Prezime is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Email is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _korisnickoImeController,
//                   decoration: const InputDecoration(labelText: 'Korisničko ime', border: OutlineInputBorder()),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Korisničko ime is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _telefonController,
//                   decoration: const InputDecoration(labelText: 'Telefon', border: OutlineInputBorder()),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Telefon is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     _slikaBytes != null
//                         ? Image.memory(
//                             _slikaBytes!,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           )
//                         : const Text("No Image Selected"),
//                     const SizedBox(width: 16),
//                     ElevatedButton(
//                       onPressed: _pickImage,
//                       child: const Text('Pick Image'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         _formKey.currentState!.save();
//                         if (widget.osoblje == null) {
//                           _createEmployee();
//                         } else {
//                           _updateEmployee(widget.osoblje['id']);
//                         }
//                       }
//                     },
//                     child: Text(widget.osoblje == null ? 'Dodaj' : 'Izmijeni'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/screens/lists/osoblje_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewOsobljeScreen extends StatefulWidget {
  final Map<String, dynamic>? osoblje;

  const NewOsobljeScreen({Key? key, this.osoblje}) : super(key: key);

  @override
  _NewOsobljeScreenState createState() => _NewOsobljeScreenState();
}

class _NewOsobljeScreenState extends State<NewOsobljeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _korisnickoImeController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  Uint8List? _slikaBytes;

  @override
  void initState() {
    super.initState();

    // Prefill data if updating
    if (widget.osoblje != null) {
      _imeController.text = widget.osoblje!['ime'] ?? '';
      _prezimeController.text = widget.osoblje!['prezime'] ?? '';
      _emailController.text = widget.osoblje!['email'] ?? '';
      _korisnickoImeController.text = widget.osoblje!['korisnickoIme'] ?? '';
      _telefonController.text = widget.osoblje!['telefon'] ?? '';
      if (widget.osoblje!['slika'] != null) {
        _slikaBytes = base64Decode(widget.osoblje!['slika']);
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _slikaBytes = File(pickedFile.path).readAsBytesSync();
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final request = {
        "ime": _imeController.text,
        "prezime": _prezimeController.text,
        "email": _emailController.text,
        "korisnickoIme": _korisnickoImeController.text,
        "telefon": _telefonController.text,
        "slika": _slikaBytes != null ? base64Encode(_slikaBytes!) : null,
      };

      _submitData(jsonEncode(request));
    }
  }

  void _submitData(String requestBody) {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);

    final String method = widget.osoblje == null ? 'POST' : 'PUT';
    final String url = widget.osoblje == null
        ? "${BaseProvider.baseUrl}/Osoblje"
        : "${BaseProvider.baseUrl}/Osoblje/${widget.osoblje!['id']}";

    final uri = Uri.parse(url);

    final Future response = method == 'POST'
        ? http.post(uri, body: requestBody, headers: {'Content-Type': 'application/json'})
        : http.put(uri, body: requestBody, headers: {'Content-Type': 'application/json'});

    response.then((res) {
      if (res.statusCode == 200) {
        showCustomSnackBar(
          context,
          widget.osoblje == null
              ? 'Osoblje successfully created.'
              : 'Osoblje successfully updated.',
          Colors.green,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OsobljeListScreen()),
        );
      } else {
        _showErrorSnackBar();
      }
    }).catchError((_) => _showErrorSnackBar());
  }

void _showErrorSnackBar() {
  showErrorToast(context, 'Error occurred. Please try again later.');
}

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.osoblje == null ? 'Create New Osoblje' : 'Update Osoblje',
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 600,
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
                    widget.osoblje == null
                        ? 'Enter New Osoblje Details'
                        : 'Update Osoblje Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(_imeController, 'Ime'),
                  const SizedBox(height: 20),
                  _buildTextField(_prezimeController, 'Prezime'),
                  const SizedBox(height: 20),
                  _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  _buildTextField(_korisnickoImeController, 'Korisnicko Ime'),
                  const SizedBox(height: 20),
                  _buildTextField(_telefonController, 'Telefon', keyboardType: TextInputType.phone),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _slikaBytes != null
                        ? Image.memory(
                            _slikaBytes!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : const Text("No Image Selected"),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Image'),
                    ),
                  ],
                ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        widget.osoblje == null ? 'Create Osoblje' : 'Update Osoblje',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildTextField(
    TextEditingController controller,
    String labelText, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.blue[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty ? 'Please enter $labelText' : null,
    );
  }
}

void showErrorToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 20, // Position the toast at the top
      left: MediaQuery.of(context).size.width * 0.15, // Center horizontally with reduced width
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
              const Icon(Icons.error, color: Colors.white), // Error icon on the left
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

void showCustomSnackBar(BuildContext context, String message, Color backgroundColor) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 20, // Adjust this value to position the toast at the desired height
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
