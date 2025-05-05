// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/recenzija_provider.dart';
// import '../../widgets/master_screen.dart';

// class RecenzijaListScreen extends StatefulWidget {
//   const RecenzijaListScreen({super.key});

//   @override
//   State<RecenzijaListScreen> createState() => _RecenzijaListScreenState();
// }

// class _RecenzijaListScreenState extends State<RecenzijaListScreen> {
//   late RecenzijaProvider _recenzijaProvider;
//   dynamic data;
//   bool isLoading = true;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalController = ScrollController();

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _recenzijaProvider = context.read<RecenzijaProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _recenzijaProvider.get(null);
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

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: 'Sve Recenzije',
//       child: Column(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: isLoading
//                   ? const Center(child: CircularProgressIndicator())
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
//                               headingRowColor: WidgetStateProperty.all(Colors.blueGrey[50]),
//                               dividerThickness: 2,
//                               columnSpacing: 40,
//                               horizontalMargin: 25,
//                               columns: [
//                                 _buildDataColumn("Ime"),
//                                 _buildDataColumn("Prezime"),
//                                 _buildDataColumn("Soba broj"),
//                                 _buildDataColumn("Ocjena"),
//                                 _buildDataColumn("Komentar"),
//                               ],
//                               rows: _buildRows(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
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
//         DataRow(cells: List.generate(5, (index) => const DataCell(Text("No data..."))))
//       ];
//     }

//     return List<DataRow>.generate(
//       data.length,
//       (index) {
//         var recenzija = data[index];

//         return DataRow(
//           cells: [
//             _buildDataCell(recenzija["gost"]["ime"] ?? ""),
//             _buildDataCell(recenzija["gost"]["prezime"] ?? ""),
//             _buildDataCell(recenzija["soba"]["brojSobe"]?.toString() ?? ""),
//             _buildDataCell(recenzija["ocjena"]?.toString() ?? ""),
//             _buildDataCell(recenzija["komentar"] ?? ""),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/recenzija_provider.dart';
import '../../widgets/master_screen.dart';

class RecenzijaListScreen extends StatefulWidget {
  const RecenzijaListScreen({super.key});

  @override
  State<RecenzijaListScreen> createState() => _RecenzijaListScreenState();
}

class _RecenzijaListScreenState extends State<RecenzijaListScreen> {
  late RecenzijaProvider _recenzijaProvider;

  List<dynamic> data = [];
  bool isLoading = true;

  final TextEditingController _imePrezimeController = TextEditingController();
  final TextEditingController _ocjenaController = TextEditingController();
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  String? _imePrezime;
  int? _ocjena;

  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
      _currentPage = 1;
    });

    final recenzijeResult = await _recenzijaProvider.get({
      'imePrezime': _imePrezime,
      'ocjena': _ocjena,
    });

    setState(() {
      data = recenzijeResult;
      isLoading = false;
    });
  }

  List<dynamic> get _pagedData {
    int start = (_currentPage - 1) * _itemsPerPage;
    int end = start + _itemsPerPage;
    return data.sublist(start, end > data.length ? data.length : end);
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: _imePrezimeController,
              decoration: InputDecoration(
                labelText: 'Ime ili prezime gosta',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _imePrezime = _imePrezimeController.text.trim();
                    _loadData();
                  },
                ),
              ),
              onSubmitted: (value) {
                _imePrezime = value.trim();
                _loadData();
              },
            ),
          ),
          SizedBox(
            width: 120,
            child: TextField(
              controller: _ocjenaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ocjena',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final text = _ocjenaController.text.trim();
                    _ocjena = text.isNotEmpty ? int.tryParse(text) : null;
                    _loadData();
                  },
                ),
              ),
              onSubmitted: (value) {
                final text = value.trim();
                _ocjena = text.isNotEmpty ? int.tryParse(text) : null;
                _loadData();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    if (data.isEmpty) return const SizedBox();

    int totalPages = (data.length / _itemsPerPage).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1
                ? () {
                    setState(() {
                      _currentPage--;
                    });
                  }
                : null,
          ),
          Text("Stranica $_currentPage od $totalPages | Ukupno: ${data.length}"),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < totalPages
                ? () {
                    setState(() {
                      _currentPage++;
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _imePrezimeController.dispose();
    _ocjenaController.dispose();
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Lista recenzija',
      child: Column(
        children: [
          _buildFilters(),
          const SizedBox(height: 10),
          Expanded(
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
                                    columnSpacing: 40,
                                    horizontalMargin: 25,
                                    columns: [
                                      _buildDataColumn("Ime"),
                                      _buildDataColumn("Prezime"),
                                      _buildDataColumn("Soba"),
                                      _buildDataColumn("Ocjena"),
                                      _buildDataColumn("Komentar"),
                                    ],
                                    rows: _buildRows(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                _buildPaginationControls(),
              ],
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

  List<DataRow> _buildRows() {
    if (_pagedData.isEmpty) {
      return [
        DataRow(
          cells: List.generate(5, (_) => const DataCell(Text("No data..."))),
        )
      ];
    }

    return _pagedData.map((recenzija) {
      final gost = recenzija['gost'] ?? {};
      final soba = recenzija['soba'] ?? {};

      return DataRow(
        cells: [
          _buildDataCell(gost['ime'] ?? ''),
          _buildDataCell(gost['prezime'] ?? ''),
          _buildDataCell(soba['brojSobe']?.toString() ?? ''),
          _buildDataCell(recenzija['ocjena']?.toString() ?? ''),
          _buildDataCell(recenzija['komentar'] ?? ''),
        ],
        color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.blueGrey.withOpacity(0.2);
            }
            return null;
          },
        ),
      );
    }).toList();
  }
}
