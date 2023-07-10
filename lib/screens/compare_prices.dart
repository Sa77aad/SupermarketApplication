import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_and_login/Models/Checklist.dart';
import 'package:signup_and_login/Models/ChecklistDetails.dart';
import 'package:signup_and_login/Models/Products.dart';
import 'package:signup_and_login/Models/SupermarketPrices.dart';
import 'package:signup_and_login/reusable_widgets/reusable_widget.dart';

class ComparePrices extends StatefulWidget {
  final String? queryParam;

  ComparePrices({Key? key, this.queryParam}) : super(key: key);

  @override
  State<ComparePrices> createState() => _ComparePricesState();
}

class _ComparePricesState extends State<ComparePrices> {
  List<String> myItems = [];
  final Products _product = Products("", "", "", "");
  final SupermarketPrices _supermarketPrices = SupermarketPrices("", 0);

  
  final ChecklistDetails _checklistDetails = ChecklistDetails(0, 0, "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color myColor2 = const Color(0xFF274F21);
    Color myColor = const Color(0xFFFFFFB8);
    return Scaffold(
        backgroundColor: myColor,
        appBar: AppBar(
          backgroundColor: myColor2,
          title: const Text('Compare Prices'),
        ),
        //body: _fireSearch(widget.queryParam as String));
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(child: _fireSearch(widget.queryParam as String)),
            Expanded(child: _displayPrices(widget.queryParam as String)),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {},
              child: Text(_checklistDetails.cdSupermarket),
            ),
            const Expanded(
                child: SizedBox(
              height: 20,
            ))
          ],
        ));
  }

  Widget _fireSearch(String queryParam) {
    return StreamBuilder<QuerySnapshot>(
      stream: _product.getProductDetails(queryParam),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'No Results Found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: Text(
              'No Results Found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> values =
                    _product.mapProductsDetails(snapshot, index);
                return listItem2(context, values);
              });
        }
      },
    );
  }

  Widget _displayPrices(String queryParam) {
    return StreamBuilder<QuerySnapshot>(
      stream: _supermarketPrices.getSupermarketDetails(queryParam),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'No Results Found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: Text(
              'No Results Found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          );
        } else {
          Map<String, dynamic> supermarketMap =
              _supermarketPrices.mapSupermarketDetails(snapshot, 0);

          return _fetchPrice(supermarketMap);
        }
      },
    );
  }

  Widget _fetchPrice(Map supermarketMap) {
    var SelectSupermarket = "SelectSupermarket";
    return Container(
      decoration: const BoxDecoration(
          //border: Border.all(),
          /*color: const Color.fromARGB(
            255, 255, 0, 0),*/ // Adjust the background color as desired
          ),
      alignment: Alignment.center, // Align the table at the center
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        children: <TableRow>[
          const TableRow(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                child: Text(
                  "Supermarket",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Center(
                  child: Text(
                    "Price",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Selection",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(
              color: Color(0xFFD5F591),
            ),
            children: <Widget>[
              //const Center(child: Text("Intermart")),
              //Center(child: Text(supermarketMap["Intermart"].toString())),
              const TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                    child: Text(
                  "Intermart",
                  style: TextStyle(fontSize: 16.0),
                )),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(
                    supermarketMap["Intermart"].toString(),
                    style: const TextStyle(
                      fontSize: 16.0, // Adjust the font size as needed
                    ),
                  ),
                ),
              ),

              Radio<String>(
                value: "Intermart",
                groupValue: SelectSupermarket,
                activeColor: Colors.black,
                onChanged: (String? value) {
                  setState(() {
                    _checklistDetails.cdSupermarket = value.toString();
                  });
                },
              ),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(
              color: Color(0xFF72CC50),
            ),
            children: <Widget>[
              //const Center(child: Text("Jumbo")),
              //Center(child: Text(supermarketMap["Jumbo"].toString())),
              const TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                    child: Text(
                  "Jumbo",
                  style: TextStyle(fontSize: 16.0),
                )),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(
                    supermarketMap["Jumbo"].toString(),
                    style: const TextStyle(
                      fontSize: 16.0, // Adjust the font size as needed
                    ),
                  ),
                ),
              ),
              Radio<String>(
                value: "Jumbo",
                groupValue: SelectSupermarket,
                onChanged: (String? value) {
                  setState(() {
                    _checklistDetails.cdSupermarket = value.toString();
                  });
                },
              ),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(
              color: Color(0xFFD5F591),
            ),
            children: <Widget>[
              //const Center(child: Text("Winners")),
              //Center(child: Text(supermarketMap["Winners"].toString())),
              const TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                    child: Text(
                  "Winners",
                  style: TextStyle(fontSize: 16.0),
                )),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(
                    supermarketMap["Winners"].toString(),
                    style: const TextStyle(
                      fontSize: 16.0, // Adjust the font size as needed
                    ),
                  ),
                ),
              ),
              Radio<String>(
                value: "Winners",
                groupValue: SelectSupermarket,
                onChanged: (String? value) {
                  setState(() {
                    _checklistDetails.cdSupermarket = value.toString();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
