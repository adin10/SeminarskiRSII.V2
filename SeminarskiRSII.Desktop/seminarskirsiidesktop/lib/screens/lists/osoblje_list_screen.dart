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
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _osobljeProvider = context.read<OsobljeProvider>();
    loadData();
  }

  Future loadData() async {
    _currentPage = 1;
    var tmpData = await _osobljeProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
      _currentPage = 1;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obrisi uposlenika'),
        content: const Text('Da li ste sigurni da zelite obrisati uposlenika?'),
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
        await _osobljeProvider.delete(id);
        setState(() {
          loadData();
        });
      } catch (e) {
        print(e);
      }
    }
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

  List<dynamic> get _pagedData {
    if (data == null) return [];
    int start = (_currentPage - 1) * _itemsPerPage;
    int end = start + _itemsPerPage;
    return data.sublist(start, end > data.length ? data.length : end);
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
                              headingRowColor:
                                  WidgetStateProperty.all(Colors.blueGrey[50]),
                              dividerThickness: 2,
                              columnSpacing: 30,
                              horizontalMargin: 15,
                              columns: [
                                _buildDataColumn("Ime"),
                                _buildDataColumn("Prezime"),
                                _buildDataColumn("Email"),
                                _buildDataColumn("Telefon"),
                                _buildDataColumn("Korisnicko ime"),
                                _buildDataColumn("Slika"),
                                _buildDataColumn("Uredi"),
                                _buildDataColumn("Obrisi"),
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
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 30),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewOsobljeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black.withOpacity(0.2),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.add, size: 22),
                label: const Text('Dodaj novog uposlenika'),
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
    if (_pagedData.isEmpty) {
      return [
        DataRow(
          cells: List.generate(8, (_) => const DataCell(Text("No data..."))),
        )
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
            DataCell(
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
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
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDelete(employee["id"].toString()),
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
