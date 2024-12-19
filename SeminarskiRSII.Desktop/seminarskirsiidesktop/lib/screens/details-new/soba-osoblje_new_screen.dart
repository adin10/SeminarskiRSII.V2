// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/sobaosoblje_list_screen.dart';
// import '../../providers/base_provider.dart';

// class NewSobaOsobljeScreen extends StatefulWidget {
//   const NewSobaOsobljeScreen({Key? key}) : super(key: key);

//   @override
//   _NewSobaOsobljeScreenState createState() => _NewSobaOsobljeScreenState();
// }

// class _NewSobaOsobljeScreenState extends State<NewSobaOsobljeScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late int sobaId;
//   late int osobljeId;
//   List<dynamic> sobe = []; // List to hold countries
//   List<dynamic> osoblje = []; // List to hold countries

//   @override
//   void initState() {
//     super.initState();
//     _fetchSobe();
//     _fetchOsoblje();
//   }

//   Future<void> _fetchSobe() async {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Soba"); // Replace with your endpoint

//     try {
//       final response = await http.get(url, headers: {'Content-Type': 'application/json'});
//       if (response.statusCode == 200) {
//         setState(() {
//           sobe = json.decode(response.body);
//         });
//       } else {
//         // Handle error
//       }
//     } catch (error) {
//       // Handle error
//     }
//   }

//     Future<void> _fetchOsoblje() async {
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dodjeli sobu uposleniku'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               DropdownButtonFormField<int>(
//                 decoration: InputDecoration(labelText: 'Soba'),
//                 items: sobe.map<DropdownMenuItem<int>>((soba) {
//                   return DropdownMenuItem<int>(
//                     value: soba['id'],
//                     child: Text(soba['brojSobe'].toString()),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     sobaId = value!;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select Soba';
//                   }
//                   return null;
//                 },
//               ),
//                DropdownButtonFormField<int>(
//                 decoration: InputDecoration(labelText: 'Osoblje'),
//                 items: osoblje.map<DropdownMenuItem<int>>((osoba) {
//                   return DropdownMenuItem<int>(
//                     value: osoba['id'],
//                     child: Text("${osoba['ime']} ${osoba['prezime']}"),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     osobljeId = value!;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select Uposlenik';
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
//                     _createSobaOsoblje();
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

//   void _createSobaOsoblje() {
//     // Implement your logic to create Grad here
//     final request = SobaOsobljeInsertRequest(
//       sobaId: sobaId,
//       osobljeId: osobljeId
//     );

//     // Pretvorite objekt request u JSON string
//     final requestBody = jsonEncode(request.toJson());

//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     // Izvršite HTTP POST zahtjev na server
//     final url = Uri.parse("${BaseProvider.baseUrl}/SobaOsoblje");
//     http.post(url,
//         body: requestBody,
//         headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Soba uspjesno dodjeljena uposleniku.'),
//             behavior: SnackBarBehavior.floating, // Display at the top
//           ),
//         );
//         // Uspješno poslan zahtjev
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const SobaOsobljeListScreen()),
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
//     super.dispose();
//   }
// }

// class SobaOsobljeInsertRequest {
//   final int sobaId;
//   final int osobljeId;

//   SobaOsobljeInsertRequest({
//     required this.sobaId,
//     required this.osobljeId
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'sobaId': sobaId,
//       'osobljeId': osobljeId
//     };
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsiidesktop/providers/drzava_provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
import 'package:seminarskirsiidesktop/providers/soba_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/sobaosoblje_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewSobaOsobljeScreen extends StatefulWidget {
  final Map<String, dynamic>? sobaOsoblje;

  const NewSobaOsobljeScreen({Key? key, this.sobaOsoblje}) : super(key: key);

  @override
  _NewSobaOsobljeScreenState createState() => _NewSobaOsobljeScreenState();
}

class _NewSobaOsobljeScreenState extends State<NewSobaOsobljeScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedsobaID;
  int? _selectedOsobljeID;
  List<dynamic> _sobaList = [];
  List<dynamic> _osobljeList = [];

  @override
  void initState() {
    super.initState();
    _fetchOsoblje();
    _fetchSobe();

    if (widget.sobaOsoblje != null) {
      _selectedsobaID = widget.sobaOsoblje!['soba']?['id'];
      _selectedOsobljeID = widget.sobaOsoblje!['osoblje']?['id'];
    }
  }

  Future<void> _fetchOsoblje() async {
    var fetchedOsoblje = await OsobljeProvider().get('Drzave');
    setState(() {
      _osobljeList = fetchedOsoblje;
    });
  }

  Future<void> _fetchSobe() async {
    var fetchedSobe = await SobaProvider().get('Soba');
    setState(() {
      _sobaList = fetchedSobe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.sobaOsoblje == null
          ? 'Create New Soba Osoblje'
          : 'Update Soba Osbolje',
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
                    widget.sobaOsoblje == null
                        ? 'Enter New Soba Osoblje Details'
                        : 'Update Soba Osoblje Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    labelText: 'Osoblje',
                    value: _selectedOsobljeID,
                    items: _osobljeList.map<DropdownMenuItem<int>>((osoblje) {
                      return DropdownMenuItem<int>(
                        value: osoblje['id'],
                        child: Text("${osoblje['ime']} ${osoblje['prezime']}"),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedOsobljeID = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Osoblje';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    labelText: 'Soba',
                    value: _selectedsobaID,
                    items: _sobaList.map<DropdownMenuItem<int>>((soba) {
                      return DropdownMenuItem<int>(
                        value: soba['id'],
                        child: Text(soba['brojSobe'].toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedsobaID = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a room';
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
                        widget.sobaOsoblje == null
                            ? 'Create Soba Osoblje'
                            : 'Update Soba Osoblje',
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
        labelStyle:
            const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
      if (widget.sobaOsoblje == null) {
        _createSobaOsoblje();
      } else {
        _updateSobaOsoblje(widget.sobaOsoblje!['id']);
      }
    }
  }

  void _createSobaOsoblje() {
    final requestBody = jsonEncode({
      'sobaId': _selectedsobaID,
      'osobljeId': _selectedOsobljeID,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/SobaOsoblje", 'POST');
  }

  void _updateSobaOsoblje(int id) {
    final requestBody = jsonEncode({
      'sobaId': _selectedsobaID,
      'osobljeId': _selectedOsobljeID,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/SobaOsoblje/$id", 'PUT');
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
              ? 'Soba Osoblje successfully created.'
              : 'Soba Osoblje successfully updated.',
          Colors.green,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SobaOsobljeListScreen()));
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
