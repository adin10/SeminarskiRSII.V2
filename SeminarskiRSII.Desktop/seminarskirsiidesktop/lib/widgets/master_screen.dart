// import 'package:flutter/material.dart';
// import 'package:seminarskirsiidesktop/screens/details-new/postavke_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../main.dart';
// import '../screens/lists/cjenovnik_list_screen.dart';
// import '../screens/lists/drzava_list_screen.dart';
// import '../screens/lists/gosti_list_screen.dart';
// import '../screens/lists/gradovi_list_screen.dart';
// import '../screens/lists/novosti_list_screen.dart';
// import '../screens/lists/osoblje_list_screen.dart';
// import '../screens/lists/recenzija_list_screen.dart';
// import '../screens/lists/rezervacija_list_screen.dart';
// import '../screens/lists/soba_list_screen.dart';
// import '../screens/lists/sobaosoblje_list_screen.dart';
// import '../screens/lists/sobastatus_list_screen.dart';
// import '../screens/lists/vrstaosoblja_list_screen.dart';

// class MasterScreenWidget extends StatefulWidget {
//   Widget? child;
//   String? title;
//   MasterScreenWidget({this.child, this.title, super.key});

//   @override
//   State<MasterScreenWidget> createState() => _MasterScreenState();
// }

// class _MasterScreenState extends State<MasterScreenWidget> {
//   int? hoveredIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.blueAccent,
//         title: Text(
//           widget.title ?? '',
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Row(
//         children: [
//           // Sidebar
//           Container(
//             width: 280,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Logo/Header
//                 Container(
//                   height: 100,
//                   color: Colors.blueAccent,
//                   alignment: Alignment.center,
//                   child: const Text(
//                     'Hotel AS',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 // Sidebar Menu
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     children: [
//                       _buildMenuItem(Icons.people, 'Gosti', 0, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const GostiListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.person, 'Osoblje', 1, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const OsobljeListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.new_releases, 'Novosti', 2, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const NovostiListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.location_city, 'Gradovi', 3, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const GradListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.flag, 'Države', 4, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const DrzavaListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.book, 'Rezervacije', 5, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const RezervacijaListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.rate_review, 'Recenzije', 6, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const RecenzijaListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.hotel, 'Soba Status', 7, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const SobaStatusListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.work, 'Vrsta Osoblja', 8, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const VrstaOsobljaListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.attach_money, 'Cjenovnik', 9, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const CjenovnikListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.bed, 'Soba', 10, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const SobaListScreen(),
//                         ));
//                       }),
//                       _buildMenuItem(Icons.group, 'Soba Osoblje', 11, () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const SobaOsobljeListScreen(),
//                         ));
//                       }),
//                       // _buildMenuItem(Icons.group, 'Postavke', 12, () {
//                       //   Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (context) => PostavkeScreen(osobljeId: userId),
//                       //   ));
//                       // }),
//                       _buildMenuItem(Icons.group, 'Postavke', 12, () async {
//                         final prefs = await SharedPreferences.getInstance();
//                         final int? userId = prefs.getInt('loggedInUserId');

//                         if (userId != null) {
//                           // If userId is available, navigate to PostavkeScreen
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 PostavkeScreen(osobljeId: userId),
//                           ));
//                         } else {
//                           // If userId is not available, show error toast
//                           showErrorToast(context,
//                               'Unable to retrieve user ID. Please log in again.');
//                         }
//                       }),
//                       _buildMenuItem(Icons.logout, 'Logout', 13, () {
//                         _handleLogout(context);
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Main Content
//           Expanded(
//             child: widget.child ?? Container(),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper function to build menu items
//   Widget _buildMenuItem(
//       IconData icon, String title, int index, Function() onTap) {
//     return MouseRegion(
//       onEnter: (_) {
//         setState(() {
//           hoveredIndex = index;
//         });
//       },
//       onExit: (_) {
//         setState(() {
//           hoveredIndex = null;
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         decoration: BoxDecoration(
//           color: hoveredIndex == index ? Colors.blue[100] : Colors.transparent,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: hoveredIndex == index
//               ? [
//                   const BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ]
//               : [],
//         ),
//         child: ListTile(
//           leading: Icon(icon, color: Colors.white, size: 28),
//           title: Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.white,
//             ),
//           ),
//           onTap: onTap,
//         ),
//       ),
//     );
//   }

// Future<void> _navigateToPostavke(BuildContext context) async {
//   final prefs = await SharedPreferences.getInstance();
//   final int? userId = prefs.getInt('loggedInUserId');

//   if (userId != null) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => PostavkeScreen(osobljeId: userId),
//       ),
//     );
//   } else {
//     _showErrorSnackBar();
//   }
// }

// void _showErrorSnackBar() {
//   showErrorToast(context, 'Error occurred. Please try again later.');
// }

// void showErrorToast(BuildContext context, String message) {
//   final overlay = Overlay.of(context);
//   final overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: 20, // Position the toast at the top
//       left: MediaQuery.of(context).size.width * 0.15, // Center horizontally with reduced width
//       width: MediaQuery.of(context).size.width * 0.7, // Reduced width
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//           decoration: BoxDecoration(
//             color: Colors.red, // Red background for the error
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.error, color: Colors.white), // Error icon on the left
//               const SizedBox(width: 10), // Space between the icon and the text
//               Expanded(
//                 child: Text(
//                   message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );

//   overlay.insert(overlayEntry);

//   // Automatically remove the toast after a duration
//   Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
// }

//   void _handleLogout(BuildContext context) async {
//   // Show a confirmation dialog before logging out
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Confirm Logout'),
//         content: const Text('Are you sure you want to log out?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               // Close the dialog and do not log out
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               // Close the dialog and navigate to the Login screen
//               Navigator.of(context).pop(); // Close the dialog

//               final prefs = await SharedPreferences.getInstance();
//               await prefs.remove('loggedInUserId');
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//                 (route) => false, // Remove all existing routes
//               );
//             },
//             child: const Text('Logout'),
//           ),
//         ],
//       );
//     },
//   );
// }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/details-new/postavke_screen.dart';
import '../screens/lists/cjenovnik_list_screen.dart';
import '../screens/lists/drzava_list_screen.dart';
import '../screens/lists/gosti_list_screen.dart';
import '../screens/lists/gradovi_list_screen.dart';
import '../screens/lists/novosti_list_screen.dart';
import '../screens/lists/osoblje_list_screen.dart';
import '../screens/lists/recenzija_list_screen.dart';
import '../screens/lists/rezervacija_list_screen.dart';
import '../screens/lists/soba_list_screen.dart';
import '../screens/lists/sobaosoblje_list_screen.dart';
import '../screens/lists/sobastatus_list_screen.dart';
import '../screens/lists/vrstaosoblja_list_screen.dart';
import '../main.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreenWidget({this.child, this.title, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreenWidget> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text(
          widget.title ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Header
                Container(
                  height: 100,
                  color: Colors.blueAccent,
                  alignment: Alignment.center,
                  child: const Text(
                    'Hotel AS',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Sidebar Menu
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: [
                      _buildMenuItem(Icons.people, 'Gosti', 0, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GostiListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.person, 'Osoblje', 1, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OsobljeListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.new_releases, 'Novosti', 2, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NovostiListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.location_city, 'Gradovi', 3, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GradListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.flag, 'Države', 4, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DrzavaListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.book, 'Rezervacije', 5, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RezervacijaListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.rate_review, 'Recenzije', 6, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RecenzijaListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.hotel, 'Soba Status', 7, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SobaStatusListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.work, 'Vrsta Osoblja', 8, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const VrstaOsobljaListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.attach_money, 'Cjenovnik', 9, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CjenovnikListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.bed, 'Soba', 10, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SobaListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.group, 'Soba Osoblje', 11, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SobaOsobljeListScreen(),
                        ));
                      }),
                      _buildMenuItem(Icons.settings, 'Postavke', 12, () async {
                        final prefs = await SharedPreferences.getInstance();
                        final int? userId = prefs.getInt('loggedInUserId');

                        if (userId != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostavkeScreen(osobljeId: userId),
                          ));
                        } else {
                          showErrorToast(context, 'Unable to retrieve user ID. Please log in again.');
                        }
                      }),
                      _buildMenuItem(Icons.logout, 'Logout', 13, () {
                        _handleLogout(context);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: widget.child ?? Container(),
          ),
        ],
      ),
    );
  }

  // Helper function to build menu items
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: hoveredIndex == index ? Colors.blue[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          boxShadow: hoveredIndex == index
              ? [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white, size: 28),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  // Handle user logout
  void _handleLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('loggedInUserId');
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false, // Remove all routes
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // Show error toast
  void showErrorToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        left: MediaQuery.of(context).size.width * 0.15,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
  }
}
