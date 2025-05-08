import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsiidesktop/providers/cjenovnik_provider.dart';
import 'package:seminarskirsiidesktop/providers/soba_provider.dart';
import 'package:seminarskirsiidesktop/screens/lists/cjenovnik_list_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart';

class NewCjenovnikScreen extends StatefulWidget {
  final int sobaId;
  final int? cijenaId; // null znači da kreiraš novu cijenu

  const NewCjenovnikScreen({
    Key? key,
    required this.sobaId,
    this.cijenaId,
  }) : super(key: key);

  @override
  _NewCjenovnikScreenState createState() => _NewCjenovnikScreenState();
}

class _NewCjenovnikScreenState extends State<NewCjenovnikScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cijenaController = TextEditingController();
  final TextEditingController _vrijediOdController = TextEditingController();
  final TextEditingController _vrijediDoController = TextEditingController();
  int? _selectedSobaId;
  String? _selectedValuta;
  List<dynamic> _sobeList = [];
  DateTime? _selectedDateVrijediOd;
  DateTime? _selectedDateVrijediDo;
  final List<String> _valute = ['KM', 'EUR', 'USD'];
  Map<String, dynamic>? _cjenovnikData;

  @override
  void initState() {
    super.initState();
    _fetchSobe();
    _selectedSobaId = widget.sobaId;
    _loadCjenovnik(); // Poziv async metode bez await-a
  }

  Future<void> _loadCjenovnik() async {
    if (widget.cijenaId != null) {
      try {
        _cjenovnikData =
            await CjenovnikProvider().getById(widget.cijenaId.toString());
        var cjenovnik = _cjenovnikData!;

        setState(() {
          _cijenaController.text = cjenovnik['cijena']?.toString() ?? '';
          _selectedValuta = cjenovnik['valuta']?.toString();
          _selectedSobaId = cjenovnik['soba']?['id'];

          if (cjenovnik['vrijediOd'] != null) {
            _selectedDateVrijediOd = DateTime.parse(cjenovnik['vrijediOd']);
            _vrijediOdController.text =
                DateFormat('dd-MM-yyyy').format(_selectedDateVrijediOd!);
          }

          if (cjenovnik['vrijediDo'] != null) {
            _selectedDateVrijediDo = DateTime.parse(cjenovnik['vrijediDo']);
            _vrijediDoController.text =
                DateFormat('dd-MM-yyyy').format(_selectedDateVrijediDo!);
          }
        });
      } catch (e) {
        print("Greška pri dohvaćanju cjenovnika: $e");
      }
    }
  }

  Future<void> _fetchSobe() async {
    var fetchedSobe = await SobaProvider().get('Sobe');
    setState(() {
      _sobeList = fetchedSobe;
    });
  }

  Future<void> _selectVrijediOdDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateVrijediOd ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDateVrijediOd) {
      setState(() {
        _selectedDateVrijediOd = picked;
        _vrijediOdController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> _selectVrijediDoDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateVrijediDo ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDateVrijediDo) {
      setState(() {
        _selectedDateVrijediDo = picked;
        _vrijediDoController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.cijenaId == null ? 'Kreiraj novu cijenu' : 'Uredite cijenu',
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
                    widget.cijenaId == null
                        ? 'Unesite informacije'
                        : 'Uredite informacije',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        return 'Odaberite sobu';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedValuta,
                    decoration: InputDecoration(
                      labelText: 'Valuta',
                      labelStyle: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    items: _valute.map((valuta) {
                      return DropdownMenuItem(
                        value: valuta,
                        child: Text(valuta),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedValuta = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Odaberite valutu';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _cijenaController,
                    labelText: 'Cijena',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite cijenu';
                      }
                      final double? parsedValue = double.tryParse(value);
                      if (parsedValue == null) {
                        return 'Unesite validan broj';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildDatePickerField(
                    controller: _vrijediOdController,
                    labelText: 'Vrijedi Od',
                    onTap: () => _selectVrijediOdDate(context),
                  ),
                  const SizedBox(height: 20),
                  _buildDatePickerField(
                    controller: _vrijediDoController,
                    labelText: 'Vrijedi Do',
                    onTap: () => _selectVrijediDoDate(context),
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
                        widget.cijenaId == null
                            ? 'Kreiraj cijenu'
                            : 'Uredi cijenu',
                        style: const TextStyle(
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
    // If the sobaId is already set (during editing), disable the dropdown
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
      onChanged: widget.sobaId == null
          ? onChanged
          : null, // Disable the dropdown if the sobaId is set
      validator: validator,
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.cijenaId == null) {
        _createCjenovnik();
      } else {
        _updateCjenovnik(widget.cijenaId!);
      }
    }
  }

  void _createCjenovnik() {
    final requestBody = jsonEncode({
      'Valuta': _selectedValuta,
      'Cijena': double.tryParse(_cijenaController.text),
      'SobaId': _selectedSobaId,
      'VrijediOd': _selectedDateVrijediOd?.toIso8601String(),
      'VrijediDo': _selectedDateVrijediDo?.toIso8601String(),
    });
    _submitData(requestBody, "${BaseProvider.baseUrl}/Cjenovnik", 'POST');
  }

  void _updateCjenovnik(int id) {
    final requestBody = jsonEncode({
      'valuta': _selectedValuta,
      'Cijena': double.tryParse(_cijenaController.text),
      'SobaId': _selectedSobaId,
      'VrijediOd': _selectedDateVrijediOd?.toIso8601String(),
      'VrijediDo': _selectedDateVrijediDo?.toIso8601String(),
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
              ? 'Cijena uspješno kreirana.'
              : 'Cijena uspješno uređena.',
          Colors.green,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CjenovnikListScreen()),
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
                const Icon(Icons.check_circle, color: Colors.white, size: 24),
                const SizedBox(width: 8),
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

  void _showErrorSnackBar() {
    showErrorToast(context, 'Greška. Pokušajte ponovo kasnije.');
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
}
