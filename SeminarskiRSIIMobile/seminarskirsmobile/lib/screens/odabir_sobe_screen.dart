// import 'package:flutter/material.dart';
// import 'package:seminarskirsmobile/main.dart';
// import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';
// import 'package:seminarskirsmobile/screens/sobe_screen.dart';
// import '../providers/sobe_provider.dart';
// import 'package:seminarskirsmobile/screens/odabir_sobe_screen.dart';


// class OdabirDatumaScreen extends StatefulWidget {
//   static const String routeName = '/odabirDatuma';

//   final GetUserResponse userData;
//   final int userId;

//   const OdabirDatumaScreen({
//     required this.userData,
//     required this.userId,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _OdabirDatumaScreenState createState() => _OdabirDatumaScreenState();
// }

// class _OdabirDatumaScreenState extends State<OdabirDatumaScreen> {
//   DateTime? datumRezervacije;
//   DateTime? zavrsetakRezervacije;
//   List<dynamic> slobodneSobe = [];
//   bool isLoading = false;

//   void fetchSlobodneSobe() async {
//     if (datumRezervacije == null || zavrsetakRezervacije == null) return;

//     setState(() => isLoading = true);
//     try {
//       var result = await SobaProvider().getFiltered({
//         'datumOd': datumRezervacije!.toIso8601String(),
//         'datumDo': zavrsetakRezervacije!.toIso8601String()
//       });
//       setState(() => slobodneSobe = result);
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Greška prilikom učitavanja soba.")));
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Widget _buildDateField(String label, DateTime? date, Function(DateTime) onPicked) {
//     return TextFormField(
//       readOnly: true,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//         contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       ),
//       controller: TextEditingController(
//         text: date != null ? "${date.day}.${date.month}.${date.year}" : '',
//       ),
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime(2100),
//         );
//         if (picked != null) {
//           onPicked(picked);
//           if (datumRezervacije != null && zavrsetakRezervacije != null) {
//             fetchSlobodneSobe();
//           }
//         }
//       },
//       validator: (value) => value == null || value.isEmpty ? 'Unesite $label' : null,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Odaberite datume"), backgroundColor: Colors.teal),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildDateField("Datum početka", datumRezervacije, (picked) {
//               setState(() => datumRezervacije = picked);
//             }),
//             SizedBox(height: 16),
//             _buildDateField("Datum završetka", zavrsetakRezervacije, (picked) {
//               setState(() => zavrsetakRezervacije = picked);
//             }),
//             SizedBox(height: 24),
//             if (isLoading)
//               Center(child: CircularProgressIndicator())
//             else if (slobodneSobe.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: slobodneSobe.length,
//                   itemBuilder: (context, index) {
//                     final soba = slobodneSobe[index];
//                     return ListTile(
//                       title: Text("Soba: ${soba['brojSobe']}"),
//                       // subtitle: Text("Tip: ${soba['tipSobeNaziv']}"),
//                       trailing: Icon(Icons.arrow_forward_ios),
//                       onTap: () {
//                         IdGetter.Id = soba['sobaID'];
//                         Navigator.pushNamed(
//                           context,
//                           SobeScreen.sobeRouteName,
//                           arguments: {
//                             'userData': widget.userData,
//                             'datumOd': datumRezervacije,
//                             'datumDo': zavrsetakRezervacije,
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//               )
//             else
//               Text("Nema slobodnih soba za odabrani period."),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class IdGetter {
//   static int Id = 0;
// }


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

  // void _onSearchRoomsPressed() {
  //   if (datumRezervacije != null && zavrsetakRezervacije != null) {
  //     Navigator.pushNamed(
  //       context,
  //       SobeScreen.sobeRouteName,
  //       arguments: {
  //         'userData': widget.userData,
  //         'datumOd': datumRezervacije,
  //         'datumDo': zavrsetakRezervacije,
  //       },
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Molimo odaberite oba datuma prije pretrage."),
  //     ));
  //   }
  // }

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
            SizedBox(height: 40), // Veći razmak od vrha
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
