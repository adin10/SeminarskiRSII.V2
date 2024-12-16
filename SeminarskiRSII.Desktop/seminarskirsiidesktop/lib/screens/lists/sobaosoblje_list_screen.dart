// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/screens/details-new/soba-osoblje_new_screen.dart';
// import '../../providers/sobaosoblje_provider.dart';
// import '../../widgets/master_screen.dart';

// class SobaOsobljeListScreen extends StatefulWidget {
//   const SobaOsobljeListScreen({super.key});

//   @override
//   State<SobaOsobljeListScreen> createState() => _SobaOsobljeListScreenState();
// }

// class _SobaOsobljeListScreenState extends State<SobaOsobljeListScreen> {

//   late SobaOsobljeProvider _sobaOsobljeProvider;
//   dynamic data = {};
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _sobaOsobljeProvider = context.read<SobaOsobljeProvider>();
//     loadData();
//   }

//    Future loadData() async {
//     var tmpData = await _sobaOsobljeProvider.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }
  
//  @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: 'Zaduzenja po sobama',
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
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Soba",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Osoblje",
//                                       style: TextStyle(fontSize: 14)))),
//                         ],
//                         rows: _buildPlanAndProgrammeList(),
//                       ),
//                     ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const NewSobaOsobljeScreen()),
//                 );
//               },
//               child: Text('Create New Soba Osoblje'),
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
//           DataCell(Text("No data..."))
//         ])
//       ];
//     }

//     List<DataRow> list = data
//         .map((x) => DataRow(
//               cells: [
//                 DataCell(Text(x["id"]?.toString() ?? "0")),
//                 DataCell(
//                     Text(x["soba"]["brojSobe"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                     Text("${x["osoblje"]["ime"]} ${x["osoblje"]["prezime"]}" ?? "", style: TextStyle(fontSize: 14))),
//               ],
//             ))
//         .toList()
//         .cast<DataRow>();
//     return list;
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/grad_new_screen.dart';
import 'package:seminarskirsiidesktop/screens/details-new/soba-osoblje_new_screen.dart';
import '../../providers/sobaosoblje_provider.dart';
import '../../widgets/master_screen.dart';
import '../details-new/drzava_new_screen.dart';

class SobaOsobljeListScreen extends StatefulWidget {
  const SobaOsobljeListScreen({super.key});

  @override
  State<SobaOsobljeListScreen> createState() => _SobaOsobljeListScreenState();
}

class _SobaOsobljeListScreenState extends State<SobaOsobljeListScreen> {
  late SobaOsobljeProvider _sobaOsobljeProvider;
  dynamic data;
  bool isLoading = true;

  // Scroll controllers
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

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
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this soba osoblje?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm ?? false) {
      try {
        await _sobaOsobljeProvider.delete(id);
        setState(() {
          loadData(); // Refresh data after deletion
        });
      } catch (e) {
        // Handle error
        print(e);
      }
    }
  }

  @override
  void dispose() {
    // Dispose scroll controllers
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Soba Osoblje',
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Scrollbar(
                      controller: _verticalController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _verticalController,
                        scrollDirection: Axis.vertical,
                        child: Scrollbar(
                          controller: _horizontalController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: _horizontalController,
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              dataRowHeight: 60,
                              headingRowHeight: 50,
                              headingRowColor: MaterialStateProperty.all(Colors.blueGrey[50]),
                              dividerThickness: 2,
                              columnSpacing: 24,
                              horizontalMargin: 12,
                              columns: [
                                _buildDataColumn("Id"),
                                _buildDataColumn("Soba"),
                                _buildDataColumn("Osoblje"),
                                DataColumn(
                                  label: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Center(child: Text('Update')),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Center(child: Text('Delete')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              rows: _buildRows(),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  NewSobaOsobljeScreen()),
                );
              },
              child: Text('Create New Soba Osoblje'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.blueGrey[700],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<DataRow> _buildRows() {
    if (data == null || data.isEmpty) {
      return [
        DataRow(cells: [
          DataCell(Text("No data...")),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink())
        ])
      ];
    }

    return data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["id"].toString(), style: TextStyle(fontSize: 14))),
                DataCell(Text(x["soba"]?["brojSobe"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(
                  "${x["osoblje"]?["ime"] ?? ""} ${x["osoblje"]?["prezime"] ?? ""}",
                  style: TextStyle(fontSize: 14),
                )),                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewSobaOsobljeScreen(
                                        sobaOsoblje: x, // Pass the entire grad object
                                      ),
                                    ),
                                  );
                                }
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(x["id"].toString()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
        .toList();
  }
}