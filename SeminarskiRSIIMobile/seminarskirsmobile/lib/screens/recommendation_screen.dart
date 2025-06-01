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
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
            _buildRoomDetail("Broj sobe:", soba["brojSobe"].toString(), icon: Icons.numbers ),
            _buildRoomDetail("Broj sprata:", soba["brojSprata"].toString(), icon: Icons.numbers),
            _buildRoomDetail("Opis:", soba["opisSobe"] ?? "Nema opisa", icon: Icons.text_format),
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
          ],
        ),
      ),
    );
  }

Widget _buildRoomDetail(String label, String value, {IconData? icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: Colors.teal),
          const SizedBox(width: 10),
        ],
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 6),
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
