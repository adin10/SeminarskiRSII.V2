import 'package:flutter/material.dart';
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
  MasterScreenWidget({this.child, this.title, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreenWidget> {
  // To store the hovered index
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Row(
        children: [
          // Sidebar menu (Drawer replacement)
          Container(
            width: 280,
            color: Colors.grey[200], // Light background color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Clickable logo/header area
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NovostiListScreen()));
                  },
                  child: Container(
                    height: 110, // Height for the header
                    color: Colors.blueAccent,
                    alignment: Alignment.center,
                    child: Text(
                      'Hotel AS',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // List of menu items with icons
                Expanded(
                  child: ListView(
                    children: [
                      _buildMenuItem(Icons.people, 'Gosti', 0, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GostiListScreen()));
                      }),
                      _buildMenuItem(Icons.person, 'Osoblje', 1, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OsobljeListScreen()));
                      }),
                      _buildMenuItem(Icons.new_releases, 'Novosti', 2, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NovostiListScreen()));
                      }),
                      _buildMenuItem(Icons.location_city, 'Gradovi', 3, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GradListScreen()));
                      }),
                      _buildMenuItem(Icons.flag, 'Države', 4, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const DrzavaListScreen()));
                      }),
                      _buildMenuItem(Icons.book, 'Rezervacije', 5, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RezervacijaListScreen()));
                      }),
                      _buildMenuItem(Icons.rate_review, 'Recenzije', 6, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RecenzijaListScreen()));
                      }),
                      _buildMenuItem(Icons.hotel, 'Soba Status', 7, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SobaStatusListScreen()));
                      }),
                      _buildMenuItem(Icons.work, 'Vrsta Osoblja', 8, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const VrstaOsobljaListScreen()));
                      }),
                      _buildMenuItem(Icons.attach_money, 'Cjenovnik', 9, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CjenovnikListScreen()));
                      }),
                      _buildMenuItem(Icons.bed, 'Soba', 10, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SobaListScreen()));
                      }),
                      _buildMenuItem(Icons.group, 'Soba Osoblje', 11, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const SobaOsobljeListScreen()));
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: widget.child ?? Container(),
          ),
        ],
      ),
    );
  }

  // Helper function to build each menu item with icon, title, and hover effect
  Widget _buildMenuItem(IconData icon, String title, int index, Function() onTap) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredIndex = null;
        });
      },
      child: Container(
        color: hoveredIndex == index ? Colors.blue[100] : Colors.white, // Hover effect
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}