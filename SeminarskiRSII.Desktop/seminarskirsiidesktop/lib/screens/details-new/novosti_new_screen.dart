// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/providers/novosti_provider.dart';
// import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
// import 'package:seminarskirsiidesktop/screens/lists/novosti_list_screen.dart';
// import '../../providers/base_provider.dart';
// import '../../widgets/master_screen.dart';

// class NewNovostScreen extends StatefulWidget {
//   final Map<String, dynamic>? novost;

//   const NewNovostScreen({Key? key, this.novost}) : super(key: key);

//   @override
//   _NewNovostScreenState createState() => _NewNovostScreenState();
// }

// class _NewNovostScreenState extends State<NewNovostScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _naslovController = TextEditingController();
//   TextEditingController _sadrzajController = TextEditingController();
//   TextEditingController _datumController = TextEditingController();

//   DateTime? _selectedDate;
//   int? _selectedAutorId;
//   List<dynamic> _osobljeList = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchOsoblje();

//     // If editing, prefill the form with existing data
//     if (widget.novost != null) {
//       _naslovController.text = widget.novost!['naslov'] ?? '';
//       _sadrzajController.text = widget.novost!['sadrzaj'] ?? '';

//       if (widget.novost!['datumObjave'] != null) {
//         _selectedDate = DateTime.parse(widget.novost!['datumObjave']);
//         _datumController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
//       }

//       _selectedAutorId = widget.novost!['osoblje']?['id'];
//     }
//   }

//   Future<void> _fetchOsoblje() async {
//     var fetchedOsoblje = await OsobljeProvider().get(null);
//     setState(() {
//       _osobljeList = fetchedOsoblje;
//     });
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _datumController.text = DateFormat('dd-MM-yyyy').format(picked);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: widget.novost == null ? 'Create New Soba Status' : 'Update Soba Status',
//         child: Center(
//           child: SingleChildScrollView(
//             child: Container(
//             width: 550,
//             padding: const EdgeInsets.all(24.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
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
//               GestureDetector(
//                 onTap: () => _selectDate(context),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     controller: _datumController,
//                     decoration: InputDecoration(labelText: 'Datum Objave'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select a date';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               DropdownButtonFormField<int>(
//                 value: _selectedAutorId,
//                 decoration: InputDecoration(labelText: 'Autor'),
//                 items: _osobljeList.map<DropdownMenuItem<int>>((osoblje) {
//                   return DropdownMenuItem<int>(
//                     value: osoblje['id'],
//                     child: Text('${osoblje['ime']} ${osoblje['prezime']}'),
//                   );
//                 }).toList(),
//                 onChanged: (int? newValue) {
//                   setState(() {
//                     _selectedAutorId = newValue;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select an author';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//             ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     if (widget.novost == null) {
//                       _saveNovost();
//                     } else {
//                       _updateNovost(widget.novost!['id']);
//                     }
//                   }
//                 },
//                 child: Text(widget.novost == null ? 'Save' : 'Update'),
//               ),
//             ],
//           ),
//         ),
//         )
//           )
//         )
//     );
//   }

//   Future<void> _saveNovost() async {
//     // Logic to save the new notification
//     final request = NovostiInsertRequest(
//       naslov: _naslovController.text,
//       sadrzaj: _sadrzajController.text,
//       datumObjave: _selectedDate,
//       osobljeId: _selectedAutorId,
//     );

//     final requestBody = jsonEncode(request.toJson());
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Novosti");

//     http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Novost successfully created.'),
//           behavior: SnackBarBehavior.floating,
//         ));
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const NovostiListScreen()));
//       } else {
//         // Handle error
//       }
//     }).catchError((error) {
//       // Handle error
//     });
//   }

//   Future<void> _updateNovost(int id) async {
//     // Logic to update the existing notification
//     final request = NovostiInsertRequest(
//       naslov: _naslovController.text,
//       sadrzaj: _sadrzajController.text,
//       datumObjave: _selectedDate,
//       osobljeId: _selectedAutorId,
//     );

//   final requestBody = jsonEncode(request.toJson());
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Novosti/$id");

//     http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Novost successfully updated.'),
//           behavior: SnackBarBehavior.floating,
//         ));
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const NovostiListScreen()));
//       } else {
//         // Handle error
//       }
//     }).catchError((error) {
//       // Handle error
//     });
//   }
// }

// class NovostiInsertRequest {
//   final String naslov;
//   final String sadrzaj;
//   final DateTime? datumObjave;
//   final int? osobljeId;


//   NovostiInsertRequest({
//     required this.naslov,
//     required this.sadrzaj,
//     required this.datumObjave,
//     required this.osobljeId
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'naslov': naslov,
//       'sadrzaj': sadrzaj,
//       'datumObjave': datumObjave?.toIso8601String(),
//       'osobljeId': osobljeId,
//     };
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/novosti_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewNovostScreen extends StatefulWidget {
  final Map<String, dynamic>? novost;

  const NewNovostScreen({Key? key, this.novost}) : super(key: key);

  @override
  _NewNovostScreenState createState() => _NewNovostScreenState();
}

class _NewNovostScreenState extends State<NewNovostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _naslovController = TextEditingController();
  final TextEditingController _sadrzajController = TextEditingController();
  final TextEditingController _datumController = TextEditingController();

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
    return MasterScreenWidget(
      title: widget.novost == null ? 'Create New Novost' : 'Update Novost',
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
                    widget.novost == null
                        ? 'Enter New Novost Details'
                        : 'Update Novost Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _naslovController,
                    labelText: 'Naslov',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _sadrzajController,
                    labelText: 'Sadržaj',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildDatePickerField(
                    controller: _datumController,
                    labelText: 'Datum Objave',
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    labelText: 'Autor',
                    value: _selectedAutorId,
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
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        widget.novost == null ? 'Create Novost' : 'Update Novost',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
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

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String labelText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a date';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String labelText,
    required int? value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    required String? Function(int?) validator,
  }) {
    return DropdownButtonFormField<int>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.blue[50],
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.novost == null) {
        _createNovost();
      } else {
        _updateNovost(widget.novost!['id']);
      }
    }
  }

  void _createNovost() {
    final requestBody = jsonEncode({
      'naslov': _naslovController.text,
      'sadrzaj': _sadrzajController.text,
      'datumObjave': _selectedDate?.toIso8601String(),
      'osobljeId': _selectedAutorId,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Novosti", 'POST');
  }

  void _updateNovost(int id) {
    final requestBody = jsonEncode({
      'naslov': _naslovController.text,
      'sadrzaj': _sadrzajController.text,
      'datumObjave': _selectedDate?.toIso8601String(),
      'osobljeId': _selectedAutorId,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Novosti/$id", 'PUT');
  }

 void _submitData(String requestBody, String url, String method) {
  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = IOClient(ioc);
  final uri = Uri.parse(url);

  final Future response = method == 'POST'
      ? http.post(uri, body: requestBody, headers: {'Content-Type': 'application/json'})
      : http.put(uri, body: requestBody, headers: {'Content-Type': 'application/json'});
  response.then((res) {
  if (res.statusCode == 200) {
    showCustomSnackBar(
      context,
      method == 'POST'
          ? 'Novost successfully created.'
          : 'Novost successfully updated.',
      Colors.green,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NovostiListScreen()));
  } else {
    _showErrorSnackBar();
  }
}).catchError((_) => _showErrorSnackBar());
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

void _showErrorSnackBar() {
  showErrorToast(context, 'Error occurred. Please try again later.');
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
}

