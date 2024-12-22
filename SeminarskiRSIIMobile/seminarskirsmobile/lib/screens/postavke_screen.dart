// import 'package:flutter/material.dart';
// import 'package:seminarskirsmobile/main.dart';
// import 'package:seminarskirsmobile/screens/change_password_screen.dart';

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

//                         // Button to change password (inside the card)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               // Navigate to the password change screen
//                                Navigator.pushNamed(
//                           context, ChangePasswordScreen.routeName);
//                             },
//                             child: Text("Change Your Password"),
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50), backgroundColor: Color.fromARGB(255, 200, 216, 199),
//                               textStyle: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                         ),
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
//   Widget buildUserInfoRow(String label, String value, {double fontSize = 16}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: fontSize,
//             ),
//           ),
//           SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(fontSize: fontSize),
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
                        "User Profile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                        ),
                      ),
                      SizedBox(height: 16),
                      buildUserInfoRow(
                          label: 'Full Name:',
                          value: '${userData.ime} ${userData.prezime}'),
                      buildUserInfoRow(
                          label: 'Username:',
                          value: userData.korisnickoIme ?? ''),
                      Divider(thickness: 1, color: Colors.grey[400]),
                      buildUserInfoRow(
                          label: 'Email:', value: userData.email ?? ''),
                      buildUserInfoRow(
                          label: 'Phone:', value: userData.telefon ?? ''),
                      SizedBox(height: 16),
                      buildUserInfoRow(
                          label: 'Password:', value: '******'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ChangePasswordScreen.routeName);
                        },
                        child: Text("Change Your Password"),
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