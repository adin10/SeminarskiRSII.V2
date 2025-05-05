// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
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
//   dynamic data;
//   bool isLoading = true;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalController = ScrollController();

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _rezervacijaProvider = context.read<RezervacijaProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _rezervacijaProvider.get(null);
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
//       title: 'Lista rezervacija',
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
//                                 _buildDataColumn("Datum rezervacije"),
//                                 _buildDataColumn("Zavrsetak Rezervacije"),
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
//   if (data == null || data.isEmpty) {
//     return [
//       DataRow(cells: List.generate(5, (index) => const DataCell(Text("No data..."))))
//     ];
//   }

//   return List<DataRow>.generate(
//     data.length,
//     (index) {
//       var rezervacija = data[index];

//       var datumRezervacije = rezervacija["datumRezervacije"] != null
//           ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["datumRezervacije"]))
//           : "";
//       var zavrsetakRezervacije = rezervacija["zavrsetakRezervacije"] != null
//           ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["zavrsetakRezervacije"]))
//           : "";

//       return DataRow(
//         cells: [
//           _buildDataCell(rezervacija["gost"]["ime"] ?? ""),
//           _buildDataCell(rezervacija["gost"]["prezime"] ?? ""),
//           _buildDataCell(rezervacija["soba"]["brojSobe"]?.toString() ?? ""),
//           _buildDataCell(datumRezervacije),
//           _buildDataCell(zavrsetakRezervacije),
//         ],
//         color: WidgetStateProperty.resolveWith<Color?>(
//           (Set<WidgetState> states) {
//             if (states.contains(WidgetState.hovered)) {
//               return Colors.blueGrey.withOpacity(0.2);
//             }
//             return null;
//           },
//         ),
//       );
//     },
//   );
// }

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


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
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
//   dynamic data;
//   bool isLoading = true;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalController = ScrollController();

//   String? _imePrezimeFilter;
//   DateTime? _startDate;
//   DateTime? _endDate;
//   int? _selectedSoba;
//   bool _showOnlyActive = false;

//   List<int> _brojeviSoba = [];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _rezervacijaProvider = context.read<RezervacijaProvider>();
//     loadData();
//   }

//   Future<void> loadData() async {
//     Map<String, dynamic> filters = {};

//     if (_imePrezimeFilter != null && _imePrezimeFilter!.isNotEmpty) {
//       filters['imePrezime'] = _imePrezimeFilter;
//     }

//     if (_startDate != null) {
//       filters['datumOd'] = DateFormat('yyyy-MM-dd').format(_startDate!);
//     }

//     if (_endDate != null) {
//       filters['datumDo'] = DateFormat('yyyy-MM-dd').format(_endDate!);
//     }

//     if (_selectedSoba != null) {
//       filters['brojSobe'] = _selectedSoba;
//     }

//     if (_showOnlyActive) {
//       filters['samoAktivne'] = true;
//     }

//     var tmpData = await _rezervacijaProvider.get(filters);

//     setState(() {
//       data = tmpData;
//       isLoading = false;

//       // Napuni dropdown sa brojevima soba
//       // _brojeviSoba = data
//       //     .map<int>((x) => x['soba']?['brojSobe'])
//       //     .where((broj) => broj != null)
//       //     .toSet()
//       //     .cast<int>()
//       //     .toList()
//       //   ..sort();

//       _brojeviSoba = data.map((x) => x['soba']?['brojSobe'])
//       .whereType<int>()
//       .toSet()
//       .toList()
//       ..sort();
//     });
//   }

//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           _startDate = picked;
//         } else {
//           _endDate = picked;
//         }
//       });
//       loadData();
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
//     return MasterScreenWidget(
//       title: 'Lista rezervacija',
//       child: Column(
//         children: [
//           _buildFilterSection(),
//           const SizedBox(height: 16),
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
//                                 _buildDataColumn("Datum rezervacije"),
//                                 _buildDataColumn("Zavrsetak Rezervacije"),
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

