// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/providers/cjenovnik_provider.dart';

// import '../../providers/grad_provider.dart';
// import '../../widgets/master_screen.dart';

// class CjenovnikListScreen extends StatefulWidget {
//   const CjenovnikListScreen({super.key});

//   @override
//   State<CjenovnikListScreen> createState() => _CjenovnikListScreenState();
// }

// class _CjenovnikListScreenState extends State<CjenovnikListScreen> {

//   late CjenovnikProvider _cjenovnikProvider;
//   dynamic data = {};
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _cjenovnikProvider = context.read<CjenovnikProvider>();
//     loadData();
//   }

//    Future loadData() async {
//     var tmpData = await _cjenovnikProvider.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }
  
//  @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: 'Cijene soba',
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
//                                   child: Text("Cijena",
//                                       style: TextStyle(fontSize: 14)))),
//                             DataColumn(
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Broj dana",
//                                       style: TextStyle(fontSize: 14)))),
//                         ],
//                         rows: _buildPlanAndProgrammeList(),
//                       ),
//                     ),
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
//           DataCell(Text("No data..."))
//         ])
//       ];
//     }

//     List<DataRow> list = data
//         .map((x) => DataRow(
//               cells: [
//                 DataCell(Text(x["id"]?.toString() ?? "0")),
//                 DataCell(
//                   Text(x["soba"]["brojSobe"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                     Text(x["cijena"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["brojDana"]?.toString() ?? "", style: TextStyle(fontSize: 14))),
//               ],
//             ))
//         .toList()
//         .cast<DataRow>();
//     return list;
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'dart:convert';
import 'dart:io';
import '../../providers/base_provider.dart';
import '../details-new/cjenovnik_new_screen.dart';

class CjenovnikListScreen extends StatefulWidget {
  const CjenovnikListScreen({super.key});

  @override
  State<CjenovnikListScreen> createState() => _CjenovnikListScreenState();
}

class _CjenovnikListScreenState extends State<CjenovnikListScreen> {
  dynamic data;
  bool isLoading = true;

  // Scroll controllers
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    final url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      // Handle error
    }
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this price?'),
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
        final ioc = HttpClient();
        ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        final http = IOClient(ioc);
        final url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik/$id");

        final response = await http.delete(url);
        if (response.statusCode == 200) {
          setState(() {
            loadData(); // Refresh data after deletion
          });
        }
      } catch (e) {
        // Handle error
        print(e);
      }
    }
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cjenovnici')),
      body: Column(
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
                                _buildDataColumn("Broj Dana"),
                                _buildDataColumn("Cijena"),
                                _buildDataColumn("Soba"),
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
                  MaterialPageRoute(builder: (context) => NewCjenovnikScreen()),
                );
              },
              child: Text('Create New Cjenovnik'),
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
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
        ])
      ];
    }

    return data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["id"].toString(), style: TextStyle(fontSize: 14))),
                DataCell(Text(x["brojDana"].toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["cijena"].toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["soba"]["brojSobe"].toString() ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
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
                                builder: (context) => NewCjenovnikScreen(cjenovnik: x),
                              ),
                            );
                          },
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