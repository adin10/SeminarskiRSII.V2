import 'package:flutter/material.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/screens/change_password_screen.dart';
import 'package:seminarskirsmobile/screens/update_profile_screen.dart';

class PostavkeScreen extends StatefulWidget {
  static const String routeName = '/postavke';

  @override
  _PostavkeScreenState createState() => _PostavkeScreenState();
}

class _PostavkeScreenState extends State<PostavkeScreen> {
  GetUserResponse? userData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (userData == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is GetUserResponse) {
        userData = args;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Greška')),
        body: const Center(
          child: Text('Podaci o korisniku nisu dostupni.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Postavke"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color.fromARGB(255, 230, 240, 230),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informacije o vama",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildUserInfoRow(
                          label: 'Ime i prezime:',
                          value: '${userData!.ime} ${userData!.prezime}'),
                      buildUserInfoRow(
                          label: 'Korisničko ime:',
                          value: userData!.korisnickoIme ?? ''),
                      Divider(thickness: 1, color: Colors.grey[400]),
                      buildUserInfoRow(
                          label: 'Email:', value: userData!.email ?? ''),
                      buildUserInfoRow(
                          label: 'Telefon:', value: userData!.telefon ?? ''),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final updatedUser =
                              await Navigator.pushNamed(
                            context,
                            UpdateProfileScreen.routeName,
                            arguments: userData,
                          ) as GetUserResponse?;

                          if (updatedUser != null) {
                            setState(() {
                              userData = updatedUser;
                            });
                          }
                        },
                        child: const Text("Uredite vaše podatke"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildUserInfoRow(label: 'Lozinka:', value: '******'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ChangePasswordScreen.routeName,
                          );
                        },
                        child: const Text("Promijenite vašu lozinku"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.teal[800],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

