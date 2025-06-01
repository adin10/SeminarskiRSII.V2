import 'package:flutter/material.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/screens/sobe_screen.dart';
import '../providers/sobe_provider.dart';

class OdabirDatumaScreen extends StatefulWidget {
  static const String routeName = '/odabirDatuma';

  final GetUserResponse userData;
  final int userId;

  const OdabirDatumaScreen({
    required this.userData,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  _OdabirDatumaScreenState createState() => _OdabirDatumaScreenState();
}

class _OdabirDatumaScreenState extends State<OdabirDatumaScreen> {
  DateTime? datumRezervacije;
  DateTime? zavrsetakRezervacije;
  bool isLoading = false;

  Widget _buildDateField(String label, DateTime? date, Function(DateTime) onPicked) {
  return TextFormField(
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.teal),
      filled: true,
      fillColor: Colors.teal.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      prefixIcon: Icon(Icons.calendar_today, color: Colors.teal),
    ),
    controller: TextEditingController(
      text: date != null ? "${date.day}.${date.month}.${date.year}" : '',
    ),
    onTap: () async {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        onPicked(picked);
      }
    },
    validator: (value) => value == null || value.isEmpty ? 'Unesite $label' : null,
  );
}

void _onSearchRoomsPressed() {
  if (datumRezervacije == null || zavrsetakRezervacije == null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Molimo odaberite oba datuma prije pretrage."),
    ));
    return;
  }

  if (zavrsetakRezervacije!.isAtSameMomentAs(datumRezervacije!)) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Datum završetka mora biti veci od datuma početka."),
    ));
    return;
  }

  if (zavrsetakRezervacije!.isBefore(datumRezervacije!)) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Datum završetka mora biti nakon datuma početka."),
    ));
    return;
  }

  Navigator.pushNamed(
    context,
    SobeScreen.sobeRouteName,
    arguments: {
      'userData': widget.userData,
      'datumOd': datumRezervacije,
      'datumDo': zavrsetakRezervacije,
    },
  );
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Odaberite datume"),
      backgroundColor: Colors.teal,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            _buildDateField("Datum početka", datumRezervacije, (picked) {
              setState(() => datumRezervacije = picked);
            }),
            SizedBox(height: 20),
            _buildDateField("Datum završetka", zavrsetakRezervacije, (picked) {
              setState(() => zavrsetakRezervacije = picked);
            }),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
               elevation: 4,
               backgroundColor: Colors.teal,
               foregroundColor: Colors.white,
               textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: _onSearchRoomsPressed,
              child: Text(
                "Pretraži slobodne sobe",
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
