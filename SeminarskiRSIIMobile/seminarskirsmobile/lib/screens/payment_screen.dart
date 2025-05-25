// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:seminarskirsmobile/main.dart';
// import 'package:seminarskirsmobile/providers/base_provider.dart';
// import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

// class PaymentScreen extends StatefulWidget {
//   final int userId;
//   final GetUserResponse userData;
//   final int selectedRoomId;
//   final DateTime datumRezervacije;
//   final DateTime zavrsetakRezervacije;
//   final List<int> selectedUslugaIds;

//   PaymentScreen({
//     required this.userId,
//     required this.userData,
//     required this.selectedRoomId,
//     required this.datumRezervacije,
//     required this.zavrsetakRezervacije,
//     required this.selectedUslugaIds,
//   });

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   bool _loading = false;

//   Future<Map<String, dynamic>?> _createPaymentIntent() async {
//     final url = Uri.parse("${BaseProvider.baseUrl}/Payment/create-payment-intent");
//     try {
//       final response = await http.post(url);
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       }
//     } catch (e) {
//       print("Error creating payment intent: $e");
//     }
//     return null;
//   }

//   Future<void> _handlePayment() async {
//     setState(() {
//       _loading = true;
//     });

//     try {
//       final paymentIntentData = await _createPaymentIntent();

//       if (paymentIntentData == null) {
//         throw Exception('Failed to create Payment Intent');
//       }

//       // Initialize payment sheet with the client secret from backend
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentData['clientSecret'],
//           merchantDisplayName: 'Tvoja Firma',
//           // customerId, customerEphemeralKeySecret itd. možeš dodati ako koristiš Stripe Customer
//         ),
//       );

//       // Present payment sheet to user
//       await Stripe.instance.presentPaymentSheet();

//       // Ako je naplata uspjela, kreiraj rezervaciju
//       _submitRezervacija();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Uspješna naplata!')),
//       );
//     } catch (e) {
//       if (e is StripeException) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Naplatna greška: ${e.error.localizedMessage}')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Nešto nije u redu: $e')),
//         );
//       }
//     } finally {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   void _submitRezervacija() {
//     final request = RezervacijaInsertRequest(
//       gostId: widget.userId,
//       sobaId: widget.selectedRoomId,
//       datumRezervacije: widget.datumRezervacije,
//       zavrsetakRezervacije: widget.zavrsetakRezervacije,
//       uslugaIds: widget.selectedUslugaIds,
//     );
//     print(request);

//     final requestBody = jsonEncode(request.toJson());

//     // Pošalji zahtjev za kreiranje rezervacije
//     // Ovdje možeš staviti isti dio koda iz tvog _submitForm ili pozvati API provider
//     // Za primjer:
//     http.post(
//       Uri.parse("${BaseProvider.baseUrl}/Rezervacija"),
//       body: requestBody,
//       headers: {'Content-Type': 'application/json'},
//     ).then((response) {
//       if (response.statusCode == 200) {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Greška prilikom kreiranja rezervacije')),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Naplatite rezervaciju'),
//       ),
//       body: Center(
//         child: _loading
//             ? CircularProgressIndicator()
//             : ElevatedButton(
//                 child: Text('Plati'),
//                 onPressed: _handlePayment,
//               ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:convert';
import 'dart:io';

import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/providers/base_provider.dart';
import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int userId;
  final GetUserResponse userData;
  final int selectedRoomId;
  final DateTime datumRezervacije;
  final DateTime zavrsetakRezervacije;
  final List<int> selectedUslugaIds;

  PaymentScreen({
    required this.userId,
    required this.userData,
    required this.selectedRoomId,
    required this.datumRezervacije,
    required this.zavrsetakRezervacije,
    required this.selectedUslugaIds,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _loading = false;

  Future<Map<String, dynamic>?> _createPaymentIntent() async {
    final url = Uri.parse("${BaseProvider.baseUrl}/Payment/create-payment-intent");

    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final client = IOClient(ioc);

    try {
      final response = await client.post(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Greška pri dohvatanju payment intent: ${response.statusCode}");
      }
    } catch (e) {
      print("Error creating payment intent: $e");
    }
    return null;
  }

  Future<void> _handlePayment() async {
    setState(() {
      _loading = true;
    });

    try {
      final paymentIntentData = await _createPaymentIntent();

      if (paymentIntentData == null) {
        throw Exception('Failed to create Payment Intent');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['clientSecret'],
          merchantDisplayName: 'Tvoja Firma',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      _submitRezervacija();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Uspješna naplata!')),
      );
    } catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Naplatna greška: ${e.error.localizedMessage}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nešto nije u redu: $e')),
        );
        print(e);
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _submitRezervacija() {
    final request = RezervacijaInsertRequest(
      gostId: widget.userId,
      sobaId: widget.selectedRoomId,
      datumRezervacije: widget.datumRezervacije,
      zavrsetakRezervacije: widget.zavrsetakRezervacije,
      uslugaIds: widget.selectedUslugaIds,
    );
    final requestBody = jsonEncode(request.toJson());

    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);

    httpClient.post(
      Uri.parse("${BaseProvider.baseUrl}/Rezervacija"),
      body: requestBody,
      headers: {'Content-Type': 'application/json'},
    ).then((response) {
      if (response.statusCode == 200) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Greška prilikom kreiranja rezervacije')),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Greška: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naplatite rezervaciju'),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : ElevatedButton(
                child: Text('Plati'),
                onPressed: _handlePayment,
              ),
      ),
    );
  }
}
