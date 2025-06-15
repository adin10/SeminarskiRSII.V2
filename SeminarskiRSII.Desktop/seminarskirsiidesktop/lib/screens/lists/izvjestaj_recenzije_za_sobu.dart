import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RecenzijeZaSobuIzvjetsaj {
  final int brojSobe;
  final int brojSprata;
  final String opisSobe;
  final String slika;
  final List<RecenzijaZaSobuInfo> recenzije;

  RecenzijeZaSobuIzvjetsaj({
    required this.brojSobe,
    required this.brojSprata,
    required this.opisSobe,
    required this.slika,
    required this.recenzije,
  });

  factory RecenzijeZaSobuIzvjetsaj.fromJson(Map<String, dynamic> json) {
    return RecenzijeZaSobuIzvjetsaj(
      brojSobe: json['brojSobe'],
      brojSprata: json['brojSprata'],
      opisSobe: json['opisSobe'],
      slika: json['slika'] ?? '',
      recenzije: (json['recenzije'] as List)
          .map((e) => RecenzijaZaSobuInfo.fromJson(e))
          .toList(),
    );
  }
}

class RecenzijaZaSobuInfo {
  final int ocjena;
  final String komentar;
  final String gostIme;
  final String gostPrezime;

  RecenzijaZaSobuInfo({
    required this.ocjena,
    required this.komentar,
    required this.gostIme,
    required this.gostPrezime
  });

  factory RecenzijaZaSobuInfo.fromJson(Map<String, dynamic> json) {
    return RecenzijaZaSobuInfo(
      ocjena: (json['ocjena'] as num).toInt(),
      komentar: json['komentar'],
      gostIme: json['gostIme'],
      gostPrezime: json['gostPrezime']
    );
  }
}

  String formatirajDatum(DateTime datum) {
  return DateFormat('dd.MM.yyyy').format(datum);
}

Future<void> generisiIPreuzmiPDF(BuildContext context, RecenzijeZaSobuIzvjetsaj izvjestaj) async {
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
        if (izvjestaj.recenzije.isEmpty)
          pw.Text(
            'Za ovu sobu trenutno nema rezervacija.',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          )
        else
          ...izvjestaj.recenzije.map((rez) {
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
                  alignedRow('Ocjena:', '${rez.ocjena}'),
                  alignedRow('Gost:', '${rez.komentar}'),
                  alignedRow('Gost:', '${rez.gostIme} ${rez.gostPrezime}'),

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

void prikaziRecenzijeIzvjestajDialog(BuildContext context, RecenzijeZaSobuIzvjetsaj izvjestaj) {
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
              child: izvjestaj.recenzije.isEmpty
                  ? const Center(
                      child: Text(
                        'Za ovu sobu trenutno nema recenzija.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: izvjestaj.recenzije.length,
                      itemBuilder: (context, index) {
                        final rez = izvjestaj.recenzije[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 _buildAlignedRow('Ocjena:', '${rez.ocjena}'),
                                 _buildAlignedRow('Komentar:', '${rez.komentar}'),
                                _buildAlignedRow('Gost:', '${rez.gostIme} ${rez.gostPrezime}'),
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
          onPressed: izvjestaj.recenzije.isEmpty
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