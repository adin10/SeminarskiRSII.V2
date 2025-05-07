import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/providers/globals.dart';
import 'package:seminarskirsmobile/providers/novosti_provider.dart';
import 'package:seminarskirsmobile/screens/novosti_details_screen.dart';

class NovostiScreen extends StatefulWidget {
  static const String novostiRouteName = '/novosti';
  const NovostiScreen({Key? key}) : super(key: key);

  @override
  State<NovostiScreen> createState() => _NovostiScreenState();
}

class _NovostiScreenState extends State<NovostiScreen> {
  NovostiProvider? _novostiProvider;
  List<dynamic> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _novostiProvider = context.read<NovostiProvider>();
    loadData();
  }

  Future<void> loadData() async {
    try {
      var tmpData = await _novostiProvider?.getList(gostId: loggedUserID);
      setState(() {
        data = tmpData ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Greška"),
          content: Text('Neuspjelo učitavanje podataka'),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novosti"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade100, Colors.teal.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : data.isEmpty
                  ? Center(
                      child: Text(
                        "Nema dostupnih podataka",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return NovostiCard(
                          data: data[index],
                          onMarkedAsRead: () async {
                            await _novostiProvider?.markAsRead(
                                data[index]["id"], loggedUserID);
                            loadData();
                          },
                        );
                      },
                    ),
        ),
      ),
    );
  }
}

String _shortenText(String text, int maxWords) {
  final words = text.split(RegExp(r'\s+'));
  if (words.length <= maxWords) return text;
  return words.take(maxWords).join(' ') + '...';
}

class NovostiCard extends StatelessWidget {
  final dynamic data;
  final VoidCallback onMarkedAsRead;

  const NovostiCard({
    Key? key,
    required this.data,
    required this.onMarkedAsRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRead = data['procitano'] == true;

    return InkWell(
onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NovostiDetailScreen(
              novost: data,
              korisnikId: loggedUserID,
            ),
          ),
        );

        if (result == true) {
          onMarkedAsRead(); // automatski poziva loadData iz roditelja
        }
      },
      child: Card(
        color: isRead ? Colors.grey.shade200 : Colors.white,
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data['slika'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    base64Decode(data['slika']),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      data['naslov'] ?? 'Bez naslova',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isRead ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  isRead
                      ? Icon(Icons.check_circle, color: Colors.teal, size: 28)
                      : ElevatedButton.icon(
                          onPressed: onMarkedAsRead,
                          icon: Icon(Icons.done),
                          label: Text("Označi pročitanim"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                _shortenText(data["sadrzaj"] ?? "Bez sadržaja", 8),
                style: TextStyle(
                  fontSize: 16,
                  color: isRead ? Colors.grey : Colors.black87,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6),
              Text(
                DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(data["datumObjave"])),
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

