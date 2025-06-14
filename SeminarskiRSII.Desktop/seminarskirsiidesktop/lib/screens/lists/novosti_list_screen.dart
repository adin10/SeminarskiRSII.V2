import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/novosti_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/novosti_new_screen.dart';
import '../../widgets/master_screen.dart';
import 'package:intl/intl.dart';

class NovostiListScreen extends StatefulWidget {
  const NovostiListScreen({super.key});

  @override
  State<NovostiListScreen> createState() => _NovostiListScreenState();
}

class _NovostiListScreenState extends State<NovostiListScreen> {
  late NovostiProvider _novostiProvider;
  dynamic data;
  bool isLoading = true;
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  TextEditingController _searchController = TextEditingController();

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _novostiProvider = context.read<NovostiProvider>();
    loadData();
  }

  Future loadData({String? searchQuery}) async {
    setState(() {
      isLoading = true;
      _currentPage = 1;
    });

    Map<String, dynamic>? queryParams;

    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams = {'Naslov': searchQuery};
    }

    var tmpData = await _novostiProvider.get(queryParams);

    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

 Widget _buildPaginationControls() {
  if (data == null || data.isEmpty) return const SizedBox();

  int totalItems = data.length;
  int totalPages = (totalItems / _itemsPerPage).ceil();

  int firstItem = ((_currentPage - 1) * _itemsPerPage) + 1;
  int lastItem = (_currentPage * _itemsPerPage);
  if (lastItem > totalItems) lastItem = totalItems;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _currentPage > 1
              ? () {
                  setState(() {
                    _currentPage--;
                  });
                }
              : null,
        ),
        Text("$firstItem–$lastItem Od Ukupno $totalItems"),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: _currentPage < totalPages
              ? () {
                  setState(() {
                    _currentPage++;
                  });
                }
              : null,
        ),
      ],
    ),
  );
}

  List<dynamic> get _pagedData {
    if (data == null) return [];
    int start = (_currentPage - 1) * _itemsPerPage;
    int end = start + _itemsPerPage;
    return data.sublist(start, end > data.length ? data.length : end);
  }


  @override
  void dispose() {
    _searchController.dispose();
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  Future<void> _confirmDelete(String id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Obrisi novost'),
        content: const Text('Da li ste sigurni da zelite obrisati novost?'),
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
        await _novostiProvider.delete(id);
        setState(() {
          loadData();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Novosti',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Pretraga novosti',
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
              ],
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
                            child: DataTable(
                              dataRowHeight: 60,
                              headingRowHeight: 60,
                              headingRowColor:
                                  WidgetStateProperty.all(Colors.blueGrey[50]),
                              dividerThickness: 2,
                              columnSpacing: 40,
                              horizontalMargin: 25,
                              columns: [
                                _buildDataColumn("Naslov"),
                                _buildDataColumn("Sadrzaj"),
                                _buildDataColumn("Datum objave"),
                                _buildDataColumn("Autor"),
                                DataColumn(
                                  label: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                          width: 60,
                                          child: Center(child: Text('Uredi'))),
                                      SizedBox(
                                          width: 60,
                                          child: Center(child: Text('Obrisi'))),
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
          _buildPaginationControls(),
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
                        builder: (context) => const NewNovostScreen()),
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
                label: const Text('Dodaj novu obavijest'),
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

  String truncateContent(String content, int maxWords) {
    List<String> words = content.split(' ');
    if (words.length <= maxWords) {
      return content;
    } else {
      return words.sublist(0, maxWords).join(' ') + '...';
    }
  }

  List<DataRow> _buildRows() {
      if (_pagedData.isEmpty) {
      return [
        DataRow(
          cells: List.generate(5, (_) => const DataCell(Text("No data..."))),
        )
      ];
    }

    return _pagedData.map((novost) {
      String formattedDate = '';
      if (novost["datumObjave"] != null) {
        DateTime date = DateTime.parse(novost["datumObjave"]);
        formattedDate = DateFormat('dd-MM-yyyy').format(date);
      }

      String truncatedContent = truncateContent(novost["sadrzaj"] ?? "", 12);

      return DataRow(
        cells: [
          DataCell(Text(novost["naslov"] ?? "")),
          DataCell(Text(truncatedContent)),
          DataCell(Text(formattedDate)),
          DataCell(Text(
              "${novost["osoblje"]["ime"] ?? ""} ${novost["osoblje"]["prezime"] ?? ""}")),
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
                          builder: (context) => NewNovostScreen(
                            novost: novost,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(novost["id"].toString()),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }
}
