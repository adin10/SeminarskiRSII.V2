// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/providers/sobe_provider.dart';

// class RecommendationScreen extends StatefulWidget {
//   static const String routeName = '/recommended-sobe';

//   const RecommendationScreen({Key? key}) : super(key: key);

//   @override
//   State<RecommendationScreen> createState() => _RecommendationScreenState();
// }

// class _RecommendationScreenState extends State<RecommendationScreen> {
//   late SobaProvider _sobaProvider;
//   List<dynamic> recommendedRooms = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _sobaProvider = context.read<SobaProvider>();
//     loadRecommendations();
//   }

//   Future<void> loadRecommendations() async {
//     try {
//       var response = await _sobaProvider.getRecommendations();
//       setState(() {
//         recommendedRooms = response;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error loading recommendations: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Preporučene Sobe"),
//         backgroundColor: Colors.teal,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : recommendedRooms.isNotEmpty
//               ? PageView(
//                   children: recommendedRooms.map<Widget>((soba) {
//                     return _buildRoomCard(soba);
//                   }).toList(),
//                 )
//               : const Center(
//                   child: Text(
//                     "Nema preporučenih soba",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//     );
//   }

//   Widget _buildRoomCard(dynamic soba) {
//     return SingleChildScrollView(
//       child: Card(
//         margin: const EdgeInsets.all(16.0),
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Text(
//                 "Najpopularnije i najrezervisanije sobe",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),
//               AspectRatio(
//                 aspectRatio: 1 / 1,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.memory(
//                     base64Decode(soba["slika"]),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               _buildRoomDetail("Broj sobe:", soba["brojSobe"].toString()),
//               _buildRoomDetail("Broj sprata:", soba["brojSprata"].toString()),
//               _buildRoomDetail("Opis:", soba["opisSobe"] ?? "Nema opisa"),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   const Icon(Icons.calendar_today, size: 18, color: Colors.teal),
//                   const SizedBox(width: 6),
//                   Expanded(
//                     child: Text(
//                       "Rezervisana ${soba["brojRezervacijaUZadnjuGodinu"] ?? 0} puta zadnjih godinu dana",
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   // TODO: Navigate to reservation or implement action
//                   print("Rezervacija za sobu: ${soba["brojSobe"]}");
//                 },
//                 icon: const Icon(Icons.book_online),
//                 label: const Text("Rezerviši sobu"),
//                 style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRoomDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }








// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/providers/sobe_provider.dart';

// class RecommendationScreen extends StatefulWidget {
//   static const String routeName = '/recommended-sobe';

//   const RecommendationScreen({Key? key}) : super(key: key);

//   @override
//   State<RecommendationScreen> createState() => _RecommendationScreenState();
// }

// class _RecommendationScreenState extends State<RecommendationScreen> {
//   late SobaProvider _sobaProvider;
//   List<dynamic> recommendedRooms = [];
//   bool isLoading = true;
//   bool _isGridView = false;

//   @override
//   void initState() {
//     super.initState();
//     _sobaProvider = context.read<SobaProvider>();
//     loadRecommendations();
//   }

//   Future<void> loadRecommendations() async {
//     try {
//       var response = await _sobaProvider.getRecommendations();
//       setState(() {
//         recommendedRooms = response;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error loading recommendations: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Preporučene Sobe"),
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(
//             icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
//             onPressed: () {
//               setState(() {
//                 _isGridView = !_isGridView;
//               });
//             },
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : recommendedRooms.isNotEmpty
//               ? _isGridView
//                   ? GridView.builder(
//                       padding: const EdgeInsets.all(12),
//                       itemCount: recommendedRooms.length,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 12,
//                         crossAxisSpacing: 12,
//                         childAspectRatio: 0.7,
//                       ),
//                       itemBuilder: (context, index) {
//                         return _buildRoomCard(recommendedRooms[index], isGrid: true);
//                       },
//                     )
//                   : ListView.builder(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       itemCount: recommendedRooms.length,
//                       itemBuilder: (context, index) {
//                         return _buildRoomCard(recommendedRooms[index]);
//                       },
//                     )
//               : const Center(
//                   child: Text(
//                     "Nema preporučenih soba",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//     );
//   }

//   Widget _buildRoomCard(dynamic soba, {bool isGrid = false}) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               "Najpopularnije i najrezervisanije sobe",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             AspectRatio(
//               aspectRatio: 1 / 1,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.memory(
//                   base64Decode(soba["slika"]),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildRoomDetail("Broj sobe:", soba["brojSobe"].toString()),
//             _buildRoomDetail("Broj sprata:", soba["brojSprata"].toString()),
//             _buildRoomDetail("Opis:", soba["opisSobe"] ?? "Nema opisa"),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.calendar_today, size: 18, color: Colors.teal),
//                 const SizedBox(width: 6),
//                 Expanded(
//                   child: Text(
//                     "Rezervisana ${soba["brojRezervacijaUZadnjuGodinu"] ?? 0} puta zadnjih godinu dana",
//                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: () {
//                 // TODO: Implementiraj navigaciju ili rezervaciju
//                 print("Rezervacija za sobu: ${soba["brojSobe"]}");
//               },
//               icon: const Icon(Icons.book_online),
//               label: const Text("Rezerviši sobu"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRoomDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 110,
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//           ),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/providers/sobe_provider.dart';
import 'package:seminarskirsmobile/screens/odabir_sobe_screen.dart';

class RecommendationScreen extends StatefulWidget {
  static const String routeName = '/recommended-sobe';
    final GetUserResponse userData;
  final int userId;

    const RecommendationScreen({
    required this.userData,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  late SobaProvider _sobaProvider;
  List<dynamic> recommendedRooms = [];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    _sobaProvider = context.read<SobaProvider>();
    loadRecommendations();
  }

  Future<void> loadRecommendations() async {
    try {
      var response = await _sobaProvider.getRecommendations();
      setState(() {
        recommendedRooms = response;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading recommendations: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preporučene sobe"),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : recommendedRooms.isEmpty
              ? const Center(child: Text("Nema preporučenih soba"))
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: recommendedRooms.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Text(
                          "Najpopularnije i najrezervisanije sobe",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return _buildRoomCard(recommendedRooms[index - 1]);
                  },
                ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
builder: (context) => OdabirDatumaScreen(
                userData: widget.userData,
                userId: widget.userId,
              ),
                    ),
                  );
          },
          icon: const Icon(Icons.date_range),
          label: const Text("Odaberite datum i sobu"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard(dynamic soba) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  base64Decode(soba["slika"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildRoomDetail("Broj sobe:", soba["brojSobe"].toString()),
            _buildRoomDetail("Broj sprata:", soba["brojSprata"].toString()),
            _buildRoomDetail("Opis:", soba["opisSobe"] ?? "Nema opisa"),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.teal),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Rezervisana ${soba["brojRezervacijaUZadnjuGodinu"] ?? 0} puta zadnjih godinu dana",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
