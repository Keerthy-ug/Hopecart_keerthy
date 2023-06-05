import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class userModel {
  final String? id;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? password;

  const userModel(
      {this.id,
      required this.email,
      required this.fullname,
      required this.phone,
      required this.password});

  toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'password': password
    };
  }

  factory userModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return userModel(
        id: document.id,
        email: data['email'],
        fullname: data['fullname'],
        phone: data['phone'],
        password: data['password']);
  }
}

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createUser(userModel user) async {
    await _db
        .collection('orphanage')
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
            'Success', 'Your account has been created',
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

  Future<List<userModel>> getOrphanages() async {
    final snapshot = await _db.collection('orphanage').get();
    final userData =
        snapshot.docs.map((e) => userModel.fromSnapShot(e)).toList();
    return userData;
  }

  Future<List<userModel>> getDoners() async {
    final snapshot = await _db.collection('doner').get();
    final userData =
        snapshot.docs.map((e) => userModel.fromSnapShot(e)).toList();
    return userData;
  }

  deleteDoner(String id) {
    _db.collection('doner').doc(id).delete();
  }

  deleteOrphanage(String id) {
    _db.collection('orphanage').doc(id).delete();
  }
}
