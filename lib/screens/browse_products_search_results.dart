import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_and_login/Models/Products.dart';
import 'package:signup_and_login/reusable_widgets/reusable_widget.dart';

class SearchResults extends StatefulWidget {
  final String? queryParam;
  const SearchResults({Key? key, this.queryParam}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResults();
}

class _SearchResults extends State<SearchResults> {
  final Products _product = Products("", "", "", "");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Results'),
        ),
        body: _fireSearch(widget.queryParam as String));
  }

  Widget _fireSearch(String queryParam) {
    return StreamBuilder<QuerySnapshot>(
      stream: _product.getSearchProducts(queryParam),
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
                return listItem(context, values);
              });
        }
      },
    );
  }
}
