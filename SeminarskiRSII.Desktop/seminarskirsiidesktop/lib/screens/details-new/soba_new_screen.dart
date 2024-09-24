// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/soba_list_screen.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../providers/base_provider.dart';

// class NewSobaScreen extends StatefulWidget {
//   const NewSobaScreen({Key? key}) : super(key: key);

//   @override
//   _NewSobaScreenState createState() => _NewSobaScreenState();
// }

// class _NewSobaScreenState extends State<NewSobaScreen> {
//   TextEditingController _brojSobe = TextEditingController();
//   TextEditingController _brojSprata = TextEditingController();
//   TextEditingController _opisSobe = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   late int brojSobe;
//   late int brojSprata;
//   late String opisSobe;
//   late String slika;
//   late int sobaStatusId;
//   File? _selectedImage;
//   List<dynamic> statusiSoba = []; // List to hold countries

//   @override
//   void initState() {
//     super.initState();
//     _fetchSobaStatus();
//   }

//   Future<void> _fetchSobaStatus() async {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus"); // Replace with your endpoint

//     try {
//       final response = await http.get(url, headers: {'Content-Type': 'application/json'});
//       if (response.statusCode == 200) {
//         setState(() {
//           statusiSoba = json.decode(response.body);
//         });
//       } else {
//         // Handle error
//       }
//     } catch (error) {
//       // Handle error
//     }
//   }

//    Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dodaj Novu Sobu'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _brojSprata,
//                 decoration: InputDecoration(labelText: 'Broj Sprata'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter sprat number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   brojSprata = int.parse(value!);
//                 },
//               ),
//               TextFormField(
//                 controller: _brojSobe,
//                 decoration: InputDecoration(labelText: 'Broj Sobe'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Room Number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   brojSobe = int.parse(value!);
//                 },
//               ),
//               TextFormField(
//                 controller: _opisSobe,
//                 decoration: InputDecoration(labelText: 'Opis Sobe'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Room Description';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   opisSobe = value!;
//                 },
//               ),
//               DropdownButtonFormField<int>(
//                 decoration: InputDecoration(labelText: 'Statusi'),
//                 items: statusiSoba.map<DropdownMenuItem<int>>((status) {
//                   return DropdownMenuItem<int>(
//                     value: status['id'],
//                     child: Text(status['status']),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     sobaStatusId = value!;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select Status';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   color: Colors.grey[200],
//                   height: 200,
//                   width: double.infinity,
//                   child: _selectedImage == null
//                       ? Icon(Icons.add_a_photo, size: 100, color: Colors.grey[700])
//                       : Image.file(_selectedImage!, fit: BoxFit.cover),
//                 ),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Call your method to create Drzava here
//                     _createSoba();
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

//   void _createSoba() {
//     // Implement your logic to create Grad here
//     final request = SobaInsertRequest(
//       brojSobe: brojSobe,
//       brojSprata: brojSobe,
//       opisSobe: opisSobe,
//       slika: _selectedImage != null ? base64Encode(_selectedImage!.readAsBytesSync()) : '',
//       sobaStatusId: sobaStatusId,
//     );

//     // Pretvorite objekt request u JSON string
//     final requestBody = jsonEncode(request.toJson());

//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     // Izvršite HTTP POST zahtjev na server
//     final url = Uri.parse("${BaseProvider.baseUrl}/Soba");
//     http.post(url,
//         body: requestBody,
//         headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Soba uspješno Dodata.'),
//             behavior: SnackBarBehavior.floating, // Display at the top
//           ),
//         );
//         // Uspješno poslan zahtjev
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const SobaListScreen()),
//         );
//       } else {
//         // Pogreška pri slanju zahtjeva
//         // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
//       }
//     }).catchError((error) {
//       // Pogreška prilikom izvršavanja HTTP zahtjeva
//       // Ovdje možete dodati odgovarajući postupak za prikaz pogreške
//     });
//   }

//   @override
//   void dispose() {
//     _brojSprata.dispose();
//     _brojSobe.dispose();
//     _opisSobe.dispose();
//     super.dispose();
//   }
// }

// class SobaInsertRequest {
//   final int brojSprata;
//   final int brojSobe;
//   final String opisSobe;
//   final String slika;
//   final int sobaStatusId;

//   SobaInsertRequest({
//     required this.brojSprata,
//     required this.brojSobe,
//     required this.opisSobe,
//     required this.slika,
//     required this.sobaStatusId,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'brojSprata': brojSprata,
//       'brojSobe': brojSobe,
//       'opisSobe': opisSobe,
//       'slika': slika,
//       'sobaStatusId': sobaStatusId
//     };
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../providers/base_provider.dart';

