import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/cjenovnik_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/cjenovnik_new_screen.dart';
import '../../widgets/master_screen.dart';

class CjenovnikListScreen extends StatefulWidget {
  const CjenovnikListScreen({super.key});

  @override
  State<CjenovnikListScreen> createState() => _CjenovnikListScreenState();
}

class _CjenovnikListScreenState extends State<CjenovnikListScreen> {
  late CjenovnikProvider _cjenovnikProvider;
  dynamic data;
  bool isLoading = true;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cjenovnikProvider = context.read<CjenovnikProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _cjenovnikProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obrisi cijenu'),
        content: const Text('Da li ste sigurni da zelite obrisati ovu cijenu?'),
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
        await _cjenovnikProvider.delete(id);
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
      title: 'Cijene',
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
                                _buildDataColumn("Cijena"),
                                _buildDataColumn("Valuta"),
                                _buildDataColumn("Soba"),
                                _buildDataColumn("Vrijedi Od"),
                                _buildDataColumn("Vrijedi Do"),
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
                  MaterialPageRoute(builder: (context) =>  const NewCjenovnikScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: Text('Dodaj novu cijenu'),
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
          DataCell(SizedBox.shrink())
        ])
      ];
    }

    return data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["cijena"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["valuta"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["soba"]?["brojSobe"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Center(child: Text(x["vrijediOd"] != null
                    ? DateTime.parse(x["vrijediOd"]).toLocal().toString().split(' ')[0]
                    : "", style: const TextStyle(fontSize: 14)))),
                DataCell(Center(child: Text(x["vrijediDo"] != null
                    ? DateTime.parse(x["vrijediDo"]).toLocal().toString().split(' ')[0]
                    : "", style: const TextStyle(fontSize: 14)))),
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
                                      builder: (context) => NewCjenovnikScreen(
                                        cjenovnik: x,
                                      ),
                                    ),
                                  );
                                }
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(x["id"].toString()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
        .toList();
  }
}