import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';

import '../../widgets/master_screen.dart';

class OsobljeListScreen extends StatefulWidget {
  const OsobljeListScreen({super.key});

  @override
  State<OsobljeListScreen> createState() => _OsobljeListScreenState();
}

class _OsobljeListScreenState extends State<OsobljeListScreen> {

  late OsobljeProvider _osobljeProvider;
  dynamic data = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _osobljeProvider = context.read<OsobljeProvider>();
    loadData();
  }

   Future loadData() async {
    var tmpData = await _osobljeProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }

   @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Lista uposlenih',
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
                                  child: Text("Ime",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Prezime",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Email",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                               label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Telefon",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                               label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Korisnicko ime",
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
          DataCell(Text("No data...")),
        ])
      ];
    }

    List<DataRow> list = data
        .map((x) => DataRow(
              cells: [
                DataCell(Text(x["id"]?.toString() ?? "0")),
                DataCell(
                    Text(x["ime"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                    Text(x["prezime"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  Text(x["email"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  Text(x["telefon"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  Text(x["korisnickoIme"] ?? "", style: TextStyle(fontSize: 14))),
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