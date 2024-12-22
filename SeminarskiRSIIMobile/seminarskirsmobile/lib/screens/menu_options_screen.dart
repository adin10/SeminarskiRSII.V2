import 'package:flutter/material.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/providers/globals.dart';
import 'package:seminarskirsmobile/screens/lista_rezervacija_screen.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/postavke_screen.dart';
import 'package:seminarskirsmobile/screens/sobe_screen.dart';

class OptionsScreen extends StatelessWidget {
  static const optionsRouteName = '/options';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final GetUserResponse userData = routeArgs?['userData'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel AS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildOptionCard(
              context,
              'Slobodne sobe',
              Icons.hotel,
              SobeScreen.sobeRouteName,
              userData
            ),
            buildOptionCard(
              context,
              'News',
              Icons.article,
              NovostiScreen.novostiRouteName,
              null
            ),
            buildOptionCard(
              context,
              'Vase rezervacije',
              Icons.book,
              ListaRezervacijaScreen.listaRezervacijaRouteName,
              null
            ),
            buildOptionCard(
              context,
              'Postavke',
              Icons.settings,
              PostavkeScreen.routeName,
              userData
            ),
            buildLogoutCard(context),
          ],
        ),
      ),
    );
  }

  Widget buildOptionCard(
      BuildContext context, String title, IconData icon, String? routeName,
      GetUserResponse? userData) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: InkWell(
        onTap: () {
          if (routeName != null) {
            Navigator.pushNamed(context, routeName, arguments: userData);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogoutCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: InkWell(
        onTap: () {
          logout(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.logout, size: 40),
              SizedBox(width: 16),
              Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    loggedUserID = 0;

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (Route<dynamic> route) => false,
    );
  }

}