// class NewSobaScreen extends StatefulWidget {
//   final dynamic soba; // If passed, this will be the existing Soba to edit

//   const NewSobaScreen({Key? key, this.soba}) : super(key: key);

//   @override
//   _NewSobaScreenState createState() => _NewSobaScreenState();
// }

// class _NewSobaScreenState extends State<NewSobaScreen> {
//   TextEditingController _brojSobeController = TextEditingController();
//   TextEditingController _brojSprataController = TextEditingController();
//   TextEditingController _opisSobeController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   File? _selectedImage;
//   late int sobaStatusId;
//   List<dynamic> statusiSoba = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchSobaStatus();
//     if (widget.soba != null) {
//       _initializeFields();
//     }
//   }

//   void _initializeFields() {
//     _brojSobeController.text = widget.soba['brojSobe'].toString();
//     _brojSprataController.text = widget.soba['brojSprata'].toString();
//     _opisSobeController.text = widget.soba['opisSobe'];
//     sobaStatusId = widget.soba['sobaStatus']['id'];
//   }

//   Future<void> _fetchSobaStatus() async {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus");

//     try {
//       final response = await http.get(url, headers: {'Content-Type': 'application/json'});
//       if (response.statusCode == 200) {
//         setState(() {
//           statusiSoba = json.decode(response.body);
//         });
//       } else {
//         // Handle error
//       }
//     } catch (error) {
//       // Handle error
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.soba == null ? 'Dodaj Novu Sobu' : 'Uredi Sobu'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _brojSprataController,
//                 decoration: InputDecoration(labelText: 'Broj Sprata'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite broj sprata';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _brojSobeController,
//                 decoration: InputDecoration(labelText: 'Broj Sobe'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite broj sobe';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _opisSobeController,
//                 decoration: InputDecoration(labelText: 'Opis Sobe'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Unesite opis sobe';
//                   }
//                   return null;
//                 },
//               ),
//               DropdownButtonFormField<int>(
//                 decoration: InputDecoration(labelText: 'Status Sobe'),
//                 value: sobaStatusId,
//                 items: statusiSoba.map<DropdownMenuItem<int>>((status) {
//                   return DropdownMenuItem<int>(
//                     value: status['id'],
//                     child: Text(status['status']),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     sobaStatusId = value!;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Odaberite status sobe';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   color: Colors.grey[200],
//                   height: 200,
//                   width: double.infinity,
//                   child: _selectedImage == null
//                       ? (widget.soba != null && widget.soba['slika'] != null
//                           ? Image.memory(
//                               base64Decode(widget.soba['slika']),
//                               fit: BoxFit.cover,
//                             )
//                           : Icon(Icons.add_a_photo, size: 100, color: Colors.grey[700]))
//                       : Image.file(_selectedImage!, fit: BoxFit.cover),
//                 ),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     widget.soba == null ? _createSoba() : _updateSoba();
//                   }
//                 },
//                 child: Text(widget.soba == null ? 'Spremi' : 'Ažuriraj'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _createSoba() async {
//     final request = {
//       "brojSobe": int.parse(_brojSobeController.text),
//       "brojSprata": int.parse(_brojSprataController.text),
//       "opisSobe": _opisSobeController.text,
//       "slika": _selectedImage != null ? base64Encode(_selectedImage!.readAsBytesSync()) : '',
//       "sobaStatusId": sobaStatusId,
//     };

//     final requestBody = jsonEncode(request);
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Soba");
    
//     final response = await http.post(
//       url,
//       body: requestBody,
//       headers: {'Content-Type': 'application/json'},
//     );
//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Soba uspješno dodana!')),
//       );
//       Navigator.of(context).pop(); // Return to the previous screen
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Greška prilikom dodavanja sobe!')),
//       );
//     }
//   }

//   void _updateSoba() async {
//     final request = {
//       "brojSobe": int.parse(_brojSobeController.text),
//       "brojSprata": int.parse(_brojSprataController.text),
//       "opisSobe": _opisSobeController.text,
//       "slika": _selectedImage != null ? base64Encode(_selectedImage!.readAsBytesSync()) : widget.soba['slika'],
//       "sobaStatusId": sobaStatusId,
//     };

//     final requestBody = jsonEncode(request);
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Soba/${widget.soba['id']}");
    
