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
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Najpopularnije i najrezervisanije sobe",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRoomDetail("Broj sobe:", soba["brojSobe"].toString()),
                _buildRoomDetail("Broj sprata:", soba["brojSprata"].toString()),
                _buildRoomDetail("Opis:", soba["opisSobe"] ?? "Nema opisa"),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.pushNamed(
          //         context,
          //         RezervacijScreen.dodajRezervacijuRouteName,
          //         arguments: {
          //           'selectedRoomId': soba["id"],
          //         },
          //       );
          //     },
          //     style: ElevatedButton.styleFrom(
          //       padding: const EdgeInsets.symmetric(vertical: 16.0),
          //       backgroundColor: Colors.teal,
          //       textStyle: const TextStyle(fontSize: 18),
          //     ),
          //     child: const Text("Rezerviši sobu"),
          //   ),
          // ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildRoomDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "$label $value",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
