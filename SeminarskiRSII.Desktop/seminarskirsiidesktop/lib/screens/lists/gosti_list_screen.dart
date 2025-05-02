// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/providers/gosti_provider.dart';
// import 'package:seminarskirsiidesktop/widgets/master_screen.dart';

// class GostiListScreen extends StatefulWidget {
//   static const String gostiRouteName = '/gosti';
//   const GostiListScreen({super.key});

//   @override
//   State<GostiListScreen> createState() => _GostiListScreenState();
// }

// class _GostiListScreenState extends State<GostiListScreen> {
//   late GostiProvider _gostiProvider;
//   dynamic data;
//   bool isLoading = true;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalController = ScrollController();

//    final TextEditingController _imeController = TextEditingController();
//   final TextEditingController _prezimeController = TextEditingController();

//  @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _gostiProvider = context.read<GostiProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     setState(() {
//       isLoading = true;
//     });

//     var tmpData = await _gostiProvider.get(
//       ime: _imeController.text.isNotEmpty ? _imeController.text : null,
//       prezime: _prezimeController.text.isNotEmpty ? _prezimeController.text : null,
//     );

//     setState(() {
//       data = tmpData;
//       isLoading = false;
//     });
//   }

//   @override
//   void dispose() {
//     _verticalController.dispose();
//     _horizontalController.dispose();
//     super.dispose();
//   }

//  @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: 'Lista gostiju',
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _imeController,
//                     decoration: InputDecoration(labelText: "Ime", border: OutlineInputBorder()),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: TextField(
//                     controller: _prezimeController,
//                     decoration: InputDecoration(labelText: "Prezime", border: OutlineInputBorder()),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: loadData, 
//                   child: const Text("Pretraži"),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : _buildDataTable(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//  Widget _buildDataTable() {
//     return Scrollbar(
//       controller: _verticalController,
//       thumbVisibility: true,
//       child: SingleChildScrollView(
//         controller: _verticalController,
//         scrollDirection: Axis.vertical,
//         child: Scrollbar(
//           controller: _horizontalController,
//           thumbVisibility: true,
//           child: SingleChildScrollView(
//             controller: _horizontalController,
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               dataRowHeight: 60,
//               headingRowHeight: 50,
//               headingRowColor: WidgetStateProperty.all(Colors.blueGrey[50]),
//               dividerThickness: 2,
//               columnSpacing: 40,
//               horizontalMargin: 25,
//               columns: [
//                 _buildDataColumn("Ime"),
//                 _buildDataColumn("Prezime"),
//                 _buildDataColumn("Email"),
//                 _buildDataColumn("Telefon"),
//                 _buildDataColumn("Naziv grada"),
//                 _buildDataColumn("Korisnicko ime"),
//               ],
//               rows: _buildRows(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   DataColumn _buildDataColumn(String label) {
//     return DataColumn(
//       label: Text(
//         label,
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueGrey[700]),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   List<DataRow> _buildRows() {
//     if (data == null || data.isEmpty) {
//       return [DataRow(cells: List.generate(6, (index) => const DataCell(Text("No data..."))))];
//     }

//     return List<DataRow>.generate(
//       data.length,
//       (index) {
//         var guest = data[index];

//         return DataRow(
//           cells: [
//             _buildDataCell(guest["ime"] ?? ""),
//             _buildDataCell(guest["prezime"] ?? ""),
//             _buildDataCell(guest["email"] ?? ""),
//             _buildDataCell(guest["telefon"] ?? ""),
//             _buildDataCell(guest["grad"]["nazivGrada"] ?? ""),
//             _buildDataCell(guest["korisnickoIme"] ?? ""),
//           ],
//           color: WidgetStateProperty.resolveWith<Color?>(
//             (Set<WidgetState> states) {
//               if (states.contains(WidgetState.hovered)) {
//                 return Colors.blueGrey.withOpacity(0.2);
//               }
//               return null;
//             },
//           ),
//         );
//       },
//     );
//   }

//   DataCell _buildDataCell(String value) {
//     return DataCell(Text(value, style: TextStyle(fontSize: 14, color: Colors.grey[800])));
//   }
// }






import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/gosti_provider.dart';
import '../../widgets/master_screen.dart';

class GostiListScreen extends StatefulWidget {
  const GostiListScreen({super.key});

  @override
  State<GostiListScreen> createState() => _GostiListScreenState();
}

class _GostiListScreenState extends State<GostiListScreen> {
  late GostiProvider _gostiProvider;
  dynamic data;
  bool isLoading = true;

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gostiProvider = context.read<GostiProvider>();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    var tmpData = await _gostiProvider.get(
      ime: _imeController.text.isNotEmpty ? _imeController.text : null,
      prezime: _prezimeController.text.isNotEmpty ? _prezimeController.text : null,
    );

    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _imeController.dispose();
    _prezimeController.dispose();
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Gosti',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _imeController,
                    decoration: InputDecoration(
                      labelText: 'Pretraga po imenu',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: loadData,
                      ),
                    ),
                    onEditingComplete: loadData,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _prezimeController,
                    decoration: InputDecoration(
                      labelText: 'Pretraga po prezimenu',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: loadData,
                      ),
                    ),
                    onEditingComplete: loadData,
                  ),
                ),
              ],
            ),
          ),

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
                              headingRowHeight: 60,
                              headingRowColor: WidgetStateProperty.all(Colors.blueGrey[50]),
                              dividerThickness: 2,
                              columnSpacing: 40,
                              horizontalMargin: 25,
                              columns: [
                                _buildDataColumn("Ime"),
                                _buildDataColumn("Prezime"),
                                _buildDataColumn("Email"),
                                _buildDataColumn("Telefon"),
                                _buildDataColumn("Grad"),
                                _buildDataColumn("Korisnicko ime"),
                                _buildDataColumn("Datum registracije"),
                                _buildDataColumn("Status")
                              ],
                              rows: _buildRows(),
                            ),
                          ),
                        ),
                      ),
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
        const DataRow(cells: [
          DataCell(Text("No data...")),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink())
        ])
      ];
    }

    return data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["ime"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["prezime"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["email"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["telefon"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["grad"]["nazivGrada"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["korisnickoIme"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["datumRegistracije"] != null
                  ? DateTime.parse(x["datumRegistracije"]).toLocal().toString().split(' ')[0]
                  : "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["status"] == true ? "Aktivan" : "Neaktivan",
              style: const TextStyle(fontSize: 14))),
              ],
            ))
        .toList();
  }
}
