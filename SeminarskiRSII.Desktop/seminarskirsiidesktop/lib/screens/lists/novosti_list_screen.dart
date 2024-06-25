import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/novosti_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/novosti_new_screen.dart';
import '../../widgets/master_screen.dart';

class NovostiListScreen extends StatefulWidget {
  const NovostiListScreen({super.key});

  @override
  State<NovostiListScreen> createState() => _NovostiListScreenState();
}

class _NovostiListScreenState extends State<NovostiListScreen> {

  late NovostiProvider _novostiProvider;
  dynamic data = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _novostiProvider = context.read<NovostiProvider>();
    loadData();
  }

   Future loadData() async {
    var tmpData = await _novostiProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }
  
 @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Novosti',
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
                                  child: Text("Datum obavjesti",
                                      style: TextStyle(fontSize: 14)))),
                            DataColumn(
                               label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Autor",
                                      style: TextStyle(fontSize: 14)))),
                        ],
                        rows: _buildPlanAndProgrammeList(),
                      ),
                    ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewNovostScreen()),
                );
              },
              child: Text('Create New Notification'),
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
          DataCell(Text("No data..."))
        ])
      ];
    }

    List<DataRow> list = data
        .map((x) => DataRow(
              cells: [
                DataCell(Text(x["id"]?.toString() ?? "0")),
                DataCell(
                    Text(x["naslov"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                    Text(x["sadrzaj"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                    Text(x["datumObjave"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  Text("${x["osoblje"]["ime"]} ${x["osoblje"]["prezime"]}" ?? "", style: TextStyle(fontSize: 14))),
              ],
            ))
        .toList()
        .cast<DataRow>();
    return list;
  }
}