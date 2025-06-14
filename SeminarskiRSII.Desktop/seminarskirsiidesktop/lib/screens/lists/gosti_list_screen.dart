import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/gosti_provider.dart';
import 'package:seminarskirsiidesktop/providers/izvjestaj_gosti_provider.dart';
import 'package:seminarskirsiidesktop/screens/details-new/gost_edit_screen.dart';
import 'package:seminarskirsiidesktop/screens/lists/izvjestaj_gosti_screen.dart';
import '../../widgets/master_screen.dart';

class GostiListScreen extends StatefulWidget {
  const GostiListScreen({super.key});

  @override
  State<GostiListScreen> createState() => _GostiListScreenState();
}

class _GostiListScreenState extends State<GostiListScreen> {
  late GostiProvider _gostiProvider;
  late IzvjestajGostProvider _izvjestajGostProvider;
  dynamic data;
  bool isLoading = true;

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  String? _statusFilter;
  final List<DropdownMenuItem<String?>> _statusOptions = const [
    DropdownMenuItem(value: null, child: Text("Svi")),
    DropdownMenuItem(value: "true", child: Text("Aktivni")),
    DropdownMenuItem(value: "false", child: Text("Neaktivni")),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gostiProvider = context.read<GostiProvider>();
    _izvjestajGostProvider = context.read<IzvjestajGostProvider>();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      _currentPage = 1;
    });

    var tmpData = await _gostiProvider.get(
      ime: _imeController.text.isNotEmpty ? _imeController.text : null,
      prezime: _prezimeController.text.isNotEmpty ? _prezimeController.text : null,
      status: _statusFilter != null ? _statusFilter == "true" : null,
    );

    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  List<dynamic> get _pagedData {
    int start = (_currentPage - 1) * _itemsPerPage;
    int end = start + _itemsPerPage;
    return data.sublist(start, end > data.length ? data.length : end);
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

  @override
  void dispose() {
    _imeController.dispose();
    _prezimeController.dispose();
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Gosti',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _imeController,
                    decoration: InputDecoration(
                      labelText: 'Pretraga po imenu',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: loadData,
                      ),
                    ),
                    onEditingComplete: loadData,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _prezimeController,
                    decoration: InputDecoration(
                      labelText: 'Pretraga po prezimenu',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: loadData,
                      ),
                    ),
                    onEditingComplete: loadData,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String?>(
                    value: _statusFilter,
                    items: _statusOptions,
                    onChanged: (value) {
                      setState(() {
                        _statusFilter = value;
                      });
                      loadData();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Status',
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
                              headingRowColor: WidgetStateProperty.all(Colors.blueGrey[50]),
                              dividerThickness: 2,
                              columnSpacing: 40,
                              horizontalMargin: 25,
                              columns: [
                                _buildDataColumn("Ime"),
                                _buildDataColumn("Prezime"),
                                _buildDataColumn("Email"),
                                _buildDataColumn("Telefon"),
                                _buildDataColumn("Grad"),
                                _buildDataColumn("Korisničko ime"),
                                _buildDataColumn("Datum registracije"),
                                _buildDataColumn("Status"),
                                _buildDataColumn("Prosječna ocjena"),
                                _buildDataColumn("Rezervacije gosta"),
                                 DataColumn(
                                    label: SizedBox(
                                      width:
                                          50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Uredi',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey[700],
                                              ))
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
          _buildPaginationControls(),
        ],
      ),
    );
  }

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.blueGrey[700],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

 List<DataRow> _buildRows() {
  if (_pagedData.isEmpty) {
    return [
      DataRow(
        cells: List.generate(10, (_) => const DataCell(Text("No data..."))),
      )
    ];
  }
  return _pagedData.map<DataRow>((x) => DataRow(cells: [
    DataCell(Text(x["ime"] ?? "", style: const TextStyle(fontSize: 14))),
    DataCell(Text(x["prezime"] ?? "", style: const TextStyle(fontSize: 14))),
    DataCell(Text(x["email"] ?? "", style: const TextStyle(fontSize: 14))),
    DataCell(Text(x["telefon"] ?? "", style: const TextStyle(fontSize: 14))),
    DataCell(Text(x["grad"]["nazivGrada"] ?? "", style: const TextStyle(fontSize: 14))),
    DataCell(Text(x["korisnickoIme"] ?? "", style: const TextStyle(fontSize: 14))),
    DataCell(Text(
      x["datumRegistracije"] != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(x["datumRegistracije"]).toLocal())
          : "",
      style: const TextStyle(fontSize: 14),
    )),
    DataCell(Text(
      x["status"] == true ? "Aktivan" : "Neaktivan",
      style: const TextStyle(fontSize: 14),
    )),
    DataCell(
  Center(
    child: Text(
      x["prosjecnaOcjena"] != null
          ? (x["prosjecnaOcjena"] as num).toStringAsFixed(2)
          : "N/A",
      style: const TextStyle(fontSize: 14),
    ),
  ),
),
DataCell(
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      var korisnikId = x["id"];
                      final izvjestaj = await _izvjestajGostProvider
                          .fetchIzvjestaj(korisnikId);
                      if (izvjestaj != null) {
                        prikaziIzvjestajDialog(context, izvjestaj);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Greška pri dohvatu izvjestaja')),
                        );
                      }
                    },
                    child: const Text("Izvjestaj"),
                  ),
                ),
              ),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GostEditScreen(gost: x),
                      ),
                    );
                  },
                ),
              ),
  ])).toList();
}
}
