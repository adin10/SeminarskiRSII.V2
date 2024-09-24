// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:seminarskirsiidesktop/screens/lists/novosti_list_screen.dart';
// import '../../providers/base_provider.dart';

// class NewNovostScreen extends StatefulWidget {
//   const NewNovostScreen({Key? key}) : super(key: key);

//   @override
//   _NewNovostScreenState createState() => _NewNovostScreenState();
// }

// class _NewNovostScreenState extends State<NewNovostScreen> {
//   TextEditingController _naslovController = TextEditingController();
//   TextEditingController _sadrzajController = TextEditingController();
//   TextEditingController _datumController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   late String naslov;
//   late String sadrzaj;
//   late DateTime datumObjave;
//   late int osobljeId;
//   List<dynamic> osoblje = []; // List to hold countries

//   @override
//   void initState() {
//     super.initState();
//     _fetchOsoblje();
//   }

//   Future<void> _fetchOsoblje() async {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Osoblje"); // Replace with your endpoint

//     try {
//       final response = await http.get(url, headers: {'Content-Type': 'application/json'});
//       if (response.statusCode == 200) {
//         setState(() {
//           osoblje = json.decode(response.body);
//         });
//       } else {
//         // Handle error
//       }
//     } catch (error) {
//       // Handle error
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         datumObjave = picked;
//         _datumController.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dodaj Novu Obavijest'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _naslovController,
//                 decoration: InputDecoration(labelText: 'Naslov'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the title';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   naslov = value!;
//                 },
//               ),
//               TextFormField(
//                 controller: _sadrzajController,
//                 decoration: InputDecoration(labelText: 'Sadrzaj'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the text of news';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   sadrzaj = value!;
//                 },
//               ),
//               TextFormField(
//                 controller: _datumController,
//                 decoration: InputDecoration(labelText: 'Datum Objave'),
//                 readOnly: true,
//                 onTap: () {
//                   _selectDate(context);
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select the date';
//                   }
//                   return null;
//                 },
//               ),
//               DropdownButtonFormField<int>(
//                 decoration: InputDecoration(labelText: 'Autor'),
//                 items: osoblje.map<DropdownMenuItem<int>>((autor) {
//                   return DropdownMenuItem<int>(
//                     value: autor['id'],
//                     child: Text("${autor['ime']} ${autor['prezime']}"),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     osobljeId = value!;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select author';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Call your method to create Drzava here
//                     _createNews();
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

//   void _createNews() {
//     // Implement your logic to create Grad here
//     final request = NovostiInsertRequest(
//       naslov: naslov,
//       sadrzaj: sadrzaj,
//       datumObjave: datumObjave,
//       osobljeId: osobljeId
//     );

//     // Pretvorite objekt request u JSON string
//     final requestBody = jsonEncode(request.toJson());

//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     // Izvršite HTTP POST zahtjev na server
//     final url = Uri.parse("${BaseProvider.baseUrl}/Novosti");
//     http.post(url,
//         body: requestBody,
//         headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Novost uspješno Dodata.'),
//             behavior: SnackBarBehavior.floating, // Display at the top
//           ),
//         );
//         // Uspješno poslan zahtjev
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const NovostiListScreen()),
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
//     _naslovController.dispose();
//     _sadrzajController.dispose();
//      _datumController.dispose();
//     super.dispose();
//   }
// }

// class NovostiInsertRequest {
//   final String naslov;
//   final String sadrzaj;
//   final DateTime datumObjave;
//   final int osobljeId;

//   NovostiInsertRequest({
//     required this.naslov,
//     required this.sadrzaj,
//     required this.datumObjave,
//     required this.osobljeId,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'naslov': naslov,
//       'sadrzaj': sadrzaj,
//       'datumObjave': datumObjave.toIso8601String(),
//       'osobljeId': osobljeId
//     };
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:intl/intl.dart';
// import 'package:seminarskirsiidesktop/screens/lists/novosti_list_screen.dart';
// import '../../providers/base_provider.dart';
// import '../../providers/osoblje_provider.dart';

// class NewNovostScreen extends StatefulWidget {
//   final Map<String, dynamic>? novost;

//   const NewNovostScreen({Key? key, this.novost}) : super(key: key);

//   @override
//   _NewNovostScreenState createState() => _NewNovostScreenState();
// }

// class _NewNovostScreenState extends State<NewNovostScreen> {
//   TextEditingController _naslovController = TextEditingController();
//   TextEditingController _sadrzajController = TextEditingController();
//   TextEditingController _datumController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   late String naslov;
//   late String sadrzaj;
//   late DateTime datumObjave;
//   late int osobljeId;
//   List<dynamic> osoblje = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchOsoblje();

//     // If editing, populate the form with existing data
//     if (widget.novost != null) {
//       _naslovController.text = widget.novost!["naslov"] ?? "";
//       _sadrzajController.text = widget.novost!["sadrzaj"] ?? "";
//       if (widget.novost!["datumObjave"] != null) {
//         DateTime date = DateTime.parse(widget.novost!["datumObjave"]);
//         _datumController.text = DateFormat('dd-MM-yyyy').format(date);
//       }
//     }
//   }

