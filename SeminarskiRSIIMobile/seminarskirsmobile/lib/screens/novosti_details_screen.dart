import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seminarskirsmobile/providers/novosti_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NovostiDetailScreen extends StatefulWidget {
  final Map<String, dynamic> novost;
  final int korisnikId;

  const NovostiDetailScreen({
    Key? key,
    required this.novost,
    required this.korisnikId,
  }) : super(key: key);

  @override
  State<NovostiDetailScreen> createState() => _NovostiDetailScreenState();
}

class _NovostiDetailScreenState extends State<NovostiDetailScreen> {
  bool isMarkedRead = false;

  @override
  void initState() {
    super.initState();
    _markAsReadIfNeeded();
  }

  Future<void> _markAsReadIfNeeded() async {
    if (widget.novost['procitano'] == false ||
        widget.novost['procitano'] == null) {
      try {
        await NovostiProvider()
            .markAsRead(widget.novost['id'], widget.korisnikId);
        setState(() {
          isMarkedRead = true;
        });
        widget.novost['procitano'] = true;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Greška pri označavanju obavijesti",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  void _launchUrlsInText(String text) async {
    final urlRegex = RegExp(r"(https?:\/\/[^\s]+)");
    final urls = urlRegex
        .allMatches(text)
        .map((match) => match?.group(0))
        .whereType<String>()
        .toList();

    if (urls.isNotEmpty && await canLaunchUrl(Uri.parse(urls.first))) {
      launchUrl(Uri.parse(urls.first), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final naslov = widget.novost['naslov'] ?? 'Bez naslova';
    final sadrzaj = widget.novost['sadrzaj'] ?? '';
    final datumObjave = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(widget.novost['datumObjave']));
    final slikaBase64 = widget.novost['slika'];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detalji novosti"),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (slikaBase64 != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    base64Decode(slikaBase64),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.article, size: 100, color: Colors.teal),
                ),
              SizedBox(height: 16),
              Text(
                naslov,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _launchUrlsInText(sadrzaj),
                child: Text(
                  sadrzaj,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Datum: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.novost['datumObjave']))}',
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                  if (widget.novost['osoblje'] != null)
                    Text(
                      'Autor: ${widget.novost['osoblje']['ime']} ${widget.novost['osoblje']['prezime']}',
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
