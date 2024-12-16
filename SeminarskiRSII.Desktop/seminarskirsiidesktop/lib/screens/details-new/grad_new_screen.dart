import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsiidesktop/providers/drzava_provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/gradovi_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewGradScreen extends StatefulWidget {
  final Map<String, dynamic>? grad;

  const NewGradScreen({Key? key, this.grad}) : super(key: key);

  @override
  _NewGradScreenState createState() => _NewGradScreenState();
}

class _NewGradScreenState extends State<NewGradScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nazivController = TextEditingController();
  TextEditingController _postanskiBrojController = TextEditingController();
  int? _selectedDrzavaId;
  List<dynamic> _drzavaList = [];

  @override
  void initState() {
    super.initState();
    _fetchDrzave();

    if (widget.grad != null) {
      _nazivController.text = widget.grad!['nazivGrada'] ?? '';
      _postanskiBrojController.text =
          widget.grad!['postanskiBroj']?.toString() ?? '';
      _selectedDrzavaId = widget.grad!['drzava']?['id'];
    }
  }

  Future<void> _fetchDrzave() async {
    var fetchedDrzave = await DrzavaProvider().get('Drzave');
    setState(() {
      _drzavaList = fetchedDrzave;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.grad == null ? 'Create New Grad' : 'Update Grad',
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
                    widget.grad == null
                        ? 'Enter New Grad Details'
                        : 'Update Grad Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _nazivController,
                    labelText: 'Naziv Grada',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a city name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _postanskiBrojController,
                    labelText: 'Poštanski Broj',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a postal code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  _buildDropdownField(
                    labelText: 'Država',
                    value: _selectedDrzavaId,
                    items: _drzavaList.map<DropdownMenuItem<int>>((drzava) {
                      return DropdownMenuItem<int>(
                        value: drzava['id'],
                        child: Text(drzava['naziv']),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedDrzavaId = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a country';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      child: Text(
                        widget.grad == null ? 'Create Grad' : 'Update Grad',
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
      if (widget.grad == null) {
        _createGrad();
      } else {
        _updateGrad(widget.grad!['id']);
      }
    }
  }

  void _createGrad() {
    final requestBody = jsonEncode({
      'nazivGrada': _nazivController.text,
      'postanskiBroj': int.tryParse(_postanskiBrojController.text),
      'drzavaId': _selectedDrzavaId,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Grad", 'POST');
  }

  void _updateGrad(int id) {
    final requestBody = jsonEncode({
      'nazivGrada': _nazivController.text,
      'postanskiBroj': int.tryParse(_postanskiBrojController.text),
      'drzavaId': _selectedDrzavaId,
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Grad/$id", 'PUT');
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
              ? 'Grad successfully created.'
              : 'Grad successfully updated.',
          Colors.green,
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GradListScreen()));
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
