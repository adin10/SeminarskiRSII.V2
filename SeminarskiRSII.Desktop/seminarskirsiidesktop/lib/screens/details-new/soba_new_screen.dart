import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seminarskirsiidesktop/screens/lists/soba_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewSobaScreen extends StatefulWidget {
  final dynamic soba; // If passed, this will be the existing Soba to edit

  const NewSobaScreen({Key? key, this.soba}) : super(key: key);

  @override
  _NewSobaScreenState createState() => _NewSobaScreenState();
}

class _NewSobaScreenState extends State<NewSobaScreen> {
  final TextEditingController _brojSobeController = TextEditingController();
  final TextEditingController _brojSprataController = TextEditingController();
  final TextEditingController _opisSobeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  int? sobaStatusId; // Initialize as nullable
  List<dynamic> statusiSoba = [];
  Uint8List? _slikaBytes;

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
    if (widget.soba['slika'] != null) {
      _slikaBytes = base64Decode(widget.soba['slika']);
    }
  }

  Future<void> _fetchSobaStatus() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/SobaStatus");

    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
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
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _slikaBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.soba == null ? 'Create New Room' : 'Update Room',
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
                    widget.soba == null
                        ? 'Enter New Room Details'
                        : 'Update Room Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _brojSobeController,
                    labelText: 'Broj Sobe',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter room number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _brojSprataController,
                    labelText: 'Broj Sprata',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _opisSobeController,
                    labelText: 'Opis sobe',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    labelText: 'Soba Status',
                    value: sobaStatusId,
                    items: statusiSoba.map<DropdownMenuItem<int>>((sobaStatus) {
                      return DropdownMenuItem<int>(
                        value: sobaStatus['id'],
                        child: Text(sobaStatus['status']),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        sobaStatusId = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a soba status';
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
                              width: 250,
                              height: 140,
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        widget.soba == null ? 'Create Room' : 'Update Room',
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
      if (widget.soba == null) {
        _createSoba();
      } else {
        _updateSoba(widget.soba!['id']);
      }
    }
  }

  void _createSoba() async {
    final request = {
      "brojSobe": int.parse(_brojSobeController.text),
      "brojSprata": int.parse(_brojSprataController.text),
      "opisSobe": _opisSobeController.text,
      "slika": _slikaBytes != null
          ? base64Encode(_slikaBytes!)
          : widget.soba['slika'], // Use _slikaBytes here
      "sobaStatusId": sobaStatusId,
    };

    final requestBody = jsonEncode(request);
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Soba");

    final response = await http.post(
      url,
      body: requestBody,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      showCustomSnackBar(
        context,
        'Soba successfully created.',
        Colors.green,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SobaListScreen()));
    } else {
      _showErrorSnackBar();
    }
  }

  void _updateSoba(int id) async {
    final request = {
      "brojSobe": int.parse(_brojSobeController.text),
      "brojSprata": int.parse(_brojSprataController.text),
      "opisSobe": _opisSobeController.text,
      "slika": _slikaBytes != null
          ? base64Encode(_slikaBytes!)
          : widget.soba['slika'], // Use _slikaBytes here
      "sobaStatusId": sobaStatusId, // Ensure sobaStatusId is passed
    };

    final requestBody = jsonEncode(request);
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Soba/${widget.soba['id']}");

    final response = await http.put(
      url,
      body: requestBody,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      showCustomSnackBar(
        context,
        'Soba successfully updated.',
        Colors.green,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SobaListScreen()));
    } else {
      _showErrorSnackBar();
    }
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
