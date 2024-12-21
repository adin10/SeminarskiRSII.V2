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
        title: Text('Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // buildOptionCard(
            //   context,
            //   'Free Rooms',
            //   Icons.hotel,
            //   SobeScreen.sobeRouteName,
            // ),
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
              'Your Reservations',
              Icons.book,
              ListaRezervacijaScreen.listaRezervacijaRouteName,
              null
            ),
            buildOptionCard(
              context,
              'Postavke',
              Icons.settings,
              PostavkeScreen.routeName, // Add the route for settings when available
              userData
            ),
            // Add logout option
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

  // Logout logic
// Logout card widget
  Widget buildLogoutCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Handle logout logic here
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

  // Logout logic
  void logout(BuildContext context) {
    // Clear the user ID and any other session data
    loggedUserID = 0; // Reset the logged-in user ID (ensure this is a global variable)

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/', // The route name for the HomePage (login screen)
      (Route<dynamic> route) => false, // This removes all previous routes
    );
  }

}
