import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/providers/novosti_provider.dart';

class NovostiScreen extends StatefulWidget {
  static const String novostiRouteName = '/novosti';
  const NovostiScreen({Key? key}) : super(key: key);

  @override
  State<NovostiScreen> createState() => _NovostiScreenState();
}

class _NovostiScreenState extends State<NovostiScreen> {
  NovostiProvider? _novostiProvider = null;
  dynamic data = {};
  @override
  void initState() {
    super.initState();
    _novostiProvider = context.read<NovostiProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _novostiProvider?.getList();
    setState(() {
      data = tmpData;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novosti"),
          backgroundColor: Color.fromARGB(255, 200, 216, 199),
        ),
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/green.jpg"),
                    fit: BoxFit.cover,
                    // fit:BoxFit.fill,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(children: [
                    // SizedBox(height: 50),
                    Container(
                      height: 200,
                      width: 500,
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
                                  child: Text("Naslov",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Sadrzaj",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                              label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Datum Objave",
                                      style: TextStyle(fontSize: 14)))),
                        ],
                        rows: _buildPlanAndProgrammeList(),
                      ),
                    ),
                  ]),
                ))));
  }

  List<DataRow> _buildPlanAndProgrammeList() {
    if (data.length == 0) {
      return [
        DataRow(cells: [
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
                DataCell(Text(x["naslov"] ?? "",style: TextStyle(fontSize: 14))),
                DataCell(
                    Text(x["sadrzaj"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  Text(
                    DateFormat('dd/MM/yyyy hh:mm a')
                        .format(DateTime.parse(x["datumObjave"])), style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ))
        .toList()
        .cast<DataRow>();
    return list;
  }
}