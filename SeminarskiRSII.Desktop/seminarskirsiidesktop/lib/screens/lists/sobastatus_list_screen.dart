import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/sobastatus_provider.dart';
import '../../widgets/master_screen.dart';
import '../details-new/soba-status_new_screen.dart';

class SobaStatusListScreen extends StatefulWidget {
  const SobaStatusListScreen({super.key});

  @override
  State<SobaStatusListScreen> createState() => _SobaStatusListScreenState();
}

class _SobaStatusListScreenState extends State<SobaStatusListScreen> {
  late SobaStatusProvider _sobaStatusProvider;
  dynamic data = {};
  bool isLoading = true;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sobaStatusProvider = context.read<SobaStatusProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _sobaStatusProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this room status?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm ?? false) {
      try {
        await _sobaStatusProvider.delete(id);
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
      title: 'Statusi soba',
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
                                _buildDataColumn("Status"),
                                _buildDataColumn("Opis"),
                                _buildDataColumn("Update"), // Separate column for Update
                                _buildDataColumn("Delete"), // Separate column for Delete
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
                  MaterialPageRoute(builder: (context) =>  NewSobaStatusScreen()),
                );
              },
              child: Text('Create New Room Status'),
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
        var sobaStatus = data[index];

        return DataRow(
          cells: [
            _buildDataCell(sobaStatus["id"]?.toString() ?? ""),
    _buildDataCell(sobaStatus["status"] ?? ""),
    _buildDataCell(sobaStatus["opis"] ?? ""),
    DataCell( // Update button
      IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewSobaStatusScreen(sobaStatus: sobaStatus),
            ),
          );
        },
      ),
    ),
    DataCell( // Delete button
      IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => _confirmDelete(sobaStatus["id"].toString()),
      ),
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