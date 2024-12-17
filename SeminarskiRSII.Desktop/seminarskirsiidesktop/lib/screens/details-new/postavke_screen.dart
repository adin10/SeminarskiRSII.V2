// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../../providers/base_provider.dart';

// class PostavkeScreen extends StatefulWidget {
//   final int osobljeId;

//   PostavkeScreen({required this.osobljeId});

//   @override
//   _PostavkeScreenState createState() => _PostavkeScreenState();
// }

// class _PostavkeScreenState extends State<PostavkeScreen> {
//   late Future<Osoblje> osoblje;

//   @override
//   void initState() {
//     super.initState();
//     osoblje = fetchOsoblje(widget.osobljeId);
//   }

//   Future<Osoblje> fetchOsoblje(int id) async {
//     final response =
//         await http.get(Uri.parse("${BaseProvider.baseUrl}/Osoblje/$id"));

//     if (response.statusCode == 200) {
//       return Osoblje.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load osoblje');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Postavke'),
//       ),
//       body: FutureBuilder<Osoblje>(
//         future: osoblje,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No data found'));
//           } else {
//             Osoblje osobljeData = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   // Profile Image
//                   Center(
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: osobljeData.slika != null
//                           ? MemoryImage(Uint8List.fromList(osobljeData
//                               .slika!)) // Convert List<int> to Uint8List
//                           : AssetImage('assets/default_avatar.png')
//                               as ImageProvider,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // Name
//                   Text(
//                     '${osobljeData.ime} ${osobljeData.prezime}',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   // Email
//                   Text('Email: ${osobljeData.email}',
//                       style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 8),
//                   // Username
//                   Text('Username: ${osobljeData.korisnickoIme}',
//                       style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 8),
//                   // Phone
//                   Text('Phone: ${osobljeData.telefon}',
//                       style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 8),
//                   // Roles
//                   Text('Roles: ${osobljeData.uloge}',
//                       style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class Osoblje {
//   final int id;
//   final String ime;
//   final String prezime;
//   final String email;
//   final String korisnickoIme;
//   final String telefon;
//   final List<int>? slika; // byte array for image
//   final String uloge;

//   Osoblje({
//     required this.id,
//     required this.ime,
//     required this.prezime,
//     required this.email,
//     required this.korisnickoIme,
//     required this.telefon,
//     this.slika,
//     required this.uloge,
//   });

//   factory Osoblje.fromJson(Map<String, dynamic> json) {
//     return Osoblje(
//       id: json['id'],
//       ime: json['ime'],
//       prezime: json['prezime'],
//       email: json['email'],
//       korisnickoIme: json['korisnickoIme'],
//       telefon: json['telefon'],
//       // Base64 decode if 'slika' is a base64 string
//       slika: json['slika'] != null
//           ? base64Decode(json['slika']) // Decode base64 string to byte array
//           : null,
//       uloge: json['uloge'] ?? '',
//     );
//   }
// }




// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../../providers/base_provider.dart';

// class PostavkeScreen extends StatefulWidget {
//   final int osobljeId;

//   PostavkeScreen({required this.osobljeId});

//   @override
//   _PostavkeScreenState createState() => _PostavkeScreenState();
// }

// class _PostavkeScreenState extends State<PostavkeScreen> {
//   late Future<Osoblje> osoblje;

//   @override
//   void initState() {
//     super.initState();
//     osoblje = fetchOsoblje(widget.osobljeId);
//   }

//   Future<Osoblje> fetchOsoblje(int id) async {
//     final response = await http.get(Uri.parse("${BaseProvider.baseUrl}/Osoblje/$id"));

