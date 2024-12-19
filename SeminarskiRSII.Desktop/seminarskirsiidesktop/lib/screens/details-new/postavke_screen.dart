
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:seminarskirsiidesktop/screens/details-new/change_password_screen.dart';
// import '../../providers/base_provider.dart';
// import '../../widgets/master_screen.dart'; // Make sure this is where your sidebar is defined

// class PostavkeScreen extends StatefulWidget {
//   final int osobljeId;

//   const PostavkeScreen({super.key, required this.osobljeId});

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
//     return MasterScreenWidget(
//       title: 'Postavke', // Sidebar title
//       child: FutureBuilder<Osoblje>(
//         future: osoblje,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return const Center(child: Text('No data found'));
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
//                           ? MemoryImage(Uint8List.fromList(osobljeData
//                               .slika!)) // Convert List<int> to Uint8List
//                           : const AssetImage('assets/default_avatar.png')
//                               as ImageProvider,
//                       backgroundColor: Colors.transparent,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
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
//                             style: const TextStyle(
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           // Email
//                           Text(
//                             'Email: ${osobljeData.email}',
//                             style: const TextStyle(
//                                 fontSize: 16, color: Colors.black87),
//                           ),
//                           const SizedBox(height: 8),
//                           // Username
//                           Text(
//                             'Username: ${osobljeData.korisnickoIme}',
//                             style: const TextStyle(
//                                 fontSize: 16, color: Colors.black87),
//                           ),
//                           // const SizedBox(height: 8),
//                           //   // Lozinka
//                           //   Text(
//                           //     'Lozinka: ${osobljeData.lozinka}',
//                           //     style: const TextStyle(fontSize: 16, color: Colors.black87),
//                           //   ),
//                           //   const SizedBox(height: 8),
//                           //   // Potvrdi lozinku
//                           //   Text(
//                           //     'Potvrdi lozinku: ${osobljeData.potvrdiLozinku}',
//                           //     style: const TextStyle(fontSize: 16, color: Colors.black87),
//                           //   ),
//                           const SizedBox(height: 8),
//                           // Phone
//                           Text(
//                             'Phone: ${osobljeData.telefon}',
//                             style: const TextStyle(
//                                 fontSize: 16, color: Colors.black87),
//                           ),
//                           const SizedBox(height: 8),
//                           // Roles
//                           Text(
//                             'Roles: ${osobljeData.uloge.join(', ')}',
//                             style: const TextStyle(
//                                 fontSize: 16, color: Colors.black87),
//                           ),
//                           const SizedBox(height: 8),
//                           const SizedBox(height: 8),
//                           // Password
//                           Text(
//                             'Password: ••••••••', // Indication of password being set
//                             style: const TextStyle(
//                                 fontSize: 16, color: Colors.black87),
//                           ),
//                           const SizedBox(height: 16),
//                           // Button to open ChangePasswordScreen
//                           ElevatedButton(
//                             onPressed: () {
//                               // Navigate to the ChangePasswordScreen
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ChangePasswordScreen(
//                                     userId: widget.osobljeId,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: const Text('Change Password'),
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
//   // final String lozinka;
//   // final String potvrdiLozinku;
//   final List<int>? slika; // byte array for image
//   final List<String> uloge;

//   Osoblje({
//     required this.id,
//     required this.ime,
//     required this.prezime,
//     required this.email,
//     required this.korisnickoIme,
//     required this.telefon,
//     // required this.lozinka,
//     // required this.potvrdiLozinku,
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
//       // lozinka: json['lozinka'],
//       // potvrdiLozinku: json['potvrdiLozinku'],
//       slika: json['slika'] != null ? base64Decode(json['slika']) : null,
//       uloge: (json['osobljeUloge'] as List<dynamic>?) // Safely handle null
//               ?.map((uloga) =>
//                   uloga['vrstaOsoblja']?['pozicija'] ?? '') // Extract pozicija
//               .where(
//                   (pozicija) => pozicija.isNotEmpty) // Filter non-empty values
//               .toList()
//               .cast<String>() ?? // Explicitly cast to List<String>
//           [], // Default to empty list if null
//     );
//   }
// }



import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seminarskirsiidesktop/screens/details-new/change_password_screen.dart';
import '../../providers/base_provider.dart';
import '../../widgets/master_screen.dart'; // Ensure this is where your sidebar is defined

class PostavkeScreen extends StatefulWidget {
  final int osobljeId;

  const PostavkeScreen({super.key, required this.osobljeId});

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
    final response =
        await http.get(Uri.parse("${BaseProvider.baseUrl}/Osoblje/$id"));

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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
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
                          ? MemoryImage(Uint8List.fromList(osobljeData
                              .slika!)) // Convert List<int> to Uint8List
                          : const AssetImage('assets/default_avatar.png')
                              as ImageProvider,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Email
                          Text(
                            'Email: ${osobljeData.email}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          // Phone
                          Text(
                            'Phone: ${osobljeData.telefon}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          // Roles
                          Text(
                            'Roles: ${osobljeData.uloge.join(', ')}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Second card for username and password
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
                          // Username
                          Text(
                            'Username: ${osobljeData.korisnickoIme}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          // Password
                          Text(
                            'Password: ••••••••', // Indication of password being set
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 16),
                          // Button to open ChangePasswordScreen
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to the ChangePasswordScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen(
                                    userId: widget.osobljeId,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Change Password'),
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
  final List<int>? slika; // byte array for image
  final List<String> uloge; // List of pozicija (positions)

  Osoblje({
    required this.id,
    required this.ime,
    required this.prezime,
    required this.email,
    required this.korisnickoIme,
    required this.telefon,
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
      slika: json['slika'] != null ? base64Decode(json['slika']) : null,
      uloge: (json['osobljeUloge'] as List<dynamic>?)
              ?.map((uloga) =>
                  uloga['vrstaOsoblja']?['pozicija'] ?? '') 
              .where((pozicija) => pozicija.isNotEmpty) 
              .toList()
              .cast<String>() ?? 
          [], 
    );
  }
}
