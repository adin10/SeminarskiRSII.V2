import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/soba-status_new_screen.dart';
import '../../providers/sobastatus_provider.dart';
import '../../widgets/master_screen.dart';

class SobaStatusListScreen extends StatefulWidget {
  const SobaStatusListScreen({super.key});

  @override
  State<SobaStatusListScreen> createState() => _SobaStatusListScreenState();
}

class _SobaStatusListScreenState extends State<SobaStatusListScreen> {

  late SobaStatusProvider _sobaStatusProvider;
  dynamic data = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sobaStatusProvider = context.read<SobaStatusProvider>();
    loadData();
  }

   Future loadData() async {
    var tmpData = await _sobaStatusProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }
  
 @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Statusi soba',
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
                                  child: Text("Status",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                               label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Opis",
                                      style: TextStyle(fontSize: 14)))),
                        ],
                        rows: _buildPlanAndProgrammeList(),
                      ),
                    ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewSobaStatusScreen()),
                );
              },
              child: Text('Create New Room Status'),
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
                    Text(x["status"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                    Text(x["opis"] ?? "", style: TextStyle(fontSize: 14))),
              ],
            ))
        .toList()
        .cast<DataRow>();
    return list;
  }
  
}