//   Future<void> _fetchOsoblje() async {
//     var fetchedOsoblje = await OsobljeProvider().get(null);
//     setState(() {
//       osoblje = fetchedOsoblje;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.novost == null ? 'Create New Notification' : 'Edit Notification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _naslovController,
//                 decoration: InputDecoration(labelText: 'Naslov'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _sadrzajController,
//                 decoration: InputDecoration(labelText: 'Sadržaj'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter content';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _datumController,
//                 decoration: InputDecoration(labelText: 'Datum objave'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a date';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Save or update logic here
//                     if (widget.novost == null) {
//                       _saveNovost();
//                     } else {
//                       _updateNovost();
//                     }
//                   }
//                 },
//                 child: Text(widget.novost == null ? 'Save' : 'Update'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _saveNovost() async {
//     // Logic to save the new notification
//   }

//   Future<void> _updateNovost() async {
//     // Logic to update the existing notification
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/novosti_provider.dart';
import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/novosti_list_screen.dart';
import '../../providers/base_provider.dart';

class NewNovostScreen extends StatefulWidget {
  final Map<String, dynamic>? novost;

  const NewNovostScreen({Key? key, this.novost}) : super(key: key);

  @override
  _NewNovostScreenState createState() => _NewNovostScreenState();
}

class _NewNovostScreenState extends State<NewNovostScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _naslovController = TextEditingController();
  TextEditingController _sadrzajController = TextEditingController();
  TextEditingController _datumController = TextEditingController();

  DateTime? _selectedDate;
  int? _selectedAutorId;
  List<dynamic> _osobljeList = [];

  @override
  void initState() {
    super.initState();
    _fetchOsoblje();

    // If editing, prefill the form with existing data
    if (widget.novost != null) {
      _naslovController.text = widget.novost!['naslov'] ?? '';
      _sadrzajController.text = widget.novost!['sadrzaj'] ?? '';

      if (widget.novost!['datumObjave'] != null) {
        _selectedDate = DateTime.parse(widget.novost!['datumObjave']);
        _datumController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
      }

      _selectedAutorId = widget.novost!['osoblje']?['id'];
    }
  }

  Future<void> _fetchOsoblje() async {
    var fetchedOsoblje = await OsobljeProvider().get(null);
    setState(() {
      _osobljeList = fetchedOsoblje;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _datumController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.novost == null ? 'Create New Notification' : 'Edit Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _naslovController,
                decoration: InputDecoration(labelText: 'Naslov'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sadrzajController,
                decoration: InputDecoration(labelText: 'Sadržaj'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _datumController,
                    decoration: InputDecoration(labelText: 'Datum Objave'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              DropdownButtonFormField<int>(
                value: _selectedAutorId,
                decoration: InputDecoration(labelText: 'Autor'),
                items: _osobljeList.map<DropdownMenuItem<int>>((osoblje) {
                  return DropdownMenuItem<int>(
                    value: osoblje['id'],
                    child: Text('${osoblje['ime']} ${osoblje['prezime']}'),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedAutorId = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an author';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.novost == null) {
                      _saveNovost();
                    } else {
                      _updateNovost(widget.novost!['id']);
                    }
                  }
                },
                child: Text(widget.novost == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveNovost() async {
    // Logic to save the new notification
    final request = NovostiInsertRequest(
      naslov: _naslovController.text,
      sadrzaj: _sadrzajController.text,
      datumObjave: _selectedDate,
      osobljeId: _selectedAutorId,
    );

    final requestBody = jsonEncode(request.toJson());
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Novosti");

    http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Novost successfully created.'),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const NovostiListScreen()));
      } else {
        // Handle error
      }
    }).catchError((error) {
      // Handle error
    });
  }

  Future<void> _updateNovost(int id) async {
    // Logic to update the existing notification
    final request = NovostiInsertRequest(
      naslov: _naslovController.text,
      sadrzaj: _sadrzajController.text,
      datumObjave: _selectedDate,
      osobljeId: _selectedAutorId,
    );

  final requestBody = jsonEncode(request.toJson());
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Novosti/$id");

    http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Novost successfully updated.'),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const NovostiListScreen()));
      } else {
        // Handle error
      }
    }).catchError((error) {
      // Handle error
    });
  }
}

class NovostiInsertRequest {
  final String naslov;
  final String sadrzaj;
  final DateTime? datumObjave;
  final int? osobljeId;


  NovostiInsertRequest({
    required this.naslov,
    required this.sadrzaj,
    required this.datumObjave,
    required this.osobljeId
  });

  Map<String, dynamic> toJson() {
    return {
      'naslov': naslov,
      'sadrzaj': sadrzaj,
      'datumObjave': datumObjave?.toIso8601String(),
      'osobljeId': osobljeId,
    };
  }
}