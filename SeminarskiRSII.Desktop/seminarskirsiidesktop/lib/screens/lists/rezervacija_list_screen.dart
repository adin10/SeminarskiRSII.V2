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

  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    _sobaProvider = context.read<SobaProvider>();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      _currentPage = 1;
    });

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

  List<dynamic> get _pagedData {
    if (data == null) return [];
    int start = (_currentPage - 1) * _itemsPerPage;
    int end = start + _itemsPerPage;
    return data.sublist(start, end > data.length ? data.length : end);
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 30,
        runSpacing: 15,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 220,
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
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    // OD
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Od: "),
          TextButton(
            onPressed: () => _selectDate(context, true),
            child: Text(
              _startDate != null
                  ? DateFormat('dd.MM.yyyy').format(_startDate!)
                  : 'Izaberi',
            ),
          ),
          if (_startDate != null)
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: InkWell(
                child: const Icon(Icons.close, size: 18),
                onTap: () {
                  setState(() {
                    _startDate = null;
                  });
                  loadData();
                },
              ),
            ),
        ],
      ),
    ),
    // DO
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Do: "),
          TextButton(
            onPressed: () => _selectDate(context, false),
            child: Text(
              _endDate != null
                  ? DateFormat('dd.MM.yyyy').format(_endDate!)
                  : 'Izaberi',
            ),
          ),
          if (_endDate != null)
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: InkWell(
                child: const Icon(Icons.close, size: 18),
                onTap: () {
                  setState(() {
                    _endDate = null;
                  });
                  loadData();
                },
              ),
            ),
        ],
      ),
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

Widget _buildPaginationControls() {
  if (data == null || data.isEmpty) return const SizedBox();

  int totalItems = data.length;
  int totalPages = (totalItems / _itemsPerPage).ceil();

  int firstItem = ((_currentPage - 1) * _itemsPerPage) + 1;
  int lastItem = (_currentPage * _itemsPerPage);
  if (lastItem > totalItems) lastItem = totalItems;

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
        Text("$firstItem–$lastItem Od Ukupno $totalItems"),
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
                                    columnSpacing: 60,
                                    horizontalMargin: 35,
                                    columns: [
                                      _buildDataColumn("Ime"),
                                      _buildDataColumn("Prezime"),
                                      _buildDataColumn("Soba broj"),
                                      _buildDataColumn("Datum rezervacije"),
                                      _buildDataColumn("Zavrsetak Rezervacije"),
                                      DataColumn(
                                        label: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              child:
                                                  Center(child: Text('Otkazi')),
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

  List<DataRow> _buildRows() {
    if (_pagedData.isEmpty) {
      return [
        DataRow(cells: List.generate(6, (index) => const DataCell(Text("No data..."))))
      ];
    }

    return List<DataRow>.generate(
      _pagedData.length,
      (index) {
        var rezervacija = _pagedData[index];

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
             DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(rezervacija["id"].toString()),
                        ),
                      ),
                    ],
                  ),
                ),
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

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Otkazi Rezervaciju'),
        content: const Text('Da li ste sigurni da zelite otkazati rezervaciju gostu?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Odustani'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Obrisi'),
          ),
        ],
      ),
    );
    if (confirm ?? false) {
      try {
        await _rezervacijaProvider.delete(id);
        setState(() {
          loadData();
        });
      } catch (e) {
        print(e);
      }
    }
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
