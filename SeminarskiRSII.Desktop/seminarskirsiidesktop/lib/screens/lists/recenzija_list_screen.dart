import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/recenzija_provider.dart';
import '../../widgets/master_screen.dart';

class RecenzijaListScreen extends StatefulWidget {
  const RecenzijaListScreen({super.key});

  @override
  State<RecenzijaListScreen> createState() => _RecenzijaListScreenState();
}

class _RecenzijaListScreenState extends State<RecenzijaListScreen> {
  late RecenzijaProvider _recenzijaProvider;
  dynamic data;
  bool isLoading = true;

  // Scroll controllers
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _recenzijaProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
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
      title: 'Sve Recenzije',
      child: Column(
        children: [
          Expanded(
            child: Center( // Centering the whole container
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
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 800), // Adjust width as needed
                                  child: DataTable(
                                    dataRowHeight: 60,
                                    headingRowHeight: 50,
                                    headingRowColor: WidgetStateProperty.all(Colors.blueGrey[50]),
                                    dividerThickness: 2,
                                    columnSpacing: 24,
                                    horizontalMargin: 12,
                                    columns: [
                                      _buildDataColumn("Id"),
                                      _buildDataColumn("Ime"),
                                      _buildDataColumn("Prezime"),
                                      _buildDataColumn("Soba broj"),
                                      _buildDataColumn("Ocjena"),
                                      _buildDataColumn("Komentar"),
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
          DataCell(SizedBox.shrink()),
        ])
      ];
    }

    return data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["id"].toString(), style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["gost"]["ime"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["gost"]["prezime"] ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["soba"]["brojSobe"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["ocjena"]?.toString() ?? "", style: const TextStyle(fontSize: 14))),
                DataCell(Text(x["komentar"] ?? "", style: const TextStyle(fontSize: 14))),
              ],
            ))
        .toList();
  }
}