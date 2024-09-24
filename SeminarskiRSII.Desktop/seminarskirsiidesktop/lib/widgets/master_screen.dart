// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:seminarskirsiidesktop/screens/lists/cjenovnik_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/recenzija_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/rezervacija_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/soba_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/sobaosoblje_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/sobastatus_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
// import '../screens/lists/gosti_list_screen.dart';
// import '../screens/lists/gradovi_list_screen.dart';
// import '../screens/lists/novosti_list_screen.dart';
// import '../screens/lists/osoblje_list_screen.dart';

// class MasterScreenWidget extends StatefulWidget {
//   Widget? child;
//   String? title;
//   MasterScreenWidget({this.child, this.title ,super.key});

//   @override
//   State<MasterScreenWidget> createState() => _MasterScreenState();
// }

// class _MasterScreenState extends State<MasterScreenWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? ''),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             ListTile(
//               title: Text('Gosti'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const GostiListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Osoblje'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const OsobljeListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Novosti'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const NovostiListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Gradovi'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const GradListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Drzave'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const DrzavaListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Rezervacije'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const RezervacijaListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Recenzije'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const RecenzijaListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Soba Status'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const SobaStatusListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Vrsta osoblja'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const VrstaOsobljaListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Cjenovnik'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const CjenovnikListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Soba'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const SobaListScreen()));
//               },
//             ),
//             ListTile(
//               title: Text('Soba osoblje'),
//               onTap: (){
//                      Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const SobaOsobljeListScreen()));
//               },
//             ),
//           ],
//         )
//         ),
//       body: widget.child!,
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:seminarskirsiidesktop/screens/lists/cjenovnik_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/recenzija_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/rezervacija_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/soba_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/sobaosoblje_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/sobastatus_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
// import '../screens/lists/gosti_list_screen.dart';
// import '../screens/lists/gradovi_list_screen.dart';
// import '../screens/lists/novosti_list_screen.dart';
// import '../screens/lists/osoblje_list_screen.dart';

// class MasterScreenWidget extends StatefulWidget {
//   Widget? child;
//   String? title;
//   MasterScreenWidget({this.child, this.title, super.key});

//   @override
//   State<MasterScreenWidget> createState() => _MasterScreenState();
// }

// class _MasterScreenState extends State<MasterScreenWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? ''),
//       ),
//       body: Row(
//         children: [
//           // Sidebar menu (Drawer replacement)
//           Container(
//             width: 250,
//             color: Colors.grey[200], // Light background color
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Smaller logo/header area with reduced height
//                 Container(
//                   height: 160, // Reduced height for the header
//                   color: Colors.blueAccent,
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Hotel AS',
//                     style: TextStyle(
//                       fontSize: 24,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 // List of menu items with icons
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       _buildMenuItem(Icons.people, 'Gosti', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const GostiListScreen()));
//                       }),
//                       _buildMenuItem(Icons.person, 'Osoblje', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const OsobljeListScreen()));
//                       }),
//                       _buildMenuItem(Icons.new_releases, 'Novosti', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const NovostiListScreen()));
//                       }),
//                       _buildMenuItem(Icons.location_city, 'Gradovi', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const GradListScreen()));
//                       }),
//                       _buildMenuItem(Icons.flag, 'Države', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const DrzavaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.book, 'Rezervacije', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const RezervacijaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.rate_review, 'Recenzije', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const RecenzijaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.hotel, 'Soba Status', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const SobaStatusListScreen()));
//                       }),
//                       _buildMenuItem(Icons.work, 'Vrsta Osoblja', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 const VrstaOsobljaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.attach_money, 'Cjenovnik', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const CjenovnikListScreen()));
//                       }),
//                       _buildMenuItem(Icons.bed, 'Soba', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const SobaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.group, 'Soba Osoblje', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 const SobaOsobljeListScreen()));
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Main content area
//           Expanded(
//             child: widget.child ?? Container(),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper function to build each menu item with icon and title
//   Widget _buildMenuItem(IconData icon, String title, Function() onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.blueAccent),
//       title: Text(
//         title,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//       ),
//       onTap: onTap,
//       hoverColor: Colors.blue[50],
//       tileColor: Colors.white,
//       contentPadding: EdgeInsets.symmetric(horizontal: 20),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:seminarskirsiidesktop/screens/lists/cjenovnik_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/drzava_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/recenzija_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/rezervacija_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/soba_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/sobaosoblje_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/sobastatus_list_screen.dart';
// import 'package:seminarskirsiidesktop/screens/lists/vrstaosoblja_list_screen.dart';
// import '../screens/lists/gosti_list_screen.dart';
// import '../screens/lists/gradovi_list_screen.dart';
// import '../screens/lists/novosti_list_screen.dart';
// import '../screens/lists/osoblje_list_screen.dart';

// class MasterScreenWidget extends StatefulWidget {
//   Widget? child;
//   String? title;
//   MasterScreenWidget({this.child, this.title, super.key});

//   @override
//   State<MasterScreenWidget> createState() => _MasterScreenState();
// }

// class _MasterScreenState extends State<MasterScreenWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? ''),
//       ),
//       body: Row(
//         children: [
//           // Sidebar menu (Drawer replacement)
//           Container(
//             width: 250,
//             color: Colors.grey[200], // Light background color
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Clickable logo/header area
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const NovostiListScreen()));
//                   },
//                   child: Container(
//                     height: 160, // Height for the header
//                     color: Colors.blueAccent,
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Hotel AS',
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // List of menu items with icons
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       _buildMenuItem(Icons.people, 'Gosti', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const GostiListScreen()));
//                       }),
//                       _buildMenuItem(Icons.person, 'Osoblje', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const OsobljeListScreen()));
//                       }),
//                       _buildMenuItem(Icons.new_releases, 'Novosti', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const NovostiListScreen()));
//                       }),
//                       _buildMenuItem(Icons.location_city, 'Gradovi', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const GradListScreen()));
//                       }),
//                       _buildMenuItem(Icons.flag, 'Države', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const DrzavaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.book, 'Rezervacije', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const RezervacijaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.rate_review, 'Recenzije', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const RecenzijaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.hotel, 'Soba Status', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const SobaStatusListScreen()));
//                       }),
//                       _buildMenuItem(Icons.work, 'Vrsta Osoblja', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 const VrstaOsobljaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.attach_money, 'Cjenovnik', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const CjenovnikListScreen()));
//                       }),
//                       _buildMenuItem(Icons.bed, 'Soba', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const SobaListScreen()));
//                       }),
//                       _buildMenuItem(Icons.group, 'Soba Osoblje', () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 const SobaOsobljeListScreen()));
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Main content area
//           Expanded(
//             child: widget.child ?? Container(),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper function to build each menu item with icon and title
//   Widget _buildMenuItem(IconData icon, String title, Function() onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.blueAccent),
//       title: Text(
//         title,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//       ),
//       onTap: onTap,
//       hoverColor: Colors.blue[50],
//       tileColor: Colors.white,
//       contentPadding: EdgeInsets.symmetric(horizontal: 20),
//     );
//   }
// }






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
            width: 250,
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
                    height: 160, // Height for the header
                    color: Colors.blueAccent,
                    alignment: Alignment.center,
                    child: Text(
                      'Hotel AS',
                      style: TextStyle(
                        fontSize: 24,
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