import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/Models/orders_model.dart';

class OrderController extends ChangeNotifier {
  Future<void> writeOrderToFirestore(MyOrder order) async {
    final colletionRef = FirebaseFirestore.instance.collection('orders');

    final docUser =
        colletionRef.doc(FirebaseAuth.instance.currentUser!.email.toString());

    final json = order.toJson();

    await docUser.set(json);

    notifyListeners();
  }

  Future<MyOrder?> readDataToFirebase(String docID) async {
    final ref = FirebaseFirestore.instance.collection('orders');
    final docUser = ref.doc(docID);

    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return MyOrder.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }
}
