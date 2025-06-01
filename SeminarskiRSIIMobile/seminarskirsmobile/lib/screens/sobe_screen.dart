import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/main.dart';
import 'package:seminarskirsmobile/providers/sobe_provider.dart';
import 'package:seminarskirsmobile/screens/recenzije_sobe_screen.dart';
import 'package:seminarskirsmobile/screens/rezervacija_screen.dart';

class SobeScreen extends StatefulWidget {
  static const String sobeRouteName = '/sobe';

  const SobeScreen({Key? key}) : super(key: key);

  @override
  State<SobeScreen> createState() => _SobeScreenState();
}

class _SobeScreenState extends State<SobeScreen> {
  SobaProvider? _sobaProvider;
  dynamic data = {};
  GetUserResponse? userData;
  DateTime? datumOd;
  DateTime? datumDo;
  bool _isInitialized = false;
  bool _filterExpanded = false;
  bool isLoading = false;
  final TextEditingController _cijenaOdController = TextEditingController();
  final TextEditingController _cijenaDoController = TextEditingController();
  final TextEditingController _spratController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sobaProvider = context.read<SobaProvider>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null) {
        userData = args['userData'] as GetUserResponse?;
        datumOd = args['datumOd'] as DateTime?;
        datumDo = args['datumDo'] as DateTime?;

        print(datumOd);
        print(datumDo);

        if (datumOd != null && datumDo != null) {
          loadData(datumOd!, datumDo!);
        }
      }

      _isInitialized = true;
    }
  }

  Future<void> loadData(DateTime datumOd, DateTime datumDo,
      {double? cijenaOd, double? cijenaDo, int? sprat}) async {
    isLoading = true;
    final filters = {
      'datumOd': datumOd.toIso8601String(),
      'datumDo': datumDo.toIso8601String(),
      if (cijenaOd != null) 'cijenaOd': cijenaOd.toString(),
      if (cijenaDo != null) 'cijenaDo': cijenaDo.toString(),
      if (sprat != null) 'sprat': sprat.toString(),
    };
    

    var tmpData = await _sobaProvider?.getCjenovnik(filters);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  void _applyFilter() {
    double? cijenaOd = double.tryParse(_cijenaOdController.text);
    double? cijenaDo = double.tryParse(_cijenaDoController.text);
    int? sprat = int.tryParse(_spratController.text);

    if (datumOd != null && datumDo != null) {
      loadData(datumOd!, datumDo!,
          cijenaOd: cijenaOd, cijenaDo: cijenaDo, sprat: sprat);
    }

    setState(() {
      _filterExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Greška')),
        body: const Center(
          child: Text('Nedostaju podaci o korisniku. Vratite se nazad.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pregled svih slobodnih soba"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade100, Colors.teal.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                child: Card(
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        _filterExpanded = !_filterExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _filterExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 1),
                          Text(
                            _filterExpanded
                                ? 'Sakrij filtere'
                                : 'Prikaži filtere',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          // Cijena Od
                          TextField(
                            controller: _cijenaOdController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'Cijena od',
                              prefixIcon: const Icon(Icons.attach_money),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Cijena Do
                          TextField(
                            controller: _cijenaDoController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'Cijena do',
                              prefixIcon: const Icon(Icons.attach_money),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Sprat
                          TextField(
                            controller: _spratController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Sprat',
                              prefixIcon: const Icon(Icons.layers),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _applyFilter,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                textStyle:
                                    const TextStyle(fontSize: 18),
                              ),
                              child: const Text('Primjeni filter'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                crossFadeState: _filterExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 100),
              ),
              Expanded(
              child: isLoading
              ? Center(child: CircularProgressIndicator())
              : 
                 data.isNotEmpty
                    ? PageView(
                        children: data.map<Widget>((x) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 6,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 14.0),
                                    //   child: SizedBox(
                                    //     width: double.infinity,
                                    //     child: ElevatedButton.icon(
                                    //       onPressed: () {
                                    //         final roomId =
                                    //             x["soba"]["id"] as int?;
                                    //         if (roomId != null) {
                                    //           Navigator.pushNamed(
                                    //             context,
                                    //             SobaRecenzijeScreen.routeName,
                                    //             arguments: roomId,
                                    //           );
                                    //         }
                                    //       },
                                    //       icon: const Icon(Icons.rate_review),
                                    //       label: const Text("Recenzije sobe"),
                                    //       style: ElevatedButton.styleFrom(
                                    //         backgroundColor: Colors.white,
                                    //         foregroundColor: Colors.teal,
                                    //         side: const BorderSide(
                                    //             color: Colors.teal),
                                    //         elevation: 2,
                                    //         shape: RoundedRectangleBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(12),
                                    //         ),
                                    //         padding: const EdgeInsets.symmetric(
                                    //             vertical: 12),
                                    //         textStyle:
                                    //             const TextStyle(fontSize: 18),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 6),
                                    AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.memory(
                                          base64Decode(x["soba"]["slika"]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                      Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            final roomId =
                                                x["soba"]["id"] as int?;
                                            if (roomId != null) {
                                              Navigator.pushNamed(
                                                context,
                                                SobaRecenzijeScreen.routeName,
                                                arguments: roomId,
                                              );
                                            }
                                          },
                                          icon: const Icon(Icons.rate_review),
                                          label: const Text("Recenzije sobe"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.teal,
                                            side: const BorderSide(
                                                color: Colors.teal),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            textStyle:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _tekstStavka("Broj sobe",
                                              x["soba"]["brojSobe"].toString()),
                                          _tekstStavka(
                                              "Broj sprata",
                                              x["soba"]["brojSprata"]
                                                  .toString()),
                                          _tekstStavka("Opis sobe",
                                              x["soba"]["opisSobe"].toString()),
                                          _tekstStavka("Pros. ocjena", 
                                              (x["soba"]["prosjecnaOcjena"] as double).toStringAsFixed(2)
                                            ),
                                          _tekstStavka("Cijena",
                                              "${x["cijena"]} ${x["valuta"]}",
                                              bold: true),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            final roomId =
                                                x["soba"]["id"] as int?;
                                            if (roomId == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Greška: ID sobe nije dostupan.'),
                                                ),
                                              );
                                              return;
                                            }
                                            IdGetter.Id = roomId;
                                            Navigator.pushNamed(
                                              context,
                                              RezervacijScreen
                                                  .dodajRezervacijuRouteName,
                                              arguments: {
                                                'userData': userData,
                                                'userId': userData!.id,
                                                'selectedRoomId': roomId,
                                                'datumOd': datumOd,
                                                'datumDo': datumDo
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14.0),
                                            textStyle:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          child: const Text("Rezerviši sobu"),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : const Center(
                        child: Text(
                          "Nema dostupnih soba",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _tekstStavka(String labela, String vrijednost, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130, // širina rezervisana za labelu
          child: Text(
            "$labela:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Flexible(
          child: Text(
            vrijednost,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}

class IdGetter {
  static int Id = 0;
}
