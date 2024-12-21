// import 'package:flutter/material.dart';
// import 'package:seminarskirsmobile/main.dart';

// class PostavkeScreen extends StatelessWidget {
//   static const String routeName = '/postavke'; // Define the route name

//   @override
//   Widget build(BuildContext context) {
//     // Get the user data passed from the previous screen

//     final GetUserResponse? userData = ModalRoute.of(context)?.settings.arguments as GetUserResponse?;
//         if (userData == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Error')),
//         body: const Center(
//           child: Text('Missing user data. Please go back and try again.'),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Postavke"),
//         backgroundColor: Color.fromARGB(255, 200, 216, 199),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Display user details in a card format
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "User Profile",
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         buildUserInfoRow('Full Name:', '${userData?.ime} ${userData?.prezime}'),
//                         buildUserInfoRow('Username:', userData?.korisnickoIme ?? ''),
//                         buildUserInfoRow('Email:', userData?.email ?? ''),
//                         buildUserInfoRow('Phone:', userData?.telefon ?? ''),
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build a row for user info
//   Widget buildUserInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:seminarskirsmobile/main.dart';

// class PostavkeScreen extends StatelessWidget {
//   static const String routeName = '/postavke'; // Define the route name

//   @override
//   Widget build(BuildContext context) {
//     // Get the user data passed from the previous screen
//     final GetUserResponse? userData = ModalRoute.of(context)?.settings.arguments as GetUserResponse?;
    
//     if (userData == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Error')),
//         body: const Center(
//           child: Text('Missing user data. Please go back and try again.'),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Postavke"),
//         backgroundColor: Color.fromARGB(255, 200, 216, 199),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Display user details in a card format
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "User Profile",
//                           style: TextStyle(
//                             fontSize: 24,  // Increased font size
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 16),
                        
//                         // User full name and username
//                         buildUserInfoRow('Full Name:', '${userData?.ime} ${userData?.prezime}', fontSize: 18),
//                         buildUserInfoRow('Username:', userData?.korisnickoIme ?? '', fontSize: 18),

//                         // Add a little separation before showing email, phone, and password
//                         Divider(thickness: 1, color: Colors.grey),

//                         buildUserInfoRow('Email:', userData?.email ?? '', fontSize: 18),
//                         buildUserInfoRow('Phone:', userData?.telefon ?? '', fontSize: 18),
//                         SizedBox(height: 20),

//                         // Password (Hardcoded)
//                         buildUserInfoRow('Password:', '******', fontSize: 18),
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 // Button to change password
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Navigate to the password change screen
//                       Navigator.pushNamed(context, '/changePassword');
//                     },
//                     child: Text("Change Your Password"),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50), backgroundColor: Color.fromARGB(255, 200, 216, 199),
//                       textStyle: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build a row for user info
//   Widget buildUserInfoRow(String label, String value, {double fontSize = 16}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: fontSize,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(fontSize: fontSize),
//               textAlign: TextAlign.end,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/screens/change_password_screen.dart';

class PostavkeScreen extends StatelessWidget {
  static const String routeName = '/postavke'; // Define the route name

  @override
  Widget build(BuildContext context) {
    // Get the user data passed from the previous screen
    final GetUserResponse? userData = ModalRoute.of(context)?.settings.arguments as GetUserResponse?;
    
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
        backgroundColor: Color.fromARGB(255, 200, 216, 199),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display user details in a card format
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Profile",
                          style: TextStyle(
                            fontSize: 24,  // Increased font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        
                        // User full name and username
                        buildUserInfoRow('Full Name:', '${userData?.ime} ${userData?.prezime}', fontSize: 18),
                        buildUserInfoRow('Username:', userData?.korisnickoIme ?? '', fontSize: 18),

                        // Add a little separation before showing email, phone, and password
                        Divider(thickness: 1, color: Colors.grey),

                        buildUserInfoRow('Email:', userData?.email ?? '', fontSize: 18),
                        buildUserInfoRow('Phone:', userData?.telefon ?? '', fontSize: 18),
                        SizedBox(height: 20),

                        // Password (Hardcoded)
                        buildUserInfoRow('Password:', '******', fontSize: 18),
                        SizedBox(height: 20),

                        // Button to change password (inside the card)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to the password change screen
                               Navigator.pushNamed(
                          context, ChangePasswordScreen.routeName);
                            },
                            child: Text("Change Your Password"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50), backgroundColor: Color.fromARGB(255, 200, 216, 199),
                              textStyle: TextStyle(fontSize: 18),
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
      ),
    );
  }

  // Helper method to build a row for user info
  Widget buildUserInfoRow(String label, String value, {double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}
