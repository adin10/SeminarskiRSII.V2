import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seminarskirsiidesktop/screens/lists/cjenovnik_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/recenzija_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/rezervacija_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/soba_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/sobaosoblje_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/sobastatus_list_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
import '../screens/lists/gosti_list_screen.dart';
import '../screens/lists/gradovi_list_screen.dart';
import '../screens/lists/novosti_list_screen.dart';
import '../screens/lists/osoblje_list_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreenWidget({this.child, this.title ,super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Gosti'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const GostiListScreen()));
              },
            ),
            ListTile(
              title: Text('Osoblje'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OsobljeListScreen()));
              },
            ),
            ListTile(
              title: Text('Novosti'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NovostiListScreen()));
              },
            ),
            ListTile(
              title: Text('Gradovi'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const GradListScreen()));
              },
            ),
            ListTile(
              title: Text('Drzave'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DrzavaListScreen()));
              },
            ),
            ListTile(
              title: Text('Rezervacije'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RezervacijaListScreen()));
              },
            ),
            ListTile(
              title: Text('Recenzije'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RecenzijaListScreen()));
              },
            ),
            ListTile(
              title: Text('Soba Status'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SobaStatusListScreen()));
              },
            ),
            ListTile(
              title: Text('Vrsta osoblja'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const VrstaOsobljaListScreen()));
              },
            ),
            ListTile(
              title: Text('Cjenovnik'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CjenovnikListScreen()));
              },
            ),
            ListTile(
              title: Text('Soba'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SobaListScreen()));
              },
            ),
            ListTile(
              title: Text('Soba osoblje'),
              onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SobaOsobljeListScreen()));
              },
            ),
          ],
        )
        ),
      body: widget.child!,
    );
  }
}