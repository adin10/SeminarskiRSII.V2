import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsiidesktop/providers/drzava_provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewVrstaOsobljaScreen extends StatefulWidget {
  final dynamic vrstaOsoblja;

  const NewVrstaOsobljaScreen({Key? key, this.vrstaOsoblja}) : super(key: key);

  @override
  _NewVrstaOsobljaScreenState createState() => _NewVrstaOsobljaScreenState();
}

class _NewVrstaOsobljaScreenState extends State<NewVrstaOsobljaScreen> {
  final TextEditingController _pozicijaController = TextEditingController();
  final TextEditingController _zaduzenjaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.vrstaOsoblja != null) {
      _pozicijaController.text = widget.vrstaOsoblja['pozicija'] ?? '';
      _zaduzenjaController.text = widget.vrstaOsoblja['zaduzenja'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.vrstaOsoblja == null
          ? 'Kreirajte novu poziciju'
          : 'Uredite poziciju',
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
                    widget.vrstaOsoblja == null
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
                    controller: _pozicijaController,
                    labelText: 'Pozicija',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite naziv pozicije';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _zaduzenjaController,
                    labelText: 'Zaduzenje',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Uneiste zaduzenja za poziciju';
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
                        widget.vrstaOsoblja == null
                            ? 'Kreiraj poziciju'
                            : 'Uredi poziciju',
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

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.vrstaOsoblja == null) {
        _createVrstaOsoblja();
      } else {
        _updateVrstaOsoblja(widget.vrstaOsoblja!['id']);
      }
    }
  }

  void _createVrstaOsoblja() {
    final requestBody = jsonEncode({
      'pozicija': _pozicijaController.text,
      'zaduzenja': _zaduzenjaController.text
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/VrstaOsoblja", 'POST');
  }

  void _updateVrstaOsoblja(int id) {
    final requestBody = jsonEncode({
      'pozicija': _pozicijaController.text,
      'zaduzenja': _zaduzenjaController.text
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/VrstaOsoblja/$id", 'PUT');
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
              ? 'Pozicija uspjesno kreirana.'
              : 'Pozicija uspjesno uredjena.',
          Colors.green,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const VrstaOsobljaListScreen()),
          (route) => route.isFirst,
        );
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
            20,
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
    Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
  }

  void _showErrorSnackBar() {
    showErrorToast(context, 'Error occurred. Please try again later.');
  }

  void showErrorToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        left: MediaQuery.of(context).size.width *
            0.15,
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
                const Icon(Icons.error,
                    color: Colors.white),
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

    Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
  }
}
