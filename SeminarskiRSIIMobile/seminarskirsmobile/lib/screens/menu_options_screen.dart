import 'package:flutter/material.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/providers/globals.dart';
import 'package:seminarskirsmobile/screens/lista_rezervacija_screen.dart';
import 'package:seminarskirsmobile/screens/novosti_screen.dart';
import 'package:seminarskirsmobile/screens/odabir_sobe_screen.dart';
import 'package:seminarskirsmobile/screens/postavke_screen.dart';
import 'package:seminarskirsmobile/screens/recommendation_screen.dart';
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
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              buildOptionCardCustomNavigation(
                context,
                'Rezervisi sobu',
                Icons.hotel,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OdabirDatumaScreen(
                        userData: userData,
                        userId: userData.id,
                      ),
                    ),
                  );
                },
              ),
              buildOptionCard(
                context,
                'Novosti',
                Icons.article,
                NovostiScreen.novostiRouteName,
                null,
              ),
              buildOptionCard(
                context,
                'Vaše rezervacije',
                Icons.book,
                ListaRezervacijaScreen.listaRezervacijaRouteName,
                null,
              ),
              buildOptionCard(
                context,
                'Postavke',
                Icons.settings,
                PostavkeScreen.routeName,
                userData,
              ),
              buildLogoutCard(context),
              buildOptionCardCustomNavigation(
                context,
                'Recommendation system',
                Icons.hotel,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecommendationScreen(
                        userData: userData,
                        userId: userData.id,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionCardCustomNavigation(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.white),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal.shade900,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Colors.teal.shade300, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionCard(BuildContext context, String title, IconData icon,
      String? routeName, GetUserResponse? userData) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          if (routeName != null) {
            Navigator.pushNamed(context, routeName, arguments: userData);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.white),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal.shade900,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Colors.teal.shade300, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogoutCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          logout(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.logout, size: 32, color: Colors.white),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Colors.red.shade300, size: 18),
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
