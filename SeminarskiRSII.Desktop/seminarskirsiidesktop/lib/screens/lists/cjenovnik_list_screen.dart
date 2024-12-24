// import 'package:flutter/material.dart';
// import 'package:http/io_client.dart';
// import 'dart:convert';
// import 'dart:io';
// import '../../providers/base_provider.dart';
// import '../details-new/cjenovnik_new_screen.dart';

// class CjenovnikListScreen extends StatefulWidget {
//   const CjenovnikListScreen({super.key});

//   @override
//   State<CjenovnikListScreen> createState() => _CjenovnikListScreenState();
// }

// class _CjenovnikListScreenState extends State<CjenovnikListScreen> {
//   dynamic data;
//   bool isLoading = true;

//   // Scroll controllers
//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     final http = IOClient(ioc);
//     final url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik");

//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       setState(() {
//         data = jsonDecode(response.body);
//         isLoading = false;
//       });
//     } else {
//       // Handle error
//     }
//   }

//   Future<void> _confirmDelete(String id) async {
//     final bool? confirm = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Confirm Deletion'),
//         content: Text('Are you sure you want to delete this price?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: Text('Delete'),
//           ),
//         ],
//       ),
//     );
//     if (confirm ?? false) {
//       try {
//         final ioc = HttpClient();
//         ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//         final http = IOClient(ioc);
//         final url = Uri.parse("${BaseProvider.baseUrl}/Cjenovnik/$id");

//         final response = await http.delete(url);
//         if (response.statusCode == 200) {
//           setState(() {
//             loadData(); // Refresh data after deletion
//           });
//         }
//       } catch (e) {
//         // Handle error
//         print(e);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _verticalController.dispose();
//     _horizontalController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Cjenovnici')),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : Scrollbar(
//                       controller: _verticalController,
//                       thumbVisibility: true,
//                       child: SingleChildScrollView(
//                         controller: _verticalController,
//                         scrollDirection: Axis.vertical,
//                         child: Scrollbar(
//                           controller: _horizontalController,
//                           thumbVisibility: true,
//                           child: SingleChildScrollView(
//                             controller: _horizontalController,
//                             scrollDirection: Axis.horizontal,
//                             child: DataTable(
//                               dataRowHeight: 60,
//                               headingRowHeight: 50,
//                               headingRowColor: MaterialStateProperty.all(Colors.blueGrey[50]),
//                               dividerThickness: 2,
//                               columnSpacing: 24,
//                               horizontalMargin: 12,
//                               columns: [
//                                 _buildDataColumn("Id"),
//                                 _buildDataColumn("Broj Dana"),
//                                 _buildDataColumn("Cijena"),
//                                 _buildDataColumn("Soba"),
//                                 DataColumn(
//                                   label: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         width: 60,
//                                         child: Center(child: Text('Update')),
//                                       ),
//                                       SizedBox(
//                                         width: 60,
//                                         child: Center(child: Text('Delete')),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                               rows: _buildRows(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Align(
//             alignment: Alignment.centerRight,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => NewCjenovnikScreen()),
//                 );
//               },
//               child: Text('Create New Cjenovnik'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 textStyle: TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   DataColumn _buildDataColumn(String label) {
//     return DataColumn(
//       label: Text(
//         label,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//           color: Colors.blueGrey[700],
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   List<DataRow> _buildRows() {
//     if (data == null || data.isEmpty) {
//       return [
//         DataRow(cells: [
//           DataCell(Text("No data...")),
//           DataCell(SizedBox.shrink()),
//           DataCell(SizedBox.shrink()),
//           DataCell(SizedBox.shrink()),
//           DataCell(SizedBox.shrink()),
//         ])
//       ];
//     }

//     return data
//         .map<DataRow>((x) => DataRow(
//               cells: [
//                 DataCell(Text(x["id"].toString(), style: TextStyle(fontSize: 14))),
//                 DataCell(Text(x["brojDana"].toString() ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(Text(x["cijena"].toString() ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(Text(x["soba"]["brojSobe"].toString() ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 60,
//                         child: IconButton(
//                           icon: Icon(Icons.edit, color: Colors.blue),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => NewCjenovnikScreen(cjenovnik: x),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 60,
//                         child: IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => _confirmDelete(x["id"].toString()),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ))
//         .toList();
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/cjenovnik_provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/cjenovnik_new_screen.dart';
import 'package:seminarskirsiidesktop/screens/details-new/grad_new_screen.dart';
import '../../widgets/master_screen.dart';
import '../details-new/drzava_new_screen.dart';

class CjenovnikListScreen extends StatefulWidget {
  const CjenovnikListScreen({super.key});

  @override
  State<CjenovnikListScreen> createState() => _CjenovnikListScreenState();
}

class _CjenovnikListScreenState extends State<CjenovnikListScreen> {
  late CjenovnikProvider _cjenovnikProvider;
  dynamic data;
  bool isLoading = true;

  // Scroll controllers
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cjenovnikProvider = context.read<CjenovnikProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _cjenovnikProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this price?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm ?? false) {
      try {
        await _cjenovnikProvider.delete(id);
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
      title: 'Cijene',
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
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
                              headingRowColor: WidgetStateProperty.all(Colors.blueGrey[50]),
                              dividerThickness: 2,
                              columnSpacing: 24,
                              horizontalMargin: 12,
                              columns: [
                                _buildDataColumn("Id"),
                                _buildDataColumn("Cijena"),
                                _buildDataColumn("Valuta"),
                                _buildDataColumn("Soba"),
                                const DataColumn(
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
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const NewCjenovnikScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: Text('Dodaj novu cijenu'),
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
        const DataRow(cells: [
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
                DataCell(Text(x["id"].toString(), style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["cijena"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["valuta"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["soba"]?["brojSobe"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewCjenovnikScreen(
                                        cjenovnik: x, // Pass the entire grad object
                                      ),
                                    ),
                                  );
                                }
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
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