//     final response = await http.put(
//       url,
//       body: requestBody,
//       headers: {'Content-Type': 'application/json'},
//     );
//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Soba uspješno ažurirana!')),
//       );
//       Navigator.of(context).pop(); // Return to the previous screen
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Greška prilikom ažuriranja sobe!')),
//       );
//     }
//   }
// }



import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seminarskirsiidesktop/screens/lists/soba_list_screen.dart';
import '../../providers/base_provider.dart';

class NewSobaScreen extends StatefulWidget {
  final dynamic soba; // If passed, this will be the existing Soba to edit

  const NewSobaScreen({Key? key, this.soba}) : super(key: key);

  @override
  _NewSobaScreenState createState() => _NewSobaScreenState();
}

class _NewSobaScreenState extends State<NewSobaScreen> {
  TextEditingController _brojSobeController = TextEditingController();
  TextEditingController _brojSprataController = TextEditingController();
  TextEditingController _opisSobeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  int? sobaStatusId; // Initialize as nullable
  List<dynamic> statusiSoba = [];

  @override
  void initState() {
    super.initState();
    _fetchSobaStatus();
    if (widget.soba != null) {
      _initializeFields();
    }
  }

  void _initializeFields() {
    _brojSobeController.text = widget.soba['brojSobe'].toString();
    _brojSprataController.text = widget.soba['brojSprata'].toString();
    _opisSobeController.text = widget.soba['opisSobe'];
    sobaStatusId = widget.soba['sobaStatus']['id'];
  }

  Future<void> _fetchSobaStatus() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus");

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        setState(() {
          statusiSoba = json.decode(response.body);
          if (widget.soba == null && statusiSoba.isNotEmpty) {
            // Set a default value if creating a new Soba
            sobaStatusId = statusiSoba.first['id'];
          }
        });
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.soba == null ? 'Dodaj Novu Sobu' : 'Uredi Sobu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _brojSprataController,
                decoration: InputDecoration(labelText: 'Broj Sprata'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite broj sprata';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _brojSobeController,
                decoration: InputDecoration(labelText: 'Broj Sobe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite broj sobe';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _opisSobeController,
                decoration: InputDecoration(labelText: 'Opis Sobe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite opis sobe';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Status Sobe'),
                value: sobaStatusId, // Use nullable value here
                items: statusiSoba.map<DropdownMenuItem<int>>((status) {
                  return DropdownMenuItem<int>(
                    value: status['id'],
                    child: Text(status['status']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    sobaStatusId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Odaberite status sobe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  color: Colors.grey[200],
                  height: 200,
                  width: double.infinity,
                  child: _selectedImage == null
                      ? (widget.soba != null && widget.soba['slika'] != null
                          ? Image.memory(
                              base64Decode(widget.soba['slika']),
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.add_a_photo, size: 100, color: Colors.grey[700]))
                      : Image.file(_selectedImage!, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.soba == null ? _createSoba() : _updateSoba();
                  }
                },
                child: Text(widget.soba == null ? 'Spremi' : 'Ažuriraj'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createSoba() async {
    final request = {
      "brojSobe": int.parse(_brojSobeController.text),
      "brojSprata": int.parse(_brojSprataController.text),
      "opisSobe": _opisSobeController.text,
      "slika": _selectedImage != null ? base64Encode(_selectedImage!.readAsBytesSync()) : '',
      "sobaStatusId": sobaStatusId, // Ensure sobaStatusId is passed
    };

    final requestBody = jsonEncode(request);
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Soba");
    
    final response = await http.post(
      url,
      body: requestBody,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Soba uspješno dodana!')),
      );
       Navigator.push(context, MaterialPageRoute(builder: (context) => const SobaListScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Greška prilikom dodavanja sobe!')),
      );
    }
  }

  void _updateSoba() async {
    final request = {
      "brojSobe": int.parse(_brojSobeController.text),
      "brojSprata": int.parse(_brojSprataController.text),
      "opisSobe": _opisSobeController.text,
      "slika": _selectedImage != null ? base64Encode(_selectedImage!.readAsBytesSync()) : widget.soba['slika'],
      "sobaStatusId": sobaStatusId, // Ensure sobaStatusId is passed
    };

    final requestBody = jsonEncode(request);
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Soba/${widget.soba['id']}");
    
    final response = await http.put(
      url,
      body: requestBody,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Soba uspješno ažurirana!')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SobaListScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Greška prilikom ažuriranja sobe!')),
      );
    }
  }
}