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
        DataRow(cells: List.generate(5, (index) => const DataCell(Text("No data..."))))
      ];
    }

    return List<DataRow>.generate(
      data.length,
      (index) {
        var recenzija = data[index];

        return DataRow(
          cells: [
            _buildDataCell(recenzija["gost"]["ime"] ?? ""),
            _buildDataCell(recenzija["gost"]["prezime"] ?? ""),
            _buildDataCell(recenzija["soba"]["brojSobe"]?.toString() ?? ""),
            _buildDataCell(recenzija["ocjena"]?.toString() ?? ""),
            _buildDataCell(recenzija["komentar"] ?? ""),
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
