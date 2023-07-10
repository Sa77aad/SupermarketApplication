import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_and_login/Models/Products.dart';
import 'browse_products_search_results.dart';
import 'package:signup_and_login/reusable_widgets/reusable_widget.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  final Products _product = Products("", "", "", "");

  @override
  Widget build(BuildContext context) {
    final TextEditingController productController = TextEditingController();
    Color myColor2 = const Color(0xFF274F21);
    Color myColor = const Color(0xFFFFFFB8);
    //final CollectionReference collection = FirebaseFirestore.instance.collection('Products');
    return Scaffold(
        backgroundColor: myColor,
        appBar: AppBar(
          title: const Text('Browse Products'),
          backgroundColor: myColor2,
        ),
        body: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
                cursorColor: myColor2,
                controller: productController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF274F21), width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF274F21), width: 1.0),
                  ),
                  labelText: 'Search Products',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      String searchDetails = productController.text;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchResults(queryParam: searchDetails)));
                    },
                    child: const Icon(Icons.search, color: Color(0xFF274F21)),
                  ),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _product.getProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> values =
                          _product.mapProductsDetails(snapshot, index);
                      return listItem(context, values);
                    });
              },
            ),
          )
        ]));
  }
}
