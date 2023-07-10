import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_and_login/Models/ChecklistDetails.dart';
import 'package:signup_and_login/Models/Products.dart';

class Checklist {
  List<ChecklistDetails> cChecklistDetails = [];
  bool cProcessed;
  String cUser;

  Checklist(this.cChecklistDetails, this.cProcessed, this.cUser);

  List<ChecklistDetails> get checklistDetails => cChecklistDetails;

  set checklistDetails(List<ChecklistDetails> value) {
    cChecklistDetails = value;
  }

  bool get processed => cProcessed;

  set processed(bool value) {
    cProcessed = value;
  }

  String get user => cUser;

  set user(String value) {
    cUser = value;
  }

  Future<QuerySnapshot> getChecklistDetails(user) async {
    return await FirebaseFirestore.instance
        .collection("Checklists")
        .where('User', isEqualTo: user)
        .where('Processed', isEqualTo: false)
        .get();
  }

  Stream<QuerySnapshot> getCheclists() {
    return FirebaseFirestore.instance.collection('Products').snapshots();
  }

  Future<Map<String, dynamic>> mapChecklistDetails(AsyncSnapshot<dynamic> snapshot, int index) async {
    Map<String, dynamic> values = {
      "id": snapshot.data!.docs[index].id,
      "ChecklistDetails": snapshot.data!.docs[index]['ChecklistDetails'],
      "Processed": snapshot.data!.docs[index]['Processed'],
      "User": snapshot.data!.docs[index]['User'],
    };

    var checklistDetails = values['ChecklistDetails'];
    checklistDetails = checklistDetails.split(";");
    Map<String, dynamic> myProductdetailsMap = {};
    for (int i = 0; i < checklistDetails.length; i++) {
      var itemList =
          checklistDetails[i].substring(1, checklistDetails[i].length - 1);

      itemList = itemList.split(',');

      Products myProduct = Products("", "", "", "");
      Stream<QuerySnapshot> myProductDetailsSnapshot =
          myProduct.getProductDetailsViaBarcode(itemList[0]);

      myProductDetailsSnapshot.forEach((element) {
        final Map<String, dynamic> values = {
          "Barcode": element.docs[0].id,
          "Brand": element.docs[0]['Brand'],
          "Description": element.docs[0]['Description'],
          "URL": element.docs[0]['URL'],
          "Category": element.docs[0]['Category'],
        };

        myProductdetailsMap.putIfAbsent(element.docs[0].id, () => values);
      });

      await Future.delayed(Duration(seconds: 3));
    }
    print("MyProductDetails");
    values.putIfAbsent("ProductDetails", () => myProductdetailsMap);
    // values.putIfAbsent(myProductdetailsMap);
    print(values);
    return values;
  }
}
