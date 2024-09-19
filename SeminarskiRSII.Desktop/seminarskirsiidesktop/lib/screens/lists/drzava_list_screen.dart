import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/drzava_provider.dart';
import '../../widgets/master_screen.dart';
import '../details-new/drzava_new_screen.dart';

class DrzavaListScreen extends StatefulWidget {
  static const String drzavaRouteName = '/drzave';
  const DrzavaListScreen({super.key});

  @override
  State<DrzavaListScreen> createState() => _DrzavaListScreenState();
}

class _DrzavaListScreenState extends State<DrzavaListScreen> {
  late DrzavaProvider _drzavaProvider;
  dynamic data = {};

  // Scroll controllers
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _drzavaProvider = context.read<DrzavaProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _drzavaProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this country?'),
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
        await _drzavaProvider.delete(id);
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
    // Dispose scroll controllers
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Drzave',
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
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
                        headingRowColor: MaterialStateProperty.all(Colors.blueGrey[50]),
                        dividerThickness: 2,
                        columnSpacing: 24,
                        horizontalMargin: 12,
                        columns: [
                          DataColumn(label: Text('Naziv drzave')),
                          DataColumn(
                            label: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Actions',
                                style: TextStyle(fontSize: 14),
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
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewDrzavaScreen()),
                );
              },
              child: Text('Create New Drzava'),
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

  List<DataRow> _buildRows() {
    if (data.length == 0) {
      return [
        DataRow(cells: [
          DataCell(Text("No data...")),
          DataCell(SizedBox.shrink()),
        ])
      ];
    }

    return data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["naziv"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(
                  IconButton(
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                      ],
                    ),
                    onPressed: () => _confirmDelete(x["id"].toString()),
                  ),
                ),
              ],
            ))
        .toList();
  }
}



