// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/screens/details-new/recenzija_new_screen.dart';

// import '../../providers/recenzija_provider.dart';
// import '../../widgets/master_screen.dart';

// class RecenzijaListScreen extends StatefulWidget {
//   const RecenzijaListScreen({super.key});

//   @override
//   State<RecenzijaListScreen> createState() => _RecenzijaListScreenState();
// }

// class _RecenzijaListScreenState extends State<RecenzijaListScreen> {

//   late RecenzijaProvider _recenzijaProvider;
//   dynamic data = {};
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _recenzijaProvider = context.read<RecenzijaProvider>();
//     loadData();
//   }

//     Future loadData() async {
//     var tmpData = await _recenzijaProvider.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: 'Sve Recenzije',
//       child: Container(
//            child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Column(children: [
//                     Container(
//                       height: 200,
//                       width: 1000,
//                       child: DataTable(
//                         columnSpacing: 12,
//                         horizontalMargin: 12,
//                         columns: [
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Id",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Ime",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Prezime",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Soba broj",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Ocjena",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Komentar",
//                                       style: TextStyle(fontSize: 14)))),
//                         ],
//                         rows: _buildPlanAndProgrammeList(),
//                       ),
//                     ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const NewRecenzijaScreen()),
//                 );
//               },
//               child: Text('Create New Recenzija'),
//             ),
//                   ]),
//                 )
//       )
//     );
//   }
//   List<DataRow> _buildPlanAndProgrammeList() {
//     if (data.length == 0) {
//       return [
//         DataRow(cells: [
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data..."))
//         ])
//       ];
//     }

//     List<DataRow> list = data
//         .map((x) => DataRow(
//               cells: [
//                 DataCell(Text(x["id"]?.toString() ?? "0")),
//                 DataCell(
//                     Text(x["gost"]["ime"] ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                     Text(x["gost"]["prezime"] ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["soba"]["brojSobe"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["ocjena"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["komentar"] ?? "", style: TextStyle(fontSize: 14))),
//               ],
//             ))
//         .toList()
//         .cast<DataRow>();
//     return list;
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/recenzija_new_screen.dart';
import '../../providers/recenzija_provider.dart';
import '../../widgets/master_screen.dart';

class RecenzijaListScreen extends StatefulWidget {
  const RecenzijaListScreen({super.key});

  @override
  State<RecenzijaListScreen> createState() => _RecenzijaListScreenState();
}

class _RecenzijaListScreenState extends State<RecenzijaListScreen> {
  late RecenzijaProvider _recenzijaProvider;
  dynamic data;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _recenzijaProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Sve Recenzije',
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columnSpacing: 20,
                        horizontalMargin: 20,
                        columns: [
                          DataColumn(
                            label: Container(
                              alignment: Alignment.center,
                              child: Text("Id", style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              alignment: Alignment.center,
                              child: Text("Ime", style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              alignment: Alignment.center,
                              child: Text("Prezime", style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              alignment: Alignment.center,
                              child: Text("Soba broj", style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              alignment: Alignment.center,
                              child: Text("Ocjena", style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              alignment: Alignment.center,
                              child: Text("Komentar", style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                        rows: _buildPlanAndProgrammeList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewRecenzijaScreen()),
                      );
                    },
                    child: Text('Create New Recenzija'),
                  ),
                ),
              ],
            ),
    );
  }

  List<DataRow> _buildPlanAndProgrammeList() {
    if (data == null || data.isEmpty) {
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
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["id"]?.toString() ?? "0")),
                DataCell(Text(x["gost"]["ime"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["gost"]["prezime"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["soba"]["brojSobe"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["ocjena"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["komentar"] ?? "", style: TextStyle(fontSize: 14))),
              ],
            ))
        .toList();
    return list;
  }
}