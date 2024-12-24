import 'package:flutter/material.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/screens/change_password_screen.dart';

class PostavkeScreen extends StatelessWidget {
  static const String routeName = '/postavke';

  @override
  Widget build(BuildContext context) {
    final GetUserResponse? userData =
        ModalRoute.of(context)?.settings.arguments as GetUserResponse?;

    if (userData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Missing user data. Please go back and try again.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Postavke"),
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
                color: Color.fromARGB(255, 230, 240, 230),
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
                      SizedBox(height: 16),
                      buildUserInfoRow(
                          label: 'Ime i prezime:',
                          value: '${userData.ime} ${userData.prezime}'),
                      buildUserInfoRow(
                          label: 'Korisnicko ime:',
                          value: userData.korisnickoIme ?? ''),
                      Divider(thickness: 1, color: Colors.grey[400]),
                      buildUserInfoRow(
                          label: 'Email:', value: userData.email ?? ''),
                      buildUserInfoRow(
                          label: 'Telefon:', value: userData.telefon ?? ''),
                      SizedBox(height: 16),
                      buildUserInfoRow(label: 'Lozinka:', value: '******'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ChangePasswordScreen.routeName);
                        },
                        child: Text("Promjenite vasu lozinku"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: TextStyle(
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
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
