import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_and_login/Models/Checklist.dart';
import 'package:signup_and_login/reusable_widgets/reusable_widget.dart';
import 'package:signup_and_login/Models/Products.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final Checklist _checklist = Checklist([], false, "");

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
            Expanded(child: _checklistSearch("Jon Jones")),
          ],
        ));
  }

  Widget _checklistSearch(String queryParam) {
    return  FutureBuilder<QuerySnapshot>(
      future: _checklist.getChecklistDetails(queryParam),
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
                Map<String, dynamic> values = _checklist.mapChecklistDetails(
                    snapshot, index) as Map<String, dynamic>;

                return listChecklistItems(context, values);
              });
        }
      },
    );
  }
}
