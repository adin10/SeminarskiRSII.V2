import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/providers/recenzija_provider.dart';

class SobaRecenzijeScreen extends StatefulWidget {
  static const routeName = "/soba-recenzije";

  final int sobaId;

  const SobaRecenzijeScreen({super.key, required this.sobaId});

  @override
  State<SobaRecenzijeScreen> createState() => _SobaRecenzijeScreenState();
}

class _SobaRecenzijeScreenState extends State<SobaRecenzijeScreen> {
  late RecenzijaProvider _recenzijaProvider;
  static const routeName = '/soba-recenzije';
  List<dynamic> _recenzije = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    loadData();
  }

  Future<void> loadData() async {
    final result = await _recenzijaProvider.getListBySobaId(widget.sobaId);
    setState(() {
      _recenzije = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recenzije sobe"),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _recenzije.isEmpty
              ? const Center(child: Text("Nema recenzija za ovu sobu."))
              : ListView.builder(
                  itemCount: _recenzije.length,
      itemBuilder: (context, index) {
  final recenzija = _recenzije[index];
  final gost = recenzija['gost'];
  final datum = DateTime.parse(recenzija['datumRecenzije']);

  final imePrezime = gost != null
      ? "${gost['ime']} ${gost['prezime']}"
      : "Nepoznat gost";

  return Card(
    margin: const EdgeInsets.all(10),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            imePrezime,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Ocjena: ${recenzija['ocjena']}/5",
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            "Komentar: ${recenzija['komentar']}",
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            "Datum: ${DateFormat('dd.MM.yyyy').format(datum)}",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
    ),
  );
},
                ),
    );
  }
}
