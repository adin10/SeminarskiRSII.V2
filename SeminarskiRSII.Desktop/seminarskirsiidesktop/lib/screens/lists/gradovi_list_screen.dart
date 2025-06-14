import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/grad_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/grad_new_screen.dart';
import '../../widgets/master_screen.dart';

class GradListScreen extends StatefulWidget {
  const GradListScreen({super.key});

  @override
  State<GradListScreen> createState() => _GradListScreenState();
}

class _GradListScreenState extends State<GradListScreen> {
  late GradProvider _gradProvider;
  dynamic data;
  double _tableWidth = 900;
  bool isLoading = true;
  TextEditingController _searchController = TextEditingController();

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gradProvider = context.read<GradProvider>();
    loadData();
  }

  Future loadData({String? searchQuery}) async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic>? queryParams;

    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams = {'NazivGrada': searchQuery};
    }

    var tmpData = await _gradProvider.get(queryParams);

    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obrisi grad'),
        content: const Text('Da li ste sigurni da zelite obrisati grad?'),
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
        await _gradProvider.delete(id);
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
    _searchController.dispose();
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Gradovi',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: _tableWidth,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Pretraga gradova',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () =>
                          loadData(searchQuery: _searchController.text),
                    ),
                  ),
                  onEditingComplete: () {
                    loadData(searchQuery: _searchController.text);
                  },
                ),
              ),
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
                            child: SizedBox(
                              width: _tableWidth,
                              child: DataTable(
                                dataRowHeight: 60,
                                headingRowHeight: 60,
                                headingRowColor: WidgetStateProperty.all(
                                    Colors.blueGrey[50]),
                                dividerThickness: 2,
                                columnSpacing: 60,
                                horizontalMargin: 40,
                                columns: [
                                  _buildDataColumn("Naziv grada"),
                                  _buildDataColumn("Postanski broj"),
                                  _buildDataColumn("Drzava"),
                                  DataColumn(
                                    label: SizedBox(
                                      width:
                                          140,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Uredi',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey[700],
                                              )),
                                          const SizedBox(width: 30),
                                          Text('Obriši',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey[700])),
                                        ],
                                      ),
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
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 50),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewGradScreen()),
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
                label: const Text('Dodaj novi grad'),
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
        ])
      ];
    }

    return data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["nazivGrada"] ?? "",
                    style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["postanskiBroj"]?.toString() ?? "",
                    style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["drzava"]?["naziv"] ?? "",
                    style: const TextStyle(fontSize: 14))),
                DataCell(
                  SizedBox(
                    width: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewGradScreen(grad: x),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 30),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(x["id"].toString()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))
        .toList();
  }
}
