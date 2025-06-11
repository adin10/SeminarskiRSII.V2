import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/soba_provider.dart';
import '../../providers/recenzija_provider.dart';
import '../../widgets/master_screen.dart';

class RecenzijaListScreen extends StatefulWidget {
  const RecenzijaListScreen({super.key});

  @override
  State<RecenzijaListScreen> createState() => _RecenzijaListScreenState();
}

class _RecenzijaListScreenState extends State<RecenzijaListScreen> {
  late RecenzijaProvider _recenzijaProvider;
  late SobaProvider _sobaProvider;

  List<dynamic> data = [];
  bool isLoading = true;
  List<dynamic> sobe = [];

  final TextEditingController _imePrezimeController = TextEditingController();
  final TextEditingController _ocjenaController = TextEditingController();
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  String? _imePrezime;
  int? _ocjena;
  int? _selectedSobaId;
  bool _sortAscending = true;
  bool _sortByRating = false;

  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    _sobaProvider = context.read<SobaProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
      _currentPage = 1;
    });

    final sobeResult = await _sobaProvider.get(null);
    final recenzijeResult = await _recenzijaProvider.get({
      'imePrezime': _imePrezime,
      'ocjena': _ocjena,
      'sobaID': _selectedSobaId,
    });

    if (_sortByRating) {
      recenzijeResult.sort((a, b) =>
          _sortAscending
              ? (a["ocjena"] ?? 0).compareTo(b["ocjena"] ?? 0)
              : (b["ocjena"] ?? 0).compareTo(a["ocjena"] ?? 0));
    } else {
      recenzijeResult.sort((a, b) =>
          _sortAscending
              ? DateTime.parse(a["datumRecenzije"])
                  .compareTo(DateTime.parse(b["datumRecenzije"]))
              : DateTime.parse(b["datumRecenzije"])
                  .compareTo(DateTime.parse(a["datumRecenzije"])));
    }

    setState(() {
      sobe = sobeResult;
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
    const double fieldWidth = 300;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: fieldWidth,
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
            width: fieldWidth,
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
          SizedBox(
            width: fieldWidth,
            child: DropdownButtonFormField<int?>(
              decoration: const InputDecoration(labelText: "Soba"),
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
                _selectedSobaId = value;
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

  Future<void> _deleteComment(int id) async {
    await _recenzijaProvider.update(id);
    await _loadData();
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
                                      DataColumn(
                                        label: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _sortByRating = true;
                                              _sortAscending = !_sortAscending;
                                            });
                                            _loadData();
                                          },
                                          child: Row(
                                            children: [
                                              const Text("Ocjena"),
                                              Icon(
                                                _sortByRating
                                                    ? (_sortAscending
                                                        ? Icons.arrow_upward
                                                        : Icons.arrow_downward)
                                                    : Icons.unfold_more,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      _buildDataColumn("Komentar"),
                                      DataColumn(
                                        label: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _sortByRating = false;
                                              _sortAscending = !_sortAscending;
                                            });
                                            _loadData();
                                          },
                                          child: Row(
                                            children: [
                                              const Text("Datum recenzije"),
                                              Icon(
                                                !_sortByRating
                                                    ? (_sortAscending
                                                        ? Icons.arrow_upward
                                                        : Icons.arrow_downward)
                                                    : Icons.unfold_more,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      _buildDataColumn("Obriši komentar"),
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

  List<DataRow> _buildRows() {
    if (_pagedData.isEmpty) {
      return [
        DataRow(
          cells: List.generate(7, (_) => const DataCell(Text("No data..."))),
        )
      ];
    }

    return _pagedData.map((recenzija) {
      final gost = recenzija['gost'] ?? {};
      final soba = recenzija['soba'] ?? {};
      var datumRecenzije = recenzija["datumRecenzije"] != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(recenzija["datumRecenzije"]))
          : "";

      return DataRow(
        cells: [
          _buildDataCell(gost['ime'] ?? ''),
          _buildDataCell(gost['prezime'] ?? ''),
          _buildDataCell(soba['brojSobe']?.toString() ?? ''),
          _buildDataCell(recenzija['ocjena']?.toString() ?? ''),
          _buildDataCell(recenzija['komentar'] ?? ''),
          _buildDataCell(datumRecenzije),
          DataCell(
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: "Obriši komentar",
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Potvrda"),
                    content: const Text("Da li ste sigurni da želite obrisati komentar?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Otkaži"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Obriši"),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  await _deleteComment(recenzija['id']);
                }
              },
            ),
          ), // 🔹 DODANO
        ],
      );
    }).toList();
  }
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

