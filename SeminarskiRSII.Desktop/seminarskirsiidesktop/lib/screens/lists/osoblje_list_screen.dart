// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
// import '../../widgets/master_screen.dart';

// class OsobljeListScreen extends StatefulWidget {
//   const OsobljeListScreen({super.key});

//   @override
//   State<OsobljeListScreen> createState() => _OsobljeListScreenState();
// }

// class _OsobljeListScreenState extends State<OsobljeListScreen> {
//   late OsobljeProvider _osobljeProvider;
//   dynamic data;
//   bool isLoading = true;

//   // Scroll controllers
//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalController = ScrollController();

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _osobljeProvider = context.read<OsobljeProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _osobljeProvider.get(null);
//     setState(() {
//       data = tmpData;
//       isLoading = false;
//     });
//   }

//   @override
//   void dispose() {
//     // Dispose scroll controllers
//     _verticalController.dispose();
//     _horizontalController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: 'Lista uposlenih',
//       child: Column(
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
//                                 _buildDataColumn("Ime"),
//                                 _buildDataColumn("Prezime"),
//                                 _buildDataColumn("Email"),
//                                 _buildDataColumn("Telefon"),
//                                 _buildDataColumn("Korisnicko ime"),
//                                 _buildDataColumn("Slika"),
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
//                 // Add your "Add New Employee" action here
//               },
//               child: Text('Add New Employee'),
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
//         DataRow(cells: List.generate(7, (index) => DataCell(Text("No data..."))))
//       ];
//     }

//     return List<DataRow>.generate(
//       data.length,
//       (index) {
//         var employee = data[index];

//         return DataRow(
//           cells: [
//             _buildDataCell(employee["id"]?.toString() ?? ""),
//             _buildDataCell(employee["ime"] ?? ""),
//             _buildDataCell(employee["prezime"] ?? ""),
//             _buildDataCell(employee["email"] ?? ""),
//             _buildDataCell(employee["telefon"] ?? ""),
//             _buildDataCell(employee["korisnickoIme"] ?? ""),
//             DataCell(
//               Image.memory(
//                 base64Decode(employee["slika"] ?? ""),
//                 fit: BoxFit.cover,
//                 width: 50,
//                 height: 50,
//               ),
//             ),
//           ],
//           color: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               if (states.contains(MaterialState.hovered)) {
//                 return Colors.blueGrey.withOpacity(0.2); // Highlight on hover
//               }
//               return null;
//             },
//           ),
//         );
//       },
//     );
//   }

//   DataCell _buildDataCell(String value) {
//     return DataCell(
//       Text(
//         value,
//         style: TextStyle(
//           fontSize: 14,
//           color: Colors.grey[800],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/osoblje_provider.dart';
import '../../widgets/master_screen.dart';
import '../details-new/osoblje_new_screen.dart';

class OsobljeListScreen extends StatefulWidget {
  const OsobljeListScreen({super.key});

  @override
  State<OsobljeListScreen> createState() => _OsobljeListScreenState();
}

class _OsobljeListScreenState extends State<OsobljeListScreen> {
  late OsobljeProvider _osobljeProvider;
  dynamic data;
  bool isLoading = true;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

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
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this employee?'),
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
        await _osobljeProvider.delete(id);
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
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Lista uposlenih',
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
                                // Remove the 'Id' column to match the previous screens
                                _buildDataColumn("Ime"),
                                _buildDataColumn("Prezime"),
                                _buildDataColumn("Email"),
                                _buildDataColumn("Telefon"),
                                _buildDataColumn("Korisnicko ime"),
                                _buildDataColumn("Slika"),
                                _buildDataColumn("Edit"),
                                 _buildDataColumn("Delete"),
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
                  MaterialPageRoute(builder: (context) => const NewOsobljeScreen()),
                );
              },
              child: Text('Create New Employee'),
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
        DataRow(cells: List.generate(8, (index) => DataCell(Text("No data..."))))
      ];
    }

    return List<DataRow>.generate(
      data.length,
      (index) {
        var employee = data[index];

        return DataRow(
          cells: [
            _buildDataCell(employee["ime"] ?? ""),
            _buildDataCell(employee["prezime"] ?? ""),
            _buildDataCell(employee["email"] ?? ""),
            _buildDataCell(employee["telefon"] ?? ""),
            _buildDataCell(employee["korisnickoIme"] ?? ""),
            DataCell(
              Image.memory(
                base64Decode(employee["slika"] ?? ""),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
                 DataCell( // Update button
      IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewOsobljeScreen(osoblje: employee),
            ),
          );
        },
      ),
    ),
    DataCell( // Delete button
      IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => _confirmDelete(employee["id"].toString()),
      ),
    ),
          ],
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.blueGrey.withOpacity(0.2); // Highlight on hover
              }
              return null;
            },
          ),
        );
      },
    );
  }

  DataCell _buildDataCell(String value) {
    return DataCell(
      Text(
        value,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}