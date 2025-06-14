
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/io_client.dart';
import 'package:seminarskirsmobile/providers/usluge_provider.dart';
import 'package:seminarskirsmobile/screens/lista_rezervacija_screen.dart';
import 'dart:convert';
import '../main.dart';
import '../providers/base_provider.dart';

class RezervacijScreen extends StatefulWidget {
  static const String dodajRezervacijuRouteName = '/dodajRezervaciju';
  const RezervacijScreen({Key? key}) : super(key: key);

  @override
  _RezervacijScreenState createState() => _RezervacijScreenState();
}

class _RezervacijScreenState extends State<RezervacijScreen> {
  final _formKey = GlobalKey<FormState>();

  List<int> selectedUslugaIds = [];
  List<dynamic> _uslugeList = [];
  bool _isLoading = false;

  DateTime? datumRezervacije;
  DateTime? zavrsetakRezervacije;

  @override
  void initState() {
    super.initState();
    fetchAvailableUsluge();
  }

  Future<void> fetchAvailableUsluge() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var fetchedUsluge = await UslugeProvider().get('');

      if (fetchedUsluge == null) {
        throw Exception("No data received");
      }

      setState(() {
        _uslugeList = fetchedUsluge;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Greska prilikom ucitavanja usluga",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        body: Center(
          child: Text('Error: Missing arguments'),
        ),
      );
    }

    final GetUserResponse userData = args['userData'] as GetUserResponse;
    final int userId = args['userId'] as int;
    final int? selectedRoomId = args['selectedRoomId'] as int?;
    final DateTime? datumOd = args['datumOd'] as DateTime?;
    final DateTime? datumDo = args['datumDo'] as DateTime?;

    if (userId == null || selectedRoomId == null || datumOd == null || datumDo == null) {
      return Scaffold(
        body: Center(
          child: Text('Error: Missing required arguments'),
        ),
      );
    }

    datumRezervacije ??= datumOd;
    zavrsetakRezervacije ??= datumDo;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervacija'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Unesite datume za vašu rezervaciju",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16.0),
              _buildReadonlyDateField(
                label: 'Datum rezervacije',
                date: datumRezervacije,
              ),
              _buildReadonlyDateField(
                label: 'Završetak rezervacije',
                date: zavrsetakRezervacije,
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Odaberite Usluge",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal,),
                  ),
                  SizedBox(height: 8.0),
                  _buildCheckboxes(),
                ],
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitForm(userId, userData, selectedRoomId);
                  }
                },
                child: Text('Rezerviši'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
                  textStyle:
                      TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadonlyDateField({
  required String label,
  required DateTime? date,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.calendar_today, color: Colors.teal),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Unesite $label';
        }
        return null;
      },
      controller: TextEditingController(
        text: date != null ? formatDate(date) : '',
      ),
    ),
  );
}

  Widget _buildCheckboxes() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_uslugeList.isEmpty) {
      return Center(child: Text("Problem prilikom učitavanja usluga."));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _uslugeList.length,
      itemBuilder: (context, index) {
        final option = _uslugeList[index];
        final int? uslugaId = option['uslugaID'] as int?;
        final String naziv = option['naziv'] ?? 'Unknown';
        final String cijena = option['cijena']?.toStringAsFixed(2) ?? '0.00';

        final isSelected = selectedUslugaIds.contains(uslugaId);

        return CheckboxListTile(
          activeColor: Colors.teal,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  naziv,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                'Cijena: $cijena KM',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          value: isSelected,
          onChanged: (bool? selected) {
            if (selected == true) {
              if (uslugaId != null && !selectedUslugaIds.contains(uslugaId)) {
                setState(() {
                  selectedUslugaIds.add(uslugaId);
                });
              }
            } else {
              if (uslugaId != null) {
                setState(() {
                  selectedUslugaIds.remove(uslugaId);
                });
              }
            }
          },
        );
      },
    );
  }

  String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  void _submitForm(int userId, GetUserResponse userData, int selectedRoomId) {
  if (datumRezervacije == null || zavrsetakRezervacije == null) {
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Molimo odaberite datume rezervacije",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    return;
  }

  _handlePaymentAndSubmit(userId, userData, selectedRoomId);
}

Future<Map<String, dynamic>?> _createPaymentIntent(
    int userId, int selectedRoomId) async {
  final url = Uri.parse("${BaseProvider.baseUrl}/Rezervacija/create-payment-intent");

   final request = RezervacijaInsertRequest(
    gostId: userId,
    sobaId: selectedRoomId,
    datumRezervacije: datumRezervacije!,
    zavrsetakRezervacije: zavrsetakRezervacije!,
    uslugaIds: selectedUslugaIds,
  );

  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final client = IOClient(ioc);

  try {
    final response = await client.post(
      url,
      body: jsonEncode(request.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  } catch (e) {
    print("Error: $e");
  }
  return null;
}

Future<void> _submitRezervacija(int userId, int selectedRoomId) async {
  final request = RezervacijaInsertRequest(
    gostId: userId,
    sobaId: selectedRoomId,
    datumRezervacije: datumRezervacije!,
    zavrsetakRezervacije: zavrsetakRezervacije!,
    uslugaIds: selectedUslugaIds,
  );
  final requestBody = jsonEncode(request.toJson());

  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final client = IOClient(ioc);

  final response = await client.post(
    Uri.parse("${BaseProvider.baseUrl}/Rezervacija"),
    body: requestBody,
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Uspjesno ste rezervisali sobu!",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
        int popCount = 0;
Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ListaRezervacijaScreen()),
        (route) => popCount++ == 4,
      );
    } else {
      throw Exception('Greška prilikom kreiranja rezervacije.');
    }
}

Future<void> _handlePaymentAndSubmit(
  int userId,
  GetUserResponse userData,
  int selectedRoomId,
) async {
  showLoadingDialog(context);

  try {
    final paymentIntentData = await _createPaymentIntent(userId, selectedRoomId);

    if (paymentIntentData == null) {
      throw Exception('Greška prilikom kreiranja Payment Intenta.');
    }

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData['clientSecret'],
        merchantDisplayName: 'Tvoja Firma',
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    await _submitRezervacija(userId, selectedRoomId);
  } catch (e) {
    Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Greska $e",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
  }
}

void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class RezervacijaInsertRequest {
  final int? gostId;
  final int? sobaId;
  final DateTime datumRezervacije;
  final DateTime zavrsetakRezervacije;
  final List<int> uslugaIds;

  RezervacijaInsertRequest({
    required this.gostId,
    required this.sobaId,
    required this.datumRezervacije,
    required this.zavrsetakRezervacije,
    required this.uslugaIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'gostId': gostId,
      'sobaId': sobaId,
      'datumRezervacije': datumRezervacije.toIso8601String(),
      'zavrsetakRezervacije': zavrsetakRezervacije.toIso8601String(),
      'uslugaIds': uslugaIds,
    };
  }
}



