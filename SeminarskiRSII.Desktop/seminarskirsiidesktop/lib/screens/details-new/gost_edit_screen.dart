import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsiidesktop/providers/base_provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/gosti_list_screen.dart';
import '../../widgets/master_screen.dart';

class GostEditScreen extends StatefulWidget {
  final Map<String, dynamic> gost;

  const GostEditScreen({Key? key, required this.gost}) : super(key: key);

  @override
  State<GostEditScreen> createState() => _GostEditScreenState();
}

class _GostEditScreenState extends State<GostEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _korisnickoImeController = TextEditingController();

  int? _selectedGradId;
  List<dynamic> _gradoviList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchGradovi();

    _imeController.text = widget.gost['ime'] ?? '';
    _prezimeController.text = widget.gost['prezime'] ?? '';
    _emailController.text = widget.gost['email'] ?? '';
    _telefonController.text = widget.gost['telefon'] ?? '';
    _korisnickoImeController.text = widget.gost['korisnickoIme'] ?? '';
    _selectedGradId = widget.gost['grad']?['id'];
  }

  Future<void> _fetchGradovi() async {
    setState(() {
      _isLoading = true;
    });
    var fetchedGradovi = await GradProvider().get(null);
    
    setState(() {
      print(widget.gost['id']);
      _gradoviList = fetchedGradovi;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Uredi gosta',
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
                    'Uredite informacije',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _imeController,
                    labelText: 'Ime',
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Unesite ime' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _prezimeController,
                    labelText: 'Prezime',
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Unesite prezime' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Unesite email' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _telefonController,
                    labelText: 'Telefon',
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _buildDropdownField(
                          labelText: 'Grad',
                          value: _selectedGradId,
                          items: _gradoviList.map<DropdownMenuItem<int>>((grad) {
                            return DropdownMenuItem<int>(
                              value: grad['id'],
                              child: Text(grad['nazivGrada']),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              _selectedGradId = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null) return 'Odaberite grad';
                            return null;
                          },
                        ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _korisnickoImeController,
                    labelText: 'Korisničko ime',
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Unesite korisničko ime' : null,
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
                        'Uredi podatke',
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
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
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

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(widget.gost['id']);
      _updateGost(widget.gost['id']);
    }
  }

  void _updateGost(int id) {
    final requestBody = jsonEncode({
      'ime': _imeController.text,
      'prezime': _prezimeController.text,
      'email': _emailController.text,
      'telefon': _telefonController.text,
      'korisnickoIme': _korisnickoImeController.text,
      'gradId': _selectedGradId
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Gost/UpdateInformation/$id", 'PUT');
  }

  void _submitData(String requestBody, String url, String method) {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final uri = Uri.parse(url);

    final Future response = http.put(uri,
        body: requestBody, headers: {'Content-Type': 'application/json'});

    response.then((res) {
      if (res.statusCode == 200) {
        showCustomSnackBar(
          context,
          'Informacije uspjesno uredjene.',
          Colors.green,
        );
                Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const GostiListScreen()),
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
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  void _showErrorSnackBar() {
    showCustomSnackBar(
        context, "Došlo je do greške. Pokušajte ponovo.", Colors.red);
  }
}