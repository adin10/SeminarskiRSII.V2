import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/vrstaosoblja_provider.dart';
import '../../widgets/master_screen.dart';
import '../details-new/vrsta-osoblja_new_screen.dart';

class VrstaOsobljaListScreen extends StatefulWidget {
  const VrstaOsobljaListScreen({super.key});

  @override
  State<VrstaOsobljaListScreen> createState() => _VrstaOsobljaListScreenState();
}

class _VrstaOsobljaListScreenState extends State<VrstaOsobljaListScreen> {
  late VrstaOsobljaProvider _vrstaOsobljaProvider;
  dynamic data = {};
  bool isLoading = true;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _vrstaOsobljaProvider = context.read<VrstaOsobljaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _vrstaOsobljaProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this position?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm ?? false) {
      try {
        await _vrstaOsobljaProvider.delete(id);
        setState(() {
          loadData(); // Refresh data after deletion
        });
      } catch (e) {
        // Handle error
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
    title: 'Vrste osoblja',
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
                            columnSpacing: 24,
                            horizontalMargin: 12,
                            columns: const [
                              DataColumn(label: Text('Id')),
                              DataColumn(label: Text('Pozicija')),
                              DataColumn(label: Text('Zaduzenje')),
                              DataColumn(label: Text('Update')),
                              DataColumn(label: Text('Delete')),
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
                MaterialPageRoute(builder: (context) => const NewVrstaOsobljaScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: Text('Dodaj novu poziciju'),
          ),
        ),
      ],
    ),
  );
}

List<DataRow> _buildRows() {
  if (data.isEmpty) {
    return [
      const DataRow(cells: [
        DataCell(Text("No data...")),
        DataCell(Text("No data...")),
        DataCell(Text("No data...")),
        DataCell(SizedBox.shrink()),
        DataCell(SizedBox.shrink()),
      ]),
    ];
  }

  return data.map<DataRow>((x) {
    return DataRow(
      cells: [
        DataCell(Text(x["id"]?.toString() ?? "0")),
        DataCell(Text(x["pozicija"] ?? "", style: const TextStyle(fontSize: 14))),
        DataCell(Text(x["zaduzenja"] ?? "", style: const TextStyle(fontSize: 14))),
        DataCell( // Update button
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewVrstaOsobljaScreen(vrstaOsoblja: x),
                ),
              );
            },
          ),
        ),
        DataCell( // Delete button
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(x["id"].toString()),
          ),
        ),
      ],
    );
  }).toList();
}
}