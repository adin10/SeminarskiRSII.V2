import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/main.dart';
import 'package:seminarskirsiidesktop/providers/gosti_provider.dart';
import 'package:seminarskirsiidesktop/providers/soba_provider.dart';
import 'package:seminarskirsiidesktop/widgets/master_screen.dart';

class SobaListScreen extends StatefulWidget {
  static const String sobaRouteName = '/soba';
  const SobaListScreen({super.key});

  @override
  State<SobaListScreen> createState() => _SobaListScreenState();
}

class _SobaListScreenState extends State<SobaListScreen> {
  late SobaProvider _sobaProvider;
  dynamic data = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sobaProvider = context.read<SobaProvider>();
    loadData();
  }

    Future loadData() async {
    var tmpData = await _sobaProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Sobe',
      child: Container(
           child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(children: [
                    Container(
                      height: 200,
                      width: 1000,
                      child: DataTable(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        columns: [
                          DataColumn(
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Id",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Broj Sobe",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Broj sprata",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Opis sobe",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                               label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Soba status",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                               label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Slika",
                                      style: TextStyle(fontSize: 14)))),
                        ],
                        rows: _buildPlanAndProgrammeList(),
                      ),
                    ),
                  ]),
                )
      )
    );
  }
  List<DataRow> _buildPlanAndProgrammeList() {
    if (data.length == 0) {
      return [
        DataRow(cells: [
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
        ])
      ];
    }

    List<DataRow> list = data
        .map((x) => DataRow(
              cells: [
                DataCell(Text(x["id"]?.toString() ?? "0")),
                DataCell(
                    Text(x["brojSobe"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                    Text(x["brojSprata"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  Text(x["opisSobe"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  Text(x["sobaStatus"]["status"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  Image.memory(
                    base64Decode(x["slika"]),
                    fit: BoxFit.cover,
                  ),
                  ),
              ],
            ))
        .toList()
        .cast<DataRow>();
    return list;
  }
}



