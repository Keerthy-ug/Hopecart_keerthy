import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class donation_model {
  final String? id;
  final String? email;
  final String? type;
  final String? item;
  final num? quantity;
  final Timestamp? timestamp;
  final bool? approve;

  const donation_model(
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

  factory donation_model.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return donation_model(
        id: document.id,
        email: data['email'],
        type: data['type'],
        item: data['item'],
        quantity: data['quantity'],
        timestamp: data['timestamp'],
        approve: data['approve']);
  }
}

class donationRepository extends GetxController {
  static donationRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createDonations(donation_model donations) async {
    await _db
        .collection('donations')
        .add(donations.toJson())
        .whenComplete(() => Get.snackbar(
            'Success', 'Thank you for your donations.',
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

  Future<List<donation_model>> getDonationDetails() async {
    final snapshot = await _db.collection('donations').get();
    final donationData =
        snapshot.docs.map((e) => donation_model.fromSnapShot(e)).toList();
    return donationData;
  }

  approve(String id) {
    _db.collection("donations").doc(id).update({'approve': true});
  }

  disapprove(String id) {
    _db.collection("donations").doc(id).update({'approve': false});
  }

  donationCount({required String email}) {
    final val =
        _db.collection("donations").where('email', isEqualTo: email).count();
    return val;
  }

  Future<List<donation_model>> getUserDonationDetails(
      {required String email}) async {
    final snapshot = await _db
        .collection('donations')
        .where('email', isEqualTo: email)
        .get();
    final donationData =
        snapshot.docs.map((e) => donation_model.fromSnapShot(e)).toList();
    return donationData;
  }
}
