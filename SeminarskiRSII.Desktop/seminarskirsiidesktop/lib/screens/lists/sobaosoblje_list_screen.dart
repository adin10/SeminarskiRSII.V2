import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/soba-osoblje_new_screen.dart';
import '../../providers/sobaosoblje_provider.dart';
import '../../widgets/master_screen.dart';

class SobaOsobljeListScreen extends StatefulWidget {
  const SobaOsobljeListScreen({super.key});

  @override
  State<SobaOsobljeListScreen> createState() => _SobaOsobljeListScreenState();
}

class _SobaOsobljeListScreenState extends State<SobaOsobljeListScreen> {

  late SobaOsobljeProvider _sobaOsobljeProvider;
  dynamic data = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sobaOsobljeProvider = context.read<SobaOsobljeProvider>();
    loadData();
  }

   Future loadData() async {
    var tmpData = await _sobaOsobljeProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }
  
 @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Zaduzenja po sobama',
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
                                  child: Text("Soba",
                                      style: TextStyle(fontSize: 14)))),
                          DataColumn(
                               label: Container(
                                  alignment: Alignment.center,
                                  child: Text("Osoblje",
                                      style: TextStyle(fontSize: 14)))),
                        ],
                        rows: _buildPlanAndProgrammeList(),
                      ),
                    ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewSobaOsobljeScreen()),
                );
              },
              child: Text('Create New Soba Osoblje'),
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
                    Text(x["soba"]["brojSobe"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                    Text("${x["osoblje"]["ime"]} ${x["osoblje"]["prezime"]}" ?? "", style: TextStyle(fontSize: 14))),
              ],
            ))
        .toList()
        .cast<DataRow>();
    return list;
  }
}