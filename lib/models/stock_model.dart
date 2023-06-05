import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class stock_model {
  final String? id;
  final String? type;
  final String? item;
  final num? quantity;

  const stock_model({
    this.id,
    required this.type,
    required this.item,
    required this.quantity,
  });

  toJson() {
    return {
      'Type': type,
      'Item': item,
      'Quantity': quantity,
    };
  }

  factory stock_model.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return stock_model(
      id: document.id,
      type: data['Type'],
      item: data['Item'],
      quantity: data['Quantity'],
    );
  }
}

class stockRepository extends GetxController {
  static stockRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  updateStock({required num quatity, required String item}) async {
    await _db
        .collection('stock')
        .doc(item)
        .update({'Quantity': FieldValue.increment(quatity)});
  }

  decreaseStock({required num quatity, required String item}) async {
    await _db
        .collection('stock')
        .doc(item)
        .update({'Quantity': FieldValue.increment(-quatity)});
  }

  Future<List<stock_model>> getStockDetails({required String type}) async {
    final snapshot =
        await _db.collection('stock').where('Type', isEqualTo: type).get();
    final donationData =
        snapshot.docs.map((e) => stock_model.fromSnapShot(e)).toList();
    return donationData;
  }
}
