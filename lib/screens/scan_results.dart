import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_and_login/screens/home_screen.dart';
import 'package:signup_and_login/Models/Products.dart';

class ScanResults extends StatefulWidget {
  final String? scanBarcode;

  //final Products _product = Products("", "", "", "");

  //ScanResults({required this.scanBarcode});
  const ScanResults({Key? key, this.scanBarcode}) : super(key: key);

  @override
  State<ScanResults> createState() => _ScanResultsState();
}

class _ScanResultsState extends State<ScanResults> {
  final Products _product = Products("", "", "", "");
  //final SupermarketPrices _supermarketPrices = SupermarketPrices("", 0);
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
          title: const Text('Scanned results'),
        ),
        //body: _fireSearch(widget.queryParam as String));
        body: Column(
          children: [
            /*const SizedBox(
              height: 20,
            ),*/
            Expanded(
              child: FractionallySizedBox(
                heightFactor: 1.1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: myColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _barcodeReader(widget.scanBarcode as String),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _barcodeReader(String scanBarcode) {
    return StreamBuilder<QuerySnapshot>(
        stream: _product.getProductDetailsViaBarcode(scanBarcode),
        builder: (context, snapshot) {
          List<Column> barcodeWidgets = [];
          if (snapshot.hasData) {
            final scannedBarcodes = snapshot.data?.docs.reversed.toList();
            for (var barcode in scannedBarcodes!) {
              final barcodeWidget = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    barcode['URL'],
                    width: 300,
                    height: 300,
                  ),
                  Container(
                    //color: Color.fromARGB(255, 64, 181, 41),
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFD5F591),
                          spreadRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 14.0),
                      child: Text.rich(TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Description: ' + '\n' + '\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: barcode['Description'] + '\n' + '\n',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const TextSpan(
                            text: 'Category: ' + '\n' + '\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: barcode['Category'],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ], /*"Description:" + "\n" + barcode['Description']*/
                      )),
                    ),

                    //Text(barcode['Description'] + '\n' + barcode['Brand'] + '\n'),
                  ),
                ],
              );

              barcodeWidgets.add(barcodeWidget);
            }
          }
          const SizedBox(
            height: 10,
          );

          return Expanded(
            child: ListView(
              children: barcodeWidgets,
            ),
          );
        });
  }
}
