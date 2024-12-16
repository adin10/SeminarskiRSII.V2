// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import '../../providers/base_provider.dart';
// import '../lists/cjenovnik_list_screen.dart';

// class NewCjenovnikScreen extends StatefulWidget {
//   final dynamic cjenovnik; // Pass the existing cjenovnik for editing

//   const NewCjenovnikScreen({Key? key, this.cjenovnik}) : super(key: key);

//   @override
//   _NewCjenovnikScreenState createState() => _NewCjenovnikScreenState();
// }

// class _NewCjenovnikScreenState extends State<NewCjenovnikScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _cijenaController = TextEditingController();
//   TextEditingController _brojDanaController = TextEditingController();
//   String? selectedSoba;
//   List<dynamic> sobe = [];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     loadSobe();

//     if (widget.cjenovnik != null) {
//       _cijenaController.text = widget.cjenovnik['cijena']?.toString() ?? '';
//       _brojDanaController.text = widget.cjenovnik['brojDana']?.toString() ?? '';
//       selectedSoba = widget.cjenovnik['soba']?['id'].toString();
//     }
//   }

// Future loadSobe() async {
//   final ioc = HttpClient();
//   ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   final http = IOClient(ioc);
//   final url = Uri.parse("${BaseProvider.baseUrl}/Soba"); // Assuming this is your API endpoint for rooms

//   final response = await http.get(url);
//   if (response.statusCode == 200) {
//     setState(() {
//       sobe = jsonDecode(response.body);
//     });
//   } else {
//     // Handle error
//     print('Error loading rooms: ${response.statusCode}');
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.cjenovnik == null ? 'Dodaj Cjenovnik' : 'Izmijeni Cjenovnik'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//                   DropdownButtonFormField<String>(
//                 value: selectedSoba,
//                 decoration: InputDecoration(labelText: 'Broj Sobe'),
//                 items: sobe.map((soba) {
//                   return DropdownMenuItem<String>(
//                     value: soba['id'].toString(),
//                     child: Text(soba['brojSobe'].toString()),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedSoba = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select a Soba';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _cijenaController,
//                 decoration: InputDecoration(labelText: 'Cijena'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Molimo unesite cijenu';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _brojDanaController,
//                 decoration: InputDecoration(labelText: 'Broj dana'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Molimo unesite broj dana';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     if (widget.cjenovnik == null) {
//                       _createCjenovnik();
//                     } else {
//                       _updateCjenovnik(widget.cjenovnik['id']);
//                     }
//                   }
//                 },
//                 child: Text(widget.cjenovnik == null ? 'Dodaj' : 'Izmijeni'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _createCjenovnik() {
//     final request = {
//       'sobaId': int.parse(selectedSoba!),
//       'cijena': double.parse(_cijenaController.text),
//       'brojDana': int.parse(_brojDanaController.text),
//     };

//     final requestBody = jsonEncode(request);
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik"); // Adjust the URL

//     http.post(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Cjenovnik successfully created.'),
//           behavior: SnackBarBehavior.floating,
//         ));
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const CjenovnikListScreen()));
//       } else {
//         // Handle error
//         print("Error creating Cjenovnik: ${response.body}");
//       }
//     }).catchError((error) {
//       print("Error: $error");
//     });
//   }

//   void _updateCjenovnik(int id) {
//     final request = {
//       'sobaId': int.parse(selectedSoba!),
//       'cijena': double.parse(_cijenaController.text),
//       'brojDana': int.parse(_brojDanaController.text),
//     };
//     final requestBody = jsonEncode(request);
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik/$id"); // Adjust the URL

//     http.put(url, body: requestBody, headers: {'Content-Type': 'application/json'}).then((response) {
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Cjenovnik successfully updated.'),
//           behavior: SnackBarBehavior.floating,
//         ));
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const CjenovnikListScreen()));
//       } else {
//         // Handle error
//         print("Error updating Cjenovnik: ${response.body}");
//       }
//     }).catchError((error) {
//       print("Error: $error");
//     });
//   }

//     @override
//   void dispose() {
//     _cijenaController.dispose();
//     _brojDanaController.dispose();
//     super.dispose();
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsiidesktop/providers/drzava_provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/providers/soba_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/cjenovnik_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewCjenovnikScreen extends StatefulWidget {
  final Map<String, dynamic>? cjenovnik;

  const NewCjenovnikScreen({Key? key, this.cjenovnik}) : super(key: key);

  @override
  _NewCjenovnikScreenState createState() => _NewCjenovnikScreenState();
}

class _NewCjenovnikScreenState extends State<NewCjenovnikScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _brojDanaController = TextEditingController();
  TextEditingController _cijenaController = TextEditingController();
  int? _selectedSobaId;
  List<dynamic> _sobeList = [];

  @override
  void initState() {
    super.initState();
    _fetchSobe();

    if (widget.cjenovnik != null) {
      _brojDanaController.text =
          widget.cjenovnik!['brojDana']?.toString() ?? '';
      _cijenaController.text = widget.cjenovnik!['cijena']?.toString() ?? '';
      _selectedSobaId = widget.cjenovnik!['soba']?['id'];
    }
  }

  Future<void> _fetchSobe() async {
    var fetchedSobe = await SobaProvider().get('Sobe');
    setState(() {
      _sobeList = fetchedSobe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.cjenovnik == null ? 'Create New Cijena' : 'Update Cijena',
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
                    widget.cjenovnik == null
                        ? 'Enter New Cijena'
                        : 'Update Cijena details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildDropdownField(
                    labelText: 'Broj Sobe',
                    value: _selectedSobaId,
                    items: _sobeList.map<DropdownMenuItem<int>>((soba) {
                      return DropdownMenuItem<int>(
                        value: soba['id'],
                        child: Text(soba['brojSobe'].toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedSobaId = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a room';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _brojDanaController,
                    labelText: 'Broj dana',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a number of days';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _cijenaController,
                    labelText: 'Cijena',
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      final double? parsedValue = double.tryParse(value);
                      if (parsedValue == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      child: Text(
                        widget.cjenovnik == null
                            ? 'Create Price'
                            : 'Update Price',
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
            TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
      if (widget.cjenovnik == null) {
        _createGrad();
      } else {
        _updateGrad(widget.cjenovnik!['id']);
      }
    }
  }

  void _createGrad() {
    final requestBody = jsonEncode({
      'BrojDana': int.tryParse(_brojDanaController.text),
      'Cijena': double.tryParse(_cijenaController.text),
      'SobaId': _selectedSobaId,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Cjenovnik", 'POST');
  }

  void _updateGrad(int id) {
    final requestBody = jsonEncode({
      'BrojDana': int.tryParse(_brojDanaController.text),
      'Cijena': double.tryParse(_cijenaController.text),
      'SobaId': _selectedSobaId,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Cjenovnik/$id", 'PUT');
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
              ? 'Cjenovnik successfully created.'
              : 'Cjenovnik successfully updated.',
          Colors.green,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CjenovnikListScreen()));
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