//     if (response.statusCode == 200) {
//       return Osoblje.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load osoblje');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Postavke'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: FutureBuilder<Osoblje>(
//         future: osoblje,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No data found'));
//           } else {
//             Osoblje osobljeData = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView(
//                 children: <Widget>[
//                   // Profile Image with rounded corners and shadow
//                   Center(
//                     child: CircleAvatar(
//                       radius: 60,
//                       backgroundImage: osobljeData.slika != null
//                           ? MemoryImage(Uint8List.fromList(osobljeData.slika!)) // Convert List<int> to Uint8List
//                           : AssetImage('assets/default_avatar.png') as ImageProvider,
//                       backgroundColor: Colors.transparent,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Name and personal information in a Card widget
//                   Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           // Name
//                           Text(
//                             '${osobljeData.ime} ${osobljeData.prezime}',
//                             style: TextStyle(
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           // Email
//                           Text(
//                             'Email: ${osobljeData.email}',
//                             style: TextStyle(fontSize: 16, color: Colors.black87),
//                           ),
//                           SizedBox(height: 8),
//                           // Username
//                           Text(
//                             'Username: ${osobljeData.korisnickoIme}',
//                             style: TextStyle(fontSize: 16, color: Colors.black87),
//                           ),
//                           SizedBox(height: 8),
//                           // Phone
//                           Text(
//                             'Phone: ${osobljeData.telefon}',
//                             style: TextStyle(fontSize: 16, color: Colors.black87),
//                           ),
//                           SizedBox(height: 8),
//                           // Roles
//                           Text(
//                             'Roles: ${osobljeData.uloge}',
//                             style: TextStyle(fontSize: 16, color: Colors.black87),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class Osoblje {
//   final int id;
//   final String ime;
//   final String prezime;
//   final String email;
//   final String korisnickoIme;
//   final String telefon;
//   final List<int>? slika; // byte array for image
//   final String uloge;

//   Osoblje({
//     required this.id,
//     required this.ime,
//     required this.prezime,
//     required this.email,
//     required this.korisnickoIme,
//     required this.telefon,
//     this.slika,
//     required this.uloge,
//   });

//   factory Osoblje.fromJson(Map<String, dynamic> json) {
//     return Osoblje(
//       id: json['id'],
//       ime: json['ime'],
//       prezime: json['prezime'],
//       email: json['email'],
//       korisnickoIme: json['korisnickoIme'],
//       telefon: json['telefon'],
//       slika: json['slika'] != null ? base64Decode(json['slika']) : null,
//       uloge: json['uloge'] ?? '',
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart'; // Make sure this is where your sidebar is defined

class PostavkeScreen extends StatefulWidget {
  final int osobljeId;

  PostavkeScreen({required this.osobljeId});

  @override
  _PostavkeScreenState createState() => _PostavkeScreenState();
}

class _PostavkeScreenState extends State<PostavkeScreen> {
  late Future<Osoblje> osoblje;

  @override
  void initState() {
    super.initState();
    osoblje = fetchOsoblje(widget.osobljeId);
  }

  Future<Osoblje> fetchOsoblje(int id) async {
    final response = await http.get(Uri.parse("${BaseProvider.baseUrl}/Osoblje/$id"));

    if (response.statusCode == 200) {
      return Osoblje.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load osoblje');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Postavke', // Sidebar title
      child: FutureBuilder<Osoblje>(
        future: osoblje,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            Osoblje osobljeData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  // Profile Image with rounded corners and shadow
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: osobljeData.slika != null
                          ? MemoryImage(Uint8List.fromList(osobljeData.slika!)) // Convert List<int> to Uint8List
                          : AssetImage('assets/default_avatar.png') as ImageProvider,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Name and personal information in a Card widget
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Name
                          Text(
                            '${osobljeData.ime} ${osobljeData.prezime}',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 10),
                          // Email
                          Text(
                            'Email: ${osobljeData.email}',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          // Username
                          Text(
                            'Username: ${osobljeData.korisnickoIme}',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        SizedBox(height: 8),
                          // Lozinka
                          Text(
                            'Lozinka: ${osobljeData.lozinka}',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          // Potvrdi lozinku
                          Text(
                            'Potvrdi lozinku: ${osobljeData.potvrdiLozinku}',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          // Phone
                          Text(
                            'Phone: ${osobljeData.telefon}',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          // Roles
                          Text(
                            'Roles: ${osobljeData.uloge}',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class Osoblje {
  final int id;
  final String ime;
  final String prezime;
  final String email;
  final String korisnickoIme;
  final String telefon;
  final String lozinka;
  final String potvrdiLozinku;
  final List<int>? slika; // byte array for image
  final String uloge;

  Osoblje({
    required this.id,
    required this.ime,
    required this.prezime,
    required this.email,
    required this.korisnickoIme,
    required this.telefon,
    required this.lozinka,
    required this.potvrdiLozinku,
    this.slika,
    required this.uloge,
  });

  factory Osoblje.fromJson(Map<String, dynamic> json) {
    return Osoblje(
      id: json['id'],
      ime: json['ime'],
      prezime: json['prezime'],
      email: json['email'],
      korisnickoIme: json['korisnickoIme'],
      telefon: json['telefon'],
      lozinka: json['lozinka'],
      potvrdiLozinku: json['potvrdiLozinku'],
      slika: json['slika'] != null ? base64Decode(json['slika']) : null,
      uloge: json['uloge'] ?? '',
    );
  }
}