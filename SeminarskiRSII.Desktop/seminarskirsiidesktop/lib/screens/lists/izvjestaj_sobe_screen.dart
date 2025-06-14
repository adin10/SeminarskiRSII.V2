import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SobaIzvjestaj {
  final int brojSobe;
  final int brojSprata;
  final String opisSobe;
  final String slika;
  final List<RezervacijaZaSobuInfo> rezervacije;

  SobaIzvjestaj({
    required this.brojSobe,
    required this.brojSprata,
    required this.opisSobe,
    required this.slika,
    required this.rezervacije,
  });

  factory SobaIzvjestaj.fromJson(Map<String, dynamic> json) {
    return SobaIzvjestaj(
      brojSobe: json['brojSobe'],
      brojSprata: json['brojSprata'],
      opisSobe: json['opisSobe'],
      slika: json['slika'] ?? '',
      rezervacije: (json['rezervacije'] as List)
          .map((e) => RezervacijaZaSobuInfo.fromJson(e))
          .toList(),
    );
  }
}

class RezervacijaZaSobuInfo {
  final DateTime datumRezervacije;
  final DateTime zavrsetakRezervacije;
  final String gostIme;
  final String gostPrezime;
  final double cijena;
  final List<UslugaSobaInfo> usluge;

  RezervacijaZaSobuInfo({
    required this.datumRezervacije,
    required this.zavrsetakRezervacije,
    required this.gostIme,
    required this.gostPrezime,
    required this.cijena,
    required this.usluge,
  });

  factory RezervacijaZaSobuInfo.fromJson(Map<String, dynamic> json) {
    return RezervacijaZaSobuInfo(
      datumRezervacije: DateTime.parse(json['datumRezervacije']),
      zavrsetakRezervacije: DateTime.parse(json['zavrsetakRezervacije']),
      gostIme: json['gostIme'],
      gostPrezime: json['gostPrezime'],
      cijena: (json['cijena'] as num).toDouble(),
      usluge: (json['usluge'] as List)
          .map((e) => UslugaSobaInfo.fromJson(e))
          .toList(),
    );
  }
}

class UslugaSobaInfo {
  final String naziv;
  final String opis;
  final int cijena;

  UslugaSobaInfo({
    required this.naziv,
    required this.opis,
    required this.cijena,
  });

  factory UslugaSobaInfo.fromJson(Map<String, dynamic> json) {
    return UslugaSobaInfo(
      naziv: json['naziv'],
      opis: json['opis'],
      cijena: json['cijena'],
    );
  }
}

  String formatirajDatum(DateTime datum) {
  return DateFormat('dd.MM.yyyy').format(datum);
}

Future<void> generisiIPreuzmiPDF(BuildContext context, SobaIzvjestaj izvjestaj) async {
  final pdf = pw.Document();

  pw.Widget alignedRow(String label, String value, {bool boldValue = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
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
      ),
    );
  }

  Uint8List? imageBytes;
  if (izvjestaj.slika.isNotEmpty) {
    try {
      imageBytes = base64Decode(izvjestaj.slika);
    } catch (_) {
      imageBytes = null;
    }
  }

  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Text(
          'Soba ${izvjestaj.brojSobe} - Izvjestaj',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        alignedRow('Broj sprata:', '${izvjestaj.brojSprata}'),
        alignedRow('Opis sobe:', izvjestaj.opisSobe),
        pw.SizedBox(height: 12),
        if (imageBytes != null)
          pw.Container(
            height: 160,
            width: double.infinity,
            alignment: pw.Alignment.center,
            child: pw.Image(
              pw.MemoryImage(imageBytes),
              fit: pw.BoxFit.contain,
            ),
          ),
        pw.SizedBox(height: 12),
        if (izvjestaj.rezervacije.isEmpty)
          pw.Text(
            'Za ovu sobu trenutno nema rezervacija.',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          )
        else
          ...izvjestaj.rezervacije.map((rez) {
            final ukupnaCijenaUsluga = rez.usluge.fold<double>(
              0,
              (sum, u) => sum + u.cijena,
            );

            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 20),
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey),
                borderRadius: pw.BorderRadius.circular(6),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  alignedRow(
                    'Rezervacija:',
                    '${formatirajDatum(rez.datumRezervacije)} - ${formatirajDatum(rez.zavrsetakRezervacije)}',
                  ),
                  alignedRow('Gost:', '${rez.gostIme} ${rez.gostPrezime}'),
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
                  pw.SizedBox(height: 6),
                  alignedRow(
                    'Ukupna cijena:',
                    '${rez.cijena.toStringAsFixed(2)} KM',
                    boldValue: true,
                  ),
                ],
              ),
            );
          }),
      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

void prikaziIzvjestajDialog(BuildContext context, SobaIzvjestaj izvjestaj) {
  Uint8List? imageBytes;
  if (izvjestaj.slika.isNotEmpty) {
    try {
      imageBytes = base64Decode(izvjestaj.slika);
    } catch (_) {
      imageBytes = null;
    }
  }

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        'Soba ${izvjestaj.brojSobe} - Izvjestaj',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 500,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAlignedRow('Broj sprata:', '${izvjestaj.brojSprata}'),
            _buildAlignedRow('Opis sobe:', izvjestaj.opisSobe),
            const SizedBox(height: 12),
            if (imageBytes != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
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
            Expanded(
              child: izvjestaj.rezervacije.isEmpty
                  ? const Center(
                      child: Text(
                        'Za ovu sobu trenutno nema rezervacija.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: izvjestaj.rezervacije.length,
                      itemBuilder: (context, index) {
                        final rez = izvjestaj.rezervacije[index];
                        final ukupnaCijenaUsluga = rez.usluge.fold<double>(
                          0,
                          (sum, u) => sum + u.cijena,
                        );

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildAlignedRow(
                                  'Rezervacija:',
                                  '${formatirajDatum(rez.datumRezervacije)} - ${formatirajDatum(rez.zavrsetakRezervacije)}',
                                ),
                                _buildAlignedRow('Gost:', '${rez.gostIme} ${rez.gostPrezime}'),
                                const SizedBox(height: 8),
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
                                           .map(
                                             (u) => Text(
                                               '${u.opis} (${u.cijena.toStringAsFixed(2)} KM)',
                                             ),
                                           )
                                           .toList(),
                                     ),
                                   ),
                                 ],
                               ),
                                const SizedBox(height: 8),
                                _buildAlignedRow(
                                  'Ukupna cijena:',
                                  '${rez.cijena.toStringAsFixed(2)} KM',
                                  boldValue: true,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
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