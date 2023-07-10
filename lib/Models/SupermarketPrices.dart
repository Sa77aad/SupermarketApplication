import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:signup_and_login/Models/ChecklistDetails.dart';

class SupermarketPrices {
  String SupermarketName;
  int SupermarketPrice;

  SupermarketPrices(this.SupermarketName, this.SupermarketPrice);

  String get getSupermarketName => SupermarketName;

  set setSupermarketName(String value) {
    SupermarketName = value;
  }

  int get getSupermarketPrice => SupermarketPrice;

  set setSupermarketPrice(int value) {
    SupermarketPrice = value;
  }

  Stream<QuerySnapshot> getSupermarketDetails(queryParam) {
    print(queryParam);
    return FirebaseFirestore.instance
        .collection("SupermarketPrices")
        .where(FieldPath.documentId, isEqualTo: queryParam)
        .snapshots();
  }

  Map<String, dynamic> mapSupermarketDetails(
      AsyncSnapshot<dynamic> snapshot, int index) {
    final Map<String, dynamic> values = {
      "Barcode": snapshot.data!.docs[index].id,
      "Intermart": snapshot.data!.docs[index]['Intermart'],
      "Jumbo": snapshot.data!.docs[index]['Jumbo'],
      "Winners": snapshot.data!.docs[index]['Winners'],
    };
    return values;
  }
}
