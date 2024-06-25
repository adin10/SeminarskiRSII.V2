import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/vrsta-osoblja_new_screen.dart';
import '../../providers/vrstaosoblja_provider.dart';
import '../../widgets/master_screen.dart';

class VrstaOsobljaListScreen extends StatefulWidget {
  const VrstaOsobljaListScreen({super.key});

  @override
  State<VrstaOsobljaListScreen> createState() => _VrstaOsobljaListScreenState();
}

class _VrstaOsobljaListScreenState extends State<VrstaOsobljaListScreen> {

  late VrstaOsobljaProvider _vrstaOsobljaProvider;
  dynamic data = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _vrstaOsobljaProvider = context.read<VrstaOsobljaProvider>();
    loadData();
  }

   Future loadData() async {
    var tmpData = await _vrstaOsobljaProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }
  
 @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Vrste osoblja',
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
                                  child: Text("Pozicija",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                               label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Zaduzenje",
                                      style: TextStyle(fontSize: 14)))),
                        ],
                        rows: _buildPlanAndProgrammeList(),
                      ),
                    ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewVrstaOsobljaScreen()),
                );
              },
              child: Text('Create New Vrsta Osoblja'),
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
          DataCell(Text("No data..."))
        ])
      ];
    }

    List<DataRow> list = data
        .map((x) => DataRow(
              cells: [
                DataCell(Text(x["id"]?.toString() ?? "0")),
                DataCell(
                    Text(x["pozicija"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                    Text(x["zaduzenja"] ?? "", style: TextStyle(fontSize: 14))),
              ],
            ))
        .toList()
        .cast<DataRow>();
    return list;
  }
  
}