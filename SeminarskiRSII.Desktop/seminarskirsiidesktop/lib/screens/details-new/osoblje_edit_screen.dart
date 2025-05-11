import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/io_client.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:seminarskirsiidesktop/providers/vrstaosoblja_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/postavke_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/osoblje_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class EditOsobljeScreen extends StatefulWidget {
  final Osoblje osoblje;

  const EditOsobljeScreen({Key? key, required this.osoblje}) : super(key: key);

  @override
  _EditOsobljeScreenState createState() => _EditOsobljeScreenState();
}

class _EditOsobljeScreenState extends State<EditOsobljeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _korisnickoImeController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  List<dynamic> _pozicije = [];
  List<int> _selectedPozicije = [];
  Uint8List? _slikaBytes;

  @override
void initState() {
  super.initState();
  _fetchPozicije();
}

Future<void> _fetchPozicije() async {
  // Učitaj pozicije
  var fetchedPozicije = await VrstaOsobljaProvider().get('VrstaOsoblja');
  setState(() {
    _pozicije = fetchedPozicije;

    final Map<String, int> pozicijaToId = {
      for (var p in _pozicije) p['pozicija']: p['id'],
    };

    if (widget.osoblje != null) {
      _imeController.text = widget.osoblje.ime ?? '';
      _prezimeController.text = widget.osoblje.prezime ?? '';
      _emailController.text = widget.osoblje.email ?? '';
      _korisnickoImeController.text = widget.osoblje.korisnickoIme ?? '';
      _telefonController.text = widget.osoblje.telefon ?? '';
      
      if (widget.osoblje.slika != null) {
        if (widget.osoblje.slika is Uint8List) {
          _slikaBytes = widget.osoblje.slika as Uint8List?;
        } else if (widget.osoblje.slika is String) {
          _slikaBytes = base64Decode(widget.osoblje.slika as String);
        }
      }

      _selectedPozicije = widget.osoblje.uloge
          .map<int>((naziv) => pozicijaToId[naziv] ?? 0)
          .where((id) => id != 0)
          .toList();

      print(_selectedPozicije);
    }
  });
}

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _slikaBytes = File(pickedFile.path).readAsBytesSync();
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final request = {
        "ime": _imeController.text,
        "prezime": _prezimeController.text,
        "email": _emailController.text,
        "korisnickoIme": _korisnickoImeController.text,
        "telefon": _telefonController.text,
        "slika": _slikaBytes != null ? base64Encode(_slikaBytes!) : null,
        "uloge": _selectedPozicije
      };

      _submitData(jsonEncode(request));
    }
  }

  void _submitData(String requestBody) {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);

    final String method = widget.osoblje == null ? 'POST' : 'PUT';
    final String url = widget.osoblje == null
        ? "${BaseProvider.baseUrl}/Osoblje"
        : "${BaseProvider.baseUrl}/Osoblje/${widget.osoblje.id}";

    final uri = Uri.parse(url);

    final Future response = method == 'POST'
        ? http.post(uri, body: requestBody, headers: {'Content-Type': 'application/json'})
        : http.put(uri, body: requestBody, headers: {'Content-Type': 'application/json'});

    response.then((res) {
      if (res.statusCode == 200) {
        showCustomSnackBar(
          context,
          widget.osoblje == null
              ? 'Uposlenik uspjesno kreiran.'
              : 'Uposlenik uspjesno modifikovan.',
          Colors.green,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OsobljeListScreen()),
        );
      } else {
        _showErrorSnackBar();
      }
    }).catchError((_) => _showErrorSnackBar());
  }

void _showErrorSnackBar() {
  showErrorToast(context, 'Error occurred. Please try again later.');
}

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.osoblje == null ? 'Kreiraj novog uposlenika' : 'Uredi informacije o uposleniku',
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 600,
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
                    widget.osoblje == null
                        ? 'Unesite informacije'
                        : 'Uredite informacije',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // _buildTextField(_imeController, 'Ime'),
                  // const SizedBox(height: 20),
                  // _buildTextField(_prezimeController, 'Prezime'),
                  const SizedBox(height: 20),
                  _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  _buildTextField(_korisnickoImeController, 'Korisnicko Ime'),
                  const SizedBox(height: 20),
                  _buildTextField(_telefonController, 'Telefon', keyboardType: TextInputType.phone),
                    const SizedBox(height: 20),
                  MultiSelectDialogField(
                    items: _pozicije.map((pozicija) {
                      return MultiSelectItem<int>(pozicija['id'], pozicija['pozicija']);
                    }).toList(),
                    title: Text("Odaberite poziciju"),
                    selectedColor: Colors.blue,
                    buttonText: Text("Odaberite poziciju"),
                    onConfirm: (values) {
                      setState(() {
                        _selectedPozicije = values;
                      });
                    },
                    initialValue: _selectedPozicije,
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _slikaBytes != null
                        ? Image.memory(
                            _slikaBytes!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : const Text("Slika nije odabrana"),
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
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        widget.osoblje == null ? 'Dodaj uposlenika' : 'Uredi informacije',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildTextField(
    TextEditingController controller,
    String labelText, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.blue[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty ? 'Molim vas unesite $labelText' : null,
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

  Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
}

void showCustomSnackBar(BuildContext context, String message, Color backgroundColor) {
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
  Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
}
