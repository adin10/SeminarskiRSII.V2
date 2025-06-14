import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/usluga_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/usluga_new_screen.dart';
import '../../widgets/master_screen.dart';

class UslugaListScreen extends StatefulWidget {
  static const String uslugaRouteName = '/usluge';
  const UslugaListScreen({super.key});

  @override
  State<UslugaListScreen> createState() => _UslugaListScreenState();
}

class _UslugaListScreenState extends State<UslugaListScreen> {
  late UslugaProvider _uslugaProvider;
  dynamic data = {};

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _uslugaProvider = context.read<UslugaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _uslugaProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obrisi Uslugu'),
        content: const Text('Da li ste sigurni da zelite obrisati uslgu?'),
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
        await _uslugaProvider.delete(id);
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
      title: 'Usluge',
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Scrollbar(
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
                        columnSpacing: 55,
                        horizontalMargin: 35,
                        columns: const [
                          DataColumn(label: Text('Naziv usluge')),
                          DataColumn(label: Text('Opis')),
                          DataColumn(label: Text('Cijena')),
                          DataColumn(
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 50),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewUslugaScreen()),
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
                label: const Text('Dodaj novu uslugu'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildRows() {
    if (data.length == 0) {
      return [
        const DataRow(cells: [
          DataCell(Text("No data...")),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink())
        ])
      ];
    }

    return data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["naziv"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["opis"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["cijena"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
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
                                builder: (context) => NewUslugaScreen(usluga: x),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(x["uslugaID"].toString()),
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