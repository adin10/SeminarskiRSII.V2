
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class GostIzvjestaj {
  final String ime;
  final String prezime;
  final List<RezervacijaInfo> rezervacije;

  GostIzvjestaj({required this.ime, required this.prezime, required this.rezervacije});

  factory GostIzvjestaj.fromJson(Map<String, dynamic> json) {
    return GostIzvjestaj(
      ime: json['ime'],
      prezime: json['prezime'],
      rezervacije: (json['rezervacije'] as List)
          .map((e) => RezervacijaInfo.fromJson(e))
          .toList(),
    );
  }
}

class RezervacijaInfo {
  final DateTime datumRezervacije;
  final DateTime zavrsetakRezervacije;
  final List<UslugaInfo> usluge;
  final int brojsprata;
  final int brojsobe;
  final String opissobe;
  final String? slikaBase64;
  final double ukupnaCijena;

  RezervacijaInfo({
    required this.datumRezervacije,
    required this.zavrsetakRezervacije,
    required this.usluge,
    required this.brojsprata,
    required this.brojsobe,
    required this.opissobe,
    required this.slikaBase64,
    required this.ukupnaCijena
  });

  factory RezervacijaInfo.fromJson(Map<String, dynamic> json) {
    return RezervacijaInfo(
      datumRezervacije: DateTime.parse(json['datumRezervacije']),
      zavrsetakRezervacije: DateTime.parse(json['zavrsetakRezervacije']),
      usluge: (json['usluge'] as List)
          .map((e) => UslugaInfo.fromJson(e))
          .toList(),
      brojsprata: int.parse(json['brojSprata'].toString()),
      brojsobe: int.parse(json['brojSobe'].toString()),
      opissobe: json['opisSobe'] ?? '',
      slikaBase64: json['slika'],
      ukupnaCijena: (json['ukupnaCijena'] as num).toDouble()
    );
  }
}

class UslugaInfo {
  final String naziv;
  final String opis;
  final int cijena;

  UslugaInfo({required this.naziv, required this.opis, required this.cijena});

  factory UslugaInfo.fromJson(Map<String, dynamic> json) {
    return UslugaInfo(
      naziv: json['naziv'],
      opis: json['opis'],
      cijena: json['cijena'],
    );
  }
}

String formatirajDatum(DateTime datum) {
  return DateFormat('dd.MM.yyyy').format(datum);
}

Future<void> generisiIPreuzmiPDF(BuildContext context, GostIzvjestaj izvjestaj) async {
  final pdf = pw.Document();

  pw.Widget alignedRow(String label, String value, {bool boldValue = false}) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 120,
          child: pw.Text(
            label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value,
            style: boldValue ? pw.TextStyle(fontWeight: pw.FontWeight.bold) : null,
          ),
        ),
      ],
    );
  }

  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Text(
          '${izvjestaj.ime} ${izvjestaj.prezime} - Izvjestaj',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 20),

        ...izvjestaj.rezervacije.map((rez) {
          final image = (rez.slikaBase64 != null && rez.slikaBase64!.isNotEmpty)
              ? base64Decode(rez.slikaBase64!)
              : null;

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              alignedRow(
                'Rezervacija:',
                '${formatirajDatum(rez.datumRezervacije)} - ${formatirajDatum(rez.zavrsetakRezervacije)}',
              ),
              pw.SizedBox(height: 8),

              if (image != null)
                pw.Container(
                  height: 160,
                  width: double.infinity,
                  alignment: pw.Alignment.center,
                  child: pw.Image(
                    pw.MemoryImage(image),
                    fit: pw.BoxFit.contain,
                  ),
                ),
              if (image != null) pw.SizedBox(height: 8),

              alignedRow('Broj sprata:', '${rez.brojsprata}'),
              alignedRow('Broj sobe:', '${rez.brojsobe}'),
              alignedRow('Opis sobe:', rez.opissobe),
              pw.SizedBox(height: 8),

              // pw.Text(
              //   'Usluge:',
              //   style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              // ),
              // pw.SizedBox(height: 4),

              // ...rez.usluge.map((usluga) => alignedRow(
              //       '${usluga.naziv}:',
              //       '${usluga.opis} (${usluga.cijena} KM)',
              //     )),
              pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        width: 120,
                        child: pw.Text(
                          'Usluge:',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: rez.usluge
                              .map((u) => pw.Text('${u.opis} (${u.cijena.toStringAsFixed(2)} KM)'))
                              .toList(),
                        ),
                      ),
                    ],
                  ),

              pw.SizedBox(height: 8),
              alignedRow(
                'Ukupna cijena:',
                '${rez.ukupnaCijena.toStringAsFixed(2)} KM',
                boldValue: true,
              ),

              pw.Divider(),
              pw.SizedBox(height: 10),
            ],
          );
        }),
      ],
    ),
  );

 await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}


void prikaziIzvjestajDialog(BuildContext context, GostIzvjestaj izvjestaj) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('${izvjestaj.ime} ${izvjestaj.prezime} - Izvjestaj', 
      style: const TextStyle(fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 500,
        height: 400,
        child: izvjestaj.rezervacije.isEmpty
            ? const Center(
                child: Text(
                  'Za ovu osobu trenutno nema izvjestaja.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: izvjestaj.rezervacije.length,
                itemBuilder: (context, index) {
                  final rez = izvjestaj.rezervacije[index];
                  Uint8List? imageBytes;
                  if (rez.slikaBase64 != null &&
                      rez.slikaBase64!.isNotEmpty) {
                    try {
                      imageBytes = base64Decode(rez.slikaBase64!);
                    } catch (_) {
                      imageBytes = null;
                    }
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (imageBytes != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  imageBytes,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                        _buildAlignedRow(
                         'Rezervacija:',
                          '${formatirajDatum(rez.datumRezervacije)} - ${formatirajDatum(rez.zavrsetakRezervacije)}',
                         ),
                          const SizedBox(height: 8),
                          _buildAlignedRow('Broj sprata:', '${rez.brojsprata}'),
                          _buildAlignedRow('Broj sobe:', '${rez.brojsobe}'),
                          _buildAlignedRow('Opis sobe:', rez.opissobe),
                          const SizedBox(height: 8),
                          // const Text(
                          //   'Usluge:',
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          // const SizedBox(height: 4),
                          // ...rez.usluge.map(
                          //   (usluga) => _buildAlignedRow(
                          //     '${usluga.naziv}:',
                          //     '${usluga.opis} (${usluga.cijena} KM)',
                          //   ),
                          // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 120,
                                child: Text(
                                  'Usluge:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: rez.usluge
                                      .map((u) => Text('${u.opis} (${u.cijena.toStringAsFixed(2)} KM)'))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                          _buildAlignedRow(
                          'Ukupna cijena:',
                          '${rez.ukupnaCijena.toStringAsFixed(2)} KM',
                          boldValue: true,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          child: const Text('Zatvori'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Preuzmi PDF'),
          onPressed: izvjestaj.rezervacije.isEmpty
              ? null
              : () => generisiIPreuzmiPDF(context, izvjestaj),
        ),
      ],
    ),
  );
}


Widget _buildAlignedRow(String label, String value, {bool boldValue = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: boldValue
                ? const TextStyle(fontWeight: FontWeight.bold)
                : null,
          ),
        ),
      ],
    ),
  );
}


