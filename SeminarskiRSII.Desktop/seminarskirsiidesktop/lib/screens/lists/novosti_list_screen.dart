import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/novosti_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/novosti_new_screen.dart';
import '../../widgets/master_screen.dart';

class NovostiListScreen extends StatefulWidget {
  const NovostiListScreen({super.key});

  @override
  State<NovostiListScreen> createState() => _NovostiListScreenState();
}

class _NovostiListScreenState extends State<NovostiListScreen> {
  late NovostiProvider _novostiProvider;
  dynamic data;
  bool isLoading = true;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _novostiProvider = context.read<NovostiProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _novostiProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obrisi novost'),
        content: const Text('Da li ste sigurni da zelite obrisati novost?'),
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
        await _novostiProvider.delete(id);
        setState(() {
          loadData();
        });
      } catch (e) {
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
      title: 'Novosti',
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
                                _buildDataColumn("Naslov"),
                                _buildDataColumn("Sadrzaj"),
                                _buildDataColumn("Datum obavjesti"),
                                _buildDataColumn("Autor"),
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
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewNovostScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: Text('Kreiraj novu vijest'),
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
        DataRow(cells: List.generate(6, (index) => const DataCell(Text("No data..."))))
      ];
    }

    return List<DataRow>.generate(
      data.length,
      (index) {
        var novost = data[index];

        String formattedDate = '';
        if (novost["datumObjave"] != null) {
          DateTime date = DateTime.parse(novost["datumObjave"]);
          formattedDate = DateFormat('dd-MM-yyyy').format(date);
        }

        return DataRow(
          cells: [
            _buildDataCell(novost["naslov"] ?? ""),
            _buildDataCell(novost["sadrzaj"] ?? ""),
            _buildDataCell(formattedDate),
            _buildDataCell(
              "${novost["osoblje"]["ime"] ?? ""} ${novost["osoblje"]["prezime"] ?? ""}",
            ),
      DataCell(
      IconButton(
        icon: const Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewNovostScreen(novost: novost),
            ),
          );
        },
      ),
    ),
    DataCell(
      IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => _confirmDelete(novost["id"].toString()),
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