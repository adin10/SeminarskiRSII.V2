// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:seminarskirsmobile/providers/novosti_provider.dart';

// class NovostiScreen extends StatefulWidget {
//   static const String novostiRouteName = '/novosti';
//   const NovostiScreen({Key? key}) : super(key: key);

//   @override
//   State<NovostiScreen> createState() => _NovostiScreenState();
// }

// class _NovostiScreenState extends State<NovostiScreen> {
//   NovostiProvider? _novostiProvider = null;
//   dynamic data = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _novostiProvider = context.read<NovostiProvider>();
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _novostiProvider?.getList();
//     setState(() {
//       data = tmpData;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Novosti"),
//         backgroundColor: Color.fromARGB(255, 200, 216, 199),
//       ),
//       body: SafeArea(
//         child: Container(
//           width: double.infinity, // Ensure it covers the entire width
//           height: double.infinity, // Ensure it covers the entire height
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/green.jpg"),
//               fit: BoxFit.cover, // Ensures the image fills the entire screen
//             ),
//           ),
//           child: isLoading
//               ? Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ..._buildNewsList(),
//                       ],
//                     ),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildNewsList() {
//     if (data.isEmpty) {
//       return [
//         Center(child: Text("No data available", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
//       ];
//     }

//     return data.map<Widget>((x) {
//       return Container(
//         width: double.infinity, // Ensure card width is stretched to full screen width
//         child: Card(
//           margin: EdgeInsets.symmetric(vertical: 12), // Increased margin for spacing
//           elevation: 6, // Slightly elevated card for better design
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16), // Rounded corners for a modern look
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0), // Added padding for more spacious design
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   x["naslov"] ?? "No Title",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   x["sadrzaj"] ?? "No Content",
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                   maxLines: 4,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(x["datumObjave"])),
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seminarskirsmobile/providers/novosti_provider.dart';

class NovostiScreen extends StatefulWidget {
  static const String novostiRouteName = '/novosti';
  const NovostiScreen({Key? key}) : super(key: key);

  @override
  State<NovostiScreen> createState() => _NovostiScreenState();
}

class _NovostiScreenState extends State<NovostiScreen> {
  NovostiProvider? _novostiProvider;
  List<dynamic> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _novostiProvider = context.read<NovostiProvider>();
    loadData();
  }

  Future<void> loadData() async {
    try {
      var tmpData = await _novostiProvider?.getList();
      setState(() {
        data = tmpData ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Error"),
          content: Text('Failed to load data'),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novosti"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/green.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : data.isEmpty
                  ? Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return NewsCard(data: data[index]);
                      },
                    ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final dynamic data;
  const NewsCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 12),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["naslov"] ?? "No Title",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 12),
              Text(
                data["sadrzaj"] ?? "No Content",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12),
              Text(
                DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(data["datumObjave"])),
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
