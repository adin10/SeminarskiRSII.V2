import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/rezervacija_provider.dart';
import '../../widgets/master_screen.dart';

class RezervacijaListScreen extends StatefulWidget {
  const RezervacijaListScreen({super.key});

  @override
  State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
}

class _RezervacijaListScreenState extends State<RezervacijaListScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  dynamic data;
  bool isLoading = true;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _rezervacijaProvider.get(null);
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
      title: 'Lista rezervacija',
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
                                _buildDataColumn("Datum rezervacije"),
                                _buildDataColumn("Zavrsetak Rezervacije"),
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
      var rezervacija = data[index];

      var datumRezervacije = rezervacija["datumRezervacije"] != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["datumRezervacije"]))
          : "";
      var zavrsetakRezervacije = rezervacija["zavrsetakRezervacije"] != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(rezervacija["zavrsetakRezervacije"]))
          : "";

      return DataRow(
        cells: [
          _buildDataCell(rezervacija["gost"]["ime"] ?? ""),
          _buildDataCell(rezervacija["gost"]["prezime"] ?? ""),
          _buildDataCell(rezervacija["soba"]["brojSobe"]?.toString() ?? ""),
          _buildDataCell(datumRezervacije),
          _buildDataCell(zavrsetakRezervacije),
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
