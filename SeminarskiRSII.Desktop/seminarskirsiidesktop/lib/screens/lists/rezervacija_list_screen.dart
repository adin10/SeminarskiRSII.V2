// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:provider/provider.dart';
// import '../../providers/rezervacija_provider.dart';
// import '../../widgets/master_screen.dart';

// class RezervacijaListScreen extends StatefulWidget {
//   const RezervacijaListScreen({super.key});

//   @override
//   State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
// }

// class _RezervacijaListScreenState extends State<RezervacijaListScreen> {

//   late RezervacijaProvider _rezervacijaProvider;
//   dynamic data = {};
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _rezervacijaProvider = context.read<RezervacijaProvider>();
//     loadData();
//   }

//     Future loadData() async {
//     var tmpData = await _rezervacijaProvider.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: 'Lista rezervacija',
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
//                                   child: Text("Datum rezervacije",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Zavrsetak Rezervacije",
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
//                   Text(x["datumRezervacije"] ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["zavrsetakRezervacije"] ?? "", style: TextStyle(fontSize: 14))),
//               ],
//             ))
//         .toList()
//         .cast<DataRow>();
//     return list;
//   }
// }





import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/rezervacija_provider.dart';
import '../../widgets/master_screen.dart';

class RezervacijaListScreen extends StatefulWidget {
  const RezervacijaListScreen({super.key});

  @override
  State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
}

class _RezervacijaListScreenState extends State<RezervacijaListScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  dynamic data;
  bool isLoading = true;

  // Scroll controllers
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _rezervacijaProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
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
      title: 'Lista rezervacija',
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
                                _buildDataColumn("Ime"),
                                _buildDataColumn("Prezime"),
                                _buildDataColumn("Soba broj"),
                                _buildDataColumn("Datum rezervacije"),
                                _buildDataColumn("Zavrsetak Rezervacije"),
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
                // Navigate to a screen to create a new reservation
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const NewRezervacijaScreen()),
                // );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: Text('Create New Reservation'),
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

  // List<DataRow> _buildRows() {
  //   if (data == null || data.isEmpty) {
  //     return [
  //       DataRow(cells: List.generate(6, (index) => DataCell(Text("No data..."))))
  //     ];
  //   }

  //   return List<DataRow>.generate(
  //     data.length,
  //     (index) {
  //       var rezervacija = data[index];

  //       return DataRow(
  //         cells: [
  //           _buildDataCell(rezervacija["id"]?.toString() ?? ""),
  //           _buildDataCell(rezervacija["gost"]["ime"] ?? ""),
  //           _buildDataCell(rezervacija["gost"]["prezime"] ?? ""),
  //           _buildDataCell(rezervacija["soba"]["brojSobe"]?.toString() ?? ""),
  //           _buildDataCell(rezervacija["datumRezervacije"] ?? ""),
  //           _buildDataCell(rezervacija["zavrsetakRezervacije"] ?? ""),
  //         ],
  //         color: MaterialStateProperty.resolveWith<Color?>(
  //           (Set<MaterialState> states) {
  //             if (states.contains(MaterialState.hovered)) {
  //               return Colors.blueGrey.withOpacity(0.2); // Highlight on hover
  //             }
  //             return null;
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  List<DataRow> _buildRows() {
  if (data == null || data.isEmpty) {
    return [
      DataRow(cells: List.generate(6, (index) => const DataCell(Text("No data..."))))
    ];
  }

  return List<DataRow>.generate(
    data.length,
    (index) {
      var rezervacija = data[index];

      // Format the date fields
      var datumRezervacije = rezervacija["datumRezervacije"] != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["datumRezervacije"]))
          : "";
      var zavrsetakRezervacije = rezervacija["zavrsetakRezervacije"] != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["zavrsetakRezervacije"]))
          : "";

      return DataRow(
        cells: [
          _buildDataCell(rezervacija["id"]?.toString() ?? ""),
          _buildDataCell(rezervacija["gost"]["ime"] ?? ""),
          _buildDataCell(rezervacija["gost"]["prezime"] ?? ""),
          _buildDataCell(rezervacija["soba"]["brojSobe"]?.toString() ?? ""),
          _buildDataCell(datumRezervacije),
          _buildDataCell(zavrsetakRezervacije),
        ],
        color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
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