//   Widget _buildFilterSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Wrap(
//         spacing: 20,
//         runSpacing: 12,
//         crossAxisAlignment: WrapCrossAlignment.center,
//         children: [
//           SizedBox(
//             width: 200,
//             child: TextField(
//               decoration: const InputDecoration(labelText: 'Ime ili prezime gosta'),
//               onChanged: (value) {
//                 _imePrezimeFilter = value;
//                 loadData();
//               },
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Od datuma"),
//               TextButton(
//                 onPressed: () => _selectDate(context, true),
//                 child: Text(_startDate == null
//                     ? 'Odaberi'
//                     : DateFormat('dd.MM.yyyy').format(_startDate!)),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Do datuma"),
//               TextButton(
//                 onPressed: () => _selectDate(context, false),
//                 child: Text(_endDate == null
//                     ? 'Odaberi'
//                     : DateFormat('dd.MM.yyyy').format(_endDate!)),
//               ),
//             ],
//           ),
//           DropdownButton<int>(
//             hint: const Text("Broj sobe"),
//             value: _selectedSoba,
//             items: _brojeviSoba.map((broj) {
//               return DropdownMenuItem<int>(
//                 value: broj,
//                 child: Text(broj.toString()),
//               );
//             }).toList(),
//             onChanged: (value) {
//               setState(() {
//                 _selectedSoba = value;
//               });
//               loadData();
//             },
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Checkbox(
//                 value: _showOnlyActive,
//                 onChanged: (value) {
//                   setState(() {
//                     _showOnlyActive = value ?? false;
//                   });
//                   loadData();
//                 },
//               ),
//               const Text("Samo aktivne/buduće"),
//             ],
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
//         var rezervacija = data[index];

//         var datumRezervacije = rezervacija["datumRezervacije"] != null
//             ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["datumRezervacije"]))
//             : "";
//         var zavrsetakRezervacije = rezervacija["zavrsetakRezervacije"] != null
//             ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["zavrsetakRezervacije"]))
//             : "";

//         return DataRow(
//           cells: [
//             _buildDataCell(rezervacija["gost"]["ime"] ?? ""),
//             _buildDataCell(rezervacija["gost"]["prezime"] ?? ""),
//             _buildDataCell(rezervacija["soba"]["brojSobe"]?.toString() ?? ""),
//             _buildDataCell(datumRezervacije),
//             _buildDataCell(zavrsetakRezervacije),
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


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
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
//   dynamic data;
//   bool isLoading = true;

//   final ScrollController _verticalController = ScrollController();
//   final ScrollController _horizontalController = ScrollController();

//   // Filter polja
//   String? _imePrezime;
//   int? _selectedSoba;
//   DateTime? _datumOd;
//   DateTime? _datumDo;
//   bool? _aktivneSamo;
//   List<int> _brojeviSoba = [];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _rezervacijaProvider = context.read<RezervacijaProvider>();
//     loadData();
//   }

//   Future<void> loadData() async {
//     setState(() {
//       isLoading = true;
//     });

//     final Map<String, dynamic> params = {};

//     if (_imePrezime != null && _imePrezime!.isNotEmpty) {
//       params['imePrezime'] = _imePrezime;
//     }
//     if (_selectedSoba != null) {
//       params['brojSobe'] = _selectedSoba;
//     }
//     if (_datumOd != null) {
//       params['datumOd'] = _datumOd!.toIso8601String();
//     }
//     if (_datumDo != null) {
//       params['datumDo'] = _datumDo!.toIso8601String();
//     }
//     if (_aktivneSamo != null) {
//       params['aktivne'] = _aktivneSamo;
//     }

//     var tmpData = await _rezervacijaProvider.get(params);

//     setState(() {
//       data = tmpData;
//       isLoading = false;
//       _brojeviSoba = tmpData
//           .map<int>((e) => e['soba']['brojSobe'] as int)
//           .toSet()
//           .toList()
//         ..sort();
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
//       title: 'Lista rezervacija',
//       child: Column(
//         children: [
//           _buildFilterForm(),
//           const SizedBox(height: 12),
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
//                                 _buildDataColumn("Datum rezervacije"),
//                                 _buildDataColumn("Zavrsetak Rezervacije"),
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

//   Widget _buildFilterForm() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 12,
//         children: [
//           SizedBox(
//             width: 200,
//             child: TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Ime/prezime gosta',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//               onChanged: (value) {
//                 _imePrezime = value;
//               },
//             ),
//           ),
//           SizedBox(
//             width: 200,
//             child: DropdownButtonFormField<int>(
//               decoration: const InputDecoration(
//                 labelText: 'Broj sobe',
//                 border: OutlineInputBorder(),
//               ),
//               value: _selectedSoba,
//               items: _brojeviSoba
//                   .map((broj) => DropdownMenuItem(
//                         value: broj,
//                         child: Text(broj.toString()),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedSoba = value;
//                 });
//               },
//               isExpanded: true,
//             ),
//           ),
//           SizedBox(
//             width: 180,
//             child: InputDatePickerFormField(
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//               initialDate: _datumOd ?? DateTime.now(),
//               fieldLabelText: 'Od datuma',
//               onDateSubmitted: (date) {
//                 setState(() {
//                   _datumOd = date;
//                 });
//               },
//             ),
//           ),
//           SizedBox(
//             width: 180,
//             child: InputDatePickerFormField(
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//               initialDate: _datumDo ?? DateTime.now(),
//               fieldLabelText: 'Do datuma',
//               onDateSubmitted: (date) {
//                 setState(() {
//                   _datumDo = date;
//                 });
//               },
//             ),
//           ),
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<bool>(
//               decoration: const InputDecoration(
//                 labelText: 'Status',
//                 border: OutlineInputBorder(),
//               ),
//               value: _aktivneSamo,
//               items: const [
//                 DropdownMenuItem(value: null, child: Text("Sve")),
//                 DropdownMenuItem(value: true, child: Text("Aktivne/Buduće")),
//                 DropdownMenuItem(value: false, child: Text("Završene")),
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   _aktivneSamo = value;
//                 });
//               },
//               isExpanded: true,
//             ),
//           ),
//           ElevatedButton.icon(
//             onPressed: () => loadData(),
//             icon: const Icon(Icons.search),
//             label: const Text("Pretraži"),
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
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
//         DataRow(cells: List.generate(5, (index) => const DataCell(Text("No data..."))))
//       ];
//     }

//     return List<DataRow>.generate(
//       data.length,
//       (index) {
//         var rezervacija = data[index];

//         var datumRezervacije = rezervacija["datumRezervacije"] != null
//             ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["datumRezervacije"]))
//             : "";
//         var zavrsetakRezervacije = rezervacija["zavrsetakRezervacije"] != null
//             ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["zavrsetakRezervacije"]))
//             : "";

//         return DataRow(
//           cells: [
//             _buildDataCell(rezervacija["gost"]["ime"] ?? ""),
//             _buildDataCell(rezervacija["gost"]["prezime"] ?? ""),
//             _buildDataCell(rezervacija["soba"]["brojSobe"]?.toString() ?? ""),
//             _buildDataCell(datumRezervacije),
//             _buildDataCell(zavrsetakRezervacije),
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





// popraviti ovde sobe samo treba
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/rezervacija_provider.dart';
import '../../providers/soba_provider.dart';
import '../../widgets/master_screen.dart';

class RezervacijaListScreen extends StatefulWidget {
  const RezervacijaListScreen({super.key});

  @override
  State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
}

class _RezervacijaListScreenState extends State<RezervacijaListScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  late SobaProvider _sobaProvider;

  dynamic data;
  List<dynamic> sobe = [];
  bool isLoading = true;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();
  final TextEditingController _imePrezimeController = TextEditingController();

  String? _imePrezime;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _selectedSobaId;
  bool _samoBuduce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    _sobaProvider = context.read<SobaProvider>();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);

    final sobeResult = await _sobaProvider.get(null);
    final rezervacijeResult = await _rezervacijaProvider.get({
      'imePrezime': _imePrezime,
      'datumRezervacije': _startDate?.toIso8601String(),
      'zavrsetakRezervacije': _endDate?.toIso8601String(),
      'sobaID': _selectedSobaId,
      'samoBuduce': _samoBuduce,
    });

    setState(() {
      sobe = sobeResult;
      data = rezervacijeResult;
      isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
      await loadData();
    }
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
          loadData();
        },
      ),
    ),
    onSubmitted: (value) {
      _imePrezime = value.trim();
      loadData();
    },
  ),
),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Od: "),
              TextButton(
                onPressed: () => _selectDate(context, true),
                child: Text(_startDate != null
                    ? DateFormat('dd.MM.yyyy').format(_startDate!)
                    : 'Izaberi'),
              ),
              const Text("Do: "),
              TextButton(
                onPressed: () => _selectDate(context, false),
                child: Text(_endDate != null
                    ? DateFormat('dd.MM.yyyy').format(_endDate!)
                    : 'Izaberi'),
              ),
            ],
          ),
         DropdownButton<int?>(
  hint: const Text("Sve sobe"),
  value: sobe.any((s) => s['id'] == _selectedSobaId) ? _selectedSobaId : null,
  items: [
    const DropdownMenuItem<int?>(
      value: null,
      child: Text("Sve sobe"),
    ),
    ...sobe.map<DropdownMenuItem<int?>>((soba) {
      return DropdownMenuItem<int?>(
        value: soba['id'],
        child: Text("Broj sobe: ${soba['brojSobe']}"),
      );
    }).toList(),
  ],
  onChanged: (value) {
    setState(() {
      _selectedSobaId = value;
    });
    loadData();
  },
),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: _samoBuduce,
                onChanged: (value) {
                  setState(() {
                    _samoBuduce = value ?? false;
                  });
                  loadData();
                },
              ),
              const Text("buduće rezervacije"),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _imePrezimeController.dispose();
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
          _buildFilters(),
          const SizedBox(height: 10),
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
        DataRow(cells: List.generate(5, (index) => const DataCell(Text("No data..."))))
      ];
    }

    return List<DataRow>.generate(
      data.length,
      (index) {
        var rezervacija = data[index];

        var datumRezervacije = rezervacija["datumRezervacije"] != null
            ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["datumRezervacije"]))
            : "";
        var zavrsetakRezervacije = rezervacija["zavrsetakRezervacije"] != null
            ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["zavrsetakRezervacije"]))
            : "";

        return DataRow(
          cells: [
            _buildDataCell(rezervacija["gost"]["ime"] ?? ""),
            _buildDataCell(rezervacija["gost"]["prezime"] ?? ""),
            _buildDataCell(rezervacija["soba"]["brojSobe"]?.toString() ?? ""),
            _buildDataCell(datumRezervacije),
            _buildDataCell(zavrsetakRezervacije),
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
