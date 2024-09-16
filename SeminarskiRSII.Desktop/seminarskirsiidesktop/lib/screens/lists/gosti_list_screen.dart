// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsiidesktop/main.dart';
// import 'package:seminarskirsiidesktop/providers/gosti_provider.dart';
// import 'package:seminarskirsiidesktop/widgets/master_screen.dart';

// class GostiListScreen extends StatefulWidget {
//   static const String gostiRouteName = '/gosti';
//   const GostiListScreen({super.key});

//   @override
//   State<GostiListScreen> createState() => _GostiListScreenState();
// }

// class _GostiListScreenState extends State<GostiListScreen> {
//   late GostiProvider _gostiProvider;
//   dynamic data = {};
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _gostiProvider = context.read<GostiProvider>();
//     loadData();
//   }

//     Future loadData() async {
//     var tmpData = await _gostiProvider.get(null);
//     setState(() {
//       data = tmpData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       title: 'Lista gostiju',
//       child: Container(
//            child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Column(children: [
//                     Container(
//                       height: 200,
//                       width: 1000,
//                       child: DataTable(
//                         columnSpacing: 12,
//                         horizontalMargin: 12,
//                         columns: [
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Id",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Ime",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Prezime",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                               label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Email",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Telefon",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Naziv grada",
//                                       style: TextStyle(fontSize: 14)))),
//                           DataColumn(
//                                label: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Korisnicko ime",
//                                       style: TextStyle(fontSize: 14)))),
//                         ],
//                         rows: _buildPlanAndProgrammeList(),
//                       ),
//                     ),
//                   ]),
//                 )
//       )
//     );
//   }
//   List<DataRow> _buildPlanAndProgrammeList() {
//     if (data.length == 0) {
//       return [
//         DataRow(cells: [
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//           DataCell(Text("No data...")),
//         ])
//       ];
//     }

//     List<DataRow> list = data
//         .map((x) => DataRow(
//               cells: [
//                 DataCell(Text(x["id"]?.toString() ?? "0")),
//                 DataCell(
//                     Text(x["ime"] ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                     Text(x["prezime"] ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["email"] ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["telefon"] ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["grad"]["nazivGrada"] ?? "", style: TextStyle(fontSize: 14))),
//                 DataCell(
//                   Text(x["korisnickoIme"] ?? "", style: TextStyle(fontSize: 14))),
//               ],
//             ))
//         .toList()
//         .cast<DataRow>();
//     return list;
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsiidesktop/providers/gosti_provider.dart';
import 'package:seminarskirsiidesktop/widgets/master_screen.dart';

class GostiListScreen extends StatefulWidget {
  static const String gostiRouteName = '/gosti';
  const GostiListScreen({super.key});

  @override
  State<GostiListScreen> createState() => _GostiListScreenState();
}

class _GostiListScreenState extends State<GostiListScreen> {
  late GostiProvider _gostiProvider;
  dynamic data;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gostiProvider = context.read<GostiProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _gostiProvider.get(null);
    setState(() {
      data = tmpData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Lista gostiju',
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  columns: [
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            child: Text("Id",
                                style: TextStyle(fontSize: 14)))),
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            child: Text("Ime",
                                style: TextStyle(fontSize: 14)))),
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            child: Text("Prezime",
                                style: TextStyle(fontSize: 14)))),
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            child: Text("Email",
                                style: TextStyle(fontSize: 14)))),
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            child: Text("Telefon",
                                style: TextStyle(fontSize: 14)))),
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            child: Text("Naziv grada",
                                style: TextStyle(fontSize: 14)))),
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            child: Text("Korisnicko ime",
                                style: TextStyle(fontSize: 14)))),
                  ],
                  rows: _buildPlanAndProgrammeList(),
                ),
              ),
            ),
    );
  }

  List<DataRow> _buildPlanAndProgrammeList() {
    if (data == null || data.isEmpty) {
      return [
        DataRow(cells: [
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
          DataCell(Text("No data...")),
        ])
      ];
    }

    List<DataRow> list = data
        .map<DataRow>((x) => DataRow(
              cells: [
                DataCell(Text(x["id"]?.toString() ?? "0")),
                DataCell(Text(x["ime"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["prezime"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["email"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["telefon"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["grad"]["nazivGrada"] ?? "", style: TextStyle(fontSize: 14))),
                DataCell(Text(x["korisnickoIme"] ?? "", style: TextStyle(fontSize: 14))),
              ],
            ))
        .toList();
    return list;
  }
}