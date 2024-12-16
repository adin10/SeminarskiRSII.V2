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

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/osoblje_list_screen.dart';

import '../../providers/base_provider.dart';

class NewOsobljeScreen extends StatefulWidget {
  final dynamic osoblje;

  const NewOsobljeScreen({Key? key, this.osoblje}) : super(key: key);

  @override
  _NewOsobljeScreenState createState() => _NewOsobljeScreenState();
}

class _NewOsobljeScreenState extends State<NewOsobljeScreen> {
  late OsobljeProvider _osobljeProvider;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _korisnickoImeController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();

  Uint8List? _slikaBytes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _osobljeProvider = context.read<OsobljeProvider>();

    if (widget.osoblje != null) {
      _imeController.text = widget.osoblje['ime'] ?? '';
      _prezimeController.text = widget.osoblje['prezime'] ?? '';
      _emailController.text = widget.osoblje['email'] ?? '';
      _korisnickoImeController.text = widget.osoblje['korisnickoIme'] ?? '';
      _telefonController.text = widget.osoblje['telefon'] ?? '';
      if (widget.osoblje['slika'] != null) {
        _slikaBytes = base64Decode(widget.osoblje['slika']);
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _slikaBytes = bytes;
      });
    }
  }

  Future<void> _createEmployee() async {
    final request = {
      "ime": _imeController.text,
      "prezime": _prezimeController.text,
      "email": _emailController.text,
      "korisnickoIme": _korisnickoImeController.text,
      "telefon": _telefonController.text,
      "slika": _slikaBytes != null ? base64Encode(_slikaBytes!) : null,
    };

    try {
      final requestBody = jsonEncode(request);
      final ioc = HttpClient();
      ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);
      final url = Uri.parse("${BaseProvider.baseUrl}/Osoblje"); // Adjust the URL

      await http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Osoblje successfully created.'),
            behavior: SnackBarBehavior.floating,
          ));
          Navigator.push(context, MaterialPageRoute(builder: (context) => const OsobljeListScreen()));
        } else {
          print("Error creating Osoblje: ${response.body}");
        }
      }).catchError((error) {
        print("Error: $error");
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _updateEmployee(int id) async {
    final request = {
      "ime": _imeController.text,
      "prezime": _prezimeController.text,
      "email": _emailController.text,
      "korisnickoIme": _korisnickoImeController.text,
      "telefon": _telefonController.text,
      "slika": _slikaBytes != null ? base64Encode(_slikaBytes!) : null,
    };
    try {
      final requestBody = jsonEncode(request);
      final ioc = HttpClient();
      ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);
      final url = Uri.parse("${BaseProvider.baseUrl}/Osoblje/$id"); // Adjust the URL

      await http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Osoblje successfully updated.'),
            behavior: SnackBarBehavior.floating,
          ));
          Navigator.push(context, MaterialPageRoute(builder: (context) => const OsobljeListScreen()));
        } else {
          print("Error updating Osoblje: ${response.body}");
        }
      }).catchError((error) {
        print("Error: $error");
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    _imeController.dispose();
    _prezimeController.dispose();
    _emailController.dispose();
    _korisnickoImeController.dispose();
    _telefonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.osoblje == null ? 'Add New Osoblje' : 'Edit Osoblje'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: _imeController,
                  decoration: InputDecoration(labelText: 'Ime', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ime is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _prezimeController,
                  decoration: InputDecoration(labelText: 'Prezime', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Prezime is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _korisnickoImeController,
                  decoration: InputDecoration(labelText: 'Korisničko ime', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Korisničko ime is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefonController,
                  decoration: InputDecoration(labelText: 'Telefon', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Telefon is required';
                    }
                    return null;
                  },
                ),
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
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (widget.osoblje == null) {
                          _createEmployee();
                        } else {
                          _updateEmployee(widget.osoblje['id']);
                        }
                      }
                    },
                    child: Text(widget.osoblje == null ? 'Dodaj' : 'Izmijeni'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
