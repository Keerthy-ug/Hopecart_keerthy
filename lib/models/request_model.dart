import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class request_model {
  final String? id;
  final String? email;
  final String? type;
  final String? item;
  final num? quantity;
  final Timestamp? timestamp;
  final bool? approve;

  const request_model(
      {this.id,
      required this.email,
      required this.type,
      required this.item,
      required this.quantity,
      required this.timestamp,
      this.approve});

  toJson() {
    return {
      'email': email,
      'type': type,
      'item': item,
      'quantity': quantity,
      'timestamp': timestamp,
      'approve': false
    };
  }

  factory request_model.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return request_model(
        id: document.id,
        email: data['email'],
        type: data['type'],
        item: data['item'],
        quantity: data['quantity'],
        timestamp: data['timestamp'],
        approve: data['approve']);
  }
}

class RequestRepository extends GetxController {
  static RequestRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createRequests(request_model donations) async {
    await _db
        .collection('requests')
        .add(donations.toJson())
        .whenComplete(() => Get.snackbar('Success', 'Thank you.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((Error, StackTrace) {
      Get.snackbar('Error', 'Something went wrong. Try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(Error.toString());
    });
  }

  Future<List<request_model>> getRequestDetails() async {
    final snapshot = await _db.collection('requests').get();
    final donationData =
        snapshot.docs.map((e) => request_model.fromSnapShot(e)).toList();
    return donationData;
  }

  approve(String id) {
    _db.collection("requests").doc(id).update({'approve': true});
  }

  disapprove(String id) {
    _db.collection("requests").doc(id).update({'approve': false});
  }

  requestCount({required String email}) {
    return _db
        .collection("requests")
        .where('email', isEqualTo: email)
        .count()
        .toString();
  }

  Future<List<request_model>> getUserRequestDetails(
      {required String email}) async {
    final snapshot =
        await _db.collection('requests').where('email', isEqualTo: email).get();
    final donationData =
        snapshot.docs.map((e) => request_model.fromSnapShot(e)).toList();
    return donationData;
  }
}
