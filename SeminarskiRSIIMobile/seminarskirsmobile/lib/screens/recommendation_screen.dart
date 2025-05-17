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
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 "Najpopularnije i najrezervisanije sobe",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
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
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildRoomDetail("Broj sobe:", soba["brojSobe"].toString()),
//                   _buildRoomDetail(
//                       "Broj sprata:", soba["brojSprata"].toString()),
//                   _buildRoomDetail("Opis:", soba["opisSobe"] ?? "Nema opisa"),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   const Icon(Icons.calendar_today,
//                       size: 18, color: Colors.teal),
//                   const SizedBox(width: 6),
//                   Expanded(
//                     child: Text(
//                       "Rezervisana ${soba["brojRezervacijaUZadnjuGodinu"] ?? 0} puta zadnjih godinu dana",
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ],
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
//           const SizedBox(width: 16), 
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
import 'package:seminarskirsmobile/providers/sobe_provider.dart';

class RecommendationScreen extends StatefulWidget {
  static const String routeName = '/recommended-sobe';

  const RecommendationScreen({Key? key}) : super(key: key);

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
        title: const Text("Preporučene Sobe"),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : recommendedRooms.isNotEmpty
              ? PageView(
                  children: recommendedRooms.map<Widget>((soba) {
                    return _buildRoomCard(soba);
                  }).toList(),
                )
              : const Center(
                  child: Text(
                    "Nema preporučenih soba",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
    );
  }

  Widget _buildRoomCard(dynamic soba) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(16.0),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Najpopularnije i najrezervisanije sobe",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 16),
              _buildRoomDetail("Broj sobe:", soba["brojSobe"].toString()),
              _buildRoomDetail("Broj sprata:", soba["brojSprata"].toString()),
              _buildRoomDetail("Opis:", soba["opisSobe"] ?? "Nema opisa"),

              //ovo je slijedece za uraditi
              // _buildRoomDetail("Prosjecna ocjena:", soba["prosjecnaOcjena"] != null
              //                               ? "Prosječna ocjena: ${soba["prosjecnaOcjena"].toStringAsFixed(1)}"
              //                               : "Nema ocjena za ovu sobu",),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18, color: Colors.teal),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Rezervisana ${soba["brojRezervacijaUZadnjuGodinu"] ?? 0} puta zadnjih godinu dana",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to reservation or implement action
                  print("Rezervacija za sobu: ${soba["brojSobe"]}");
                },
                icon: const Icon(Icons.book_online),
                label: const Text("Rezerviši sobu"),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
               foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

