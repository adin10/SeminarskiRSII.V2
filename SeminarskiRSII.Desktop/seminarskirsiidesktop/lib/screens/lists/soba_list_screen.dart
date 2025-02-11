import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/soba_provider.dart';
import '../../widgets/master_screen.dart';
import '../details-new/soba_new_screen.dart';

class SobaListScreen extends StatefulWidget {
  static const String sobaRouteName = '/soba';
  const SobaListScreen({super.key});

  @override
  State<SobaListScreen> createState() => _SobaListScreenState();
}

class _SobaListScreenState extends State<SobaListScreen> {
  late SobaProvider _sobaProvider;
  dynamic data = {};
  bool isLoading = true;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sobaProvider = context.read<SobaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _sobaProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obrisi sobu'),
        content: const Text('Da li ste sigurni da zelite obrisati sobu?'),
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
        await _sobaProvider.delete(id);
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
      title: 'Sobe',
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
                                _buildDataColumn("Broj Sobe"),
                                _buildDataColumn("Broj Sprata"),
                                _buildDataColumn("Opis Sobe"),
                                _buildDataColumn("Soba Status"),
                                _buildDataColumn("Slika"),
                                   const DataColumn(
                                  label: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Center(child: Text('Uredi')),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Center(child: Text('Obrisi')),
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
                  MaterialPageRoute(builder: (context) => const NewSobaScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: Text('Dodaj novu sobu'),
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
        DataRow(cells: List.generate(7, (index) => const DataCell(Text("No data..."))))
      ];
    }

    return List<DataRow>.generate(
      data.length,
      (index) {
        var soba = data[index];

        return DataRow(
          cells: [
            _buildDataCell(soba["brojSobe"]?.toString() ?? ""),
            _buildDataCell(soba["brojSprata"]?.toString() ?? ""),
            _buildDataCell(soba["opisSobe"] ?? ""),
            _buildDataCell(soba["sobaStatus"]["status"] ?? ""),
            DataCell(
              SizedBox(
                width: 60,
                height: 40,
                child: Image.memory(
                  base64Decode(soba["slika"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                                builder: (context) => NewSobaScreen(soba: soba),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(soba["id"].toString()),
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