import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Products {
  String productBrand;
  String productCategory;
  String productDescription;
  String productImageUrl;

  Products(this.productCategory, this.productDescription, this.productImageUrl,
      this.productBrand);

  String get brand => productBrand;

  set brand(String value) {
    productBrand = value;
  }

  String get category => productCategory;

  set category(String value) {
    productCategory = value;
  }

  String get description => productDescription;

  set description(String value) {
    productDescription = value;
  }

  String get imageUrl => productImageUrl;

  set imageUrl(String value) {
    productImageUrl = value;
  }

  Stream<QuerySnapshot> getProducts() {
    return FirebaseFirestore.instance.collection('Products').snapshots();
  }

  Stream<QuerySnapshot> getProductDetails(queryParam) {
    return FirebaseFirestore.instance
        .collection("Products")
        .where(FieldPath.documentId, isEqualTo: queryParam)
        .snapshots();
  }

  Stream<QuerySnapshot> getSearchProducts(String queryParam) {
    queryParam =
        queryParam.substring(0, 1).toUpperCase() + queryParam.substring(1);
    return FirebaseFirestore.instance
        .collection("Products")
        .where('Description', isGreaterThanOrEqualTo: queryParam)
        .where('Description', isLessThan: queryParam + 'z')
        .orderBy('Description')
        .snapshots();
  }

  Stream<QuerySnapshot> getProductDetailsViaBarcode(scanBarcode) {
    return FirebaseFirestore.instance
        .collection("Products")
        .where(FieldPath.documentId, isEqualTo: scanBarcode)
        .snapshots();
  }

  Map<String, dynamic> mapProductsDetails(
      AsyncSnapshot<dynamic> snapshot, int index) {
    final Map<String, dynamic> values = {
      "Barcode": snapshot.data!.docs[index].id,
      "Brand": snapshot.data!.docs[index]['Brand'],
      "Description": snapshot.data!.docs[index]['Description'],
      "URL": snapshot.data!.docs[index]['URL'],
      "Category": snapshot.data!.docs[index]['Category'],
    };
    return values;
  }
}
