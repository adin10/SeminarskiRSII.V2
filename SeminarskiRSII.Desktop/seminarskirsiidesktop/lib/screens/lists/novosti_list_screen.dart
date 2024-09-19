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

  // Scroll controllers
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

  @override
  void dispose() {
    // Dispose scroll controllers
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
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
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
                              headingRowColor: MaterialStateProperty.all(Colors.blueGrey[50]),
                              dividerThickness: 2,
                              columnSpacing: 24,
                              horizontalMargin: 12,
                              columns: [
                                _buildDataColumn("Id"),
                                _buildDataColumn("Naslov"),
                                _buildDataColumn("Sadrzaj"),
                                _buildDataColumn("Datum obavjesti"),
                                _buildDataColumn("Autor"),
                              ],
                              rows: _buildRows(),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewNovostScreen()),
                );
              },
              child: Text('Create New Notification'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
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
      DataRow(cells: List.generate(5, (index) => DataCell(Text("No data..."))))
    ];
  }

  return List<DataRow>.generate(
    data.length,
    (index) {
      var novost = data[index];

      // Format datumObjave as date only
      String formattedDate = '';
      if (novost["datumObjave"] != null) {
        DateTime date = DateTime.parse(novost["datumObjave"]);
        formattedDate = DateFormat('dd-MM-yyyy').format(date);  // Customize the format as needed
      }

      return DataRow(
        cells: [
          _buildDataCell(novost["id"]?.toString() ?? ""),
          _buildDataCell(novost["naslov"] ?? ""),
          _buildDataCell(novost["sadrzaj"] ?? ""),
          _buildDataCell(formattedDate),  // Use formatted date
          _buildDataCell(
            "${novost["osoblje"]["ime"] ?? ""} ${novost["osoblje"]["prezime"] ?? ""}",
          ),
        ],
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.blueGrey.withOpacity(0.2); // Highlight on hover
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