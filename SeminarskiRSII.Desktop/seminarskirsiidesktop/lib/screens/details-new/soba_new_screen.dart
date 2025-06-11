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
  final dynamic soba;

  const NewSobaScreen({Key? key, this.soba}) : super(key: key);

  @override
  _NewSobaScreenState createState() => _NewSobaScreenState();
}

class _NewSobaScreenState extends State<NewSobaScreen> {
  final TextEditingController _brojSobeController = TextEditingController();
  final TextEditingController _brojSprataController = TextEditingController();
  final TextEditingController _opisSobeController = TextEditingController();
  late TextEditingController _statusController;
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  String statusSobeTekst = "";
  int? sobaStatusId;
  List<dynamic> statusiSoba = [];
  Uint8List? _slikaBytes;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController();
      if (widget.soba != null) {
    _initializeFields();
    _fetchSobaStatus();
  } else {
    statusSobeTekst = "Slobodna";
    _statusController.text = "Slobodna";
  }
  }

  void _initializeFields() {
    _brojSobeController.text = widget.soba['brojSobe'].toString();
    _brojSprataController.text = widget.soba['brojSprata'].toString();
    _opisSobeController.text = widget.soba['opisSobe'];
    _statusController.text = widget.soba['statusSobe'];
    if (widget.soba['slika'] != null) {
      _slikaBytes = base64Decode(widget.soba['slika']);
    }
  }

  Future<void> _fetchSobaStatus() async {
  final ioc = HttpClient();
  ioc.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  final http = IOClient(ioc);
  final id = widget.soba['id'];
  final url = Uri.parse("${BaseProvider.baseUrl}/Soba/sobaZauzeta/$id");
  
  try {
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final isZauzeta = json.decode(response.body) == true;
      setState(() {
        statusSobeTekst = isZauzeta ? "Zauzeta" : "Slobodna";
        _statusController.text = isZauzeta ? "Zauzeta" : "Slobodna";
      });
    } else {
      setState(() {
        statusSobeTekst = "Nepoznat status";
      });
    }
  } catch (error) {
    setState(() {
      statusSobeTekst = "Greška pri dohvaćanju statusa";
    });
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
      title: widget.soba == null ? 'Kreirajte sobu' : 'Uredite sobu',
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
                        ? 'Unesite informacije'
                        : 'Uredite informacije',
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
                        return 'Unesite broj sobe';
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
                        return 'Unesite broj sprata';
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
                        return 'Opisite sobu';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildReadOnlyField(
                    labelText: 'Status sobe',
                    controller: _statusController,
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
                          : const Text("Niste odabrali sliku"),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Odaberi sliku'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        widget.soba == null ? 'Kreirajte sobu' : 'Uredite sobu',
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
        labelStyle: const TextStyle(
            color: Colors.blueAccent, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.blue[50],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
        labelStyle: const TextStyle(
            color: Colors.blueAccent, fontWeight: FontWeight.bold),
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

Widget _buildReadOnlyField({required String labelText, required TextEditingController controller}) {
  return TextFormField(
    readOnly: true,
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
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
    style: const TextStyle(color: Colors.black87),
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
          : widget.soba['slika'],
      "statusSobe": _statusController.text
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
        'Soba uspješno kreirana.',
        Colors.green,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SobaListScreen()),
        (route) => route.isFirst,
      );
    } else if (response.statusCode == 400) {
      showWarningToast(
        context,
        utf8.decode(
            response.bodyBytes)
      );
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
          : widget.soba['slika'],
      "statusSobe": _statusController.text
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
        'Soba uspješno uredjena.',
        Colors.green,
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const SobaListScreen()),
      // );
                      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SobaListScreen()),
          (route) => route.isFirst,
        );
    } else if (response.statusCode == 400) {
      showWarningToast(
        context,
        utf8.decode(
            response.bodyBytes)
      );
    } else {
      _showErrorSnackBar();
    }
  }

  void showCustomSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        left: MediaQuery.of(context).size.width * 0.20,
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
                  size: 24,
                ),
                const SizedBox(width: 8),
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
    Future.delayed(const Duration(seconds: 3))
        .then((_) => overlayEntry.remove());
  }

  void _showErrorSnackBar() {
    showErrorToast(context, 'Error occurred. Please try again later.');
  }

  void showErrorToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        left: MediaQuery.of(context).size.width * 0.15,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 10),
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

    Future.delayed(const Duration(seconds: 3))
        .then((_) => overlayEntry.remove());
  }

void showWarningToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 20,
      left: MediaQuery.of(context).size.width * 0.15,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.orange, // narandžasta boja
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Colors.white),
              const SizedBox(width: 10),
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

  Future.delayed(const Duration(seconds: 3))
      .then((_) => overlayEntry.remove());
}
}
