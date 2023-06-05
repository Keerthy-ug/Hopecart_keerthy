import 'package:admin/controller/donation_controller.dart';
import 'package:admin/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/donation_model.dart';

class user_donation_status extends StatefulWidget {
  final email;
  const user_donation_status({super.key, required this.email});

  @override
  State<user_donation_status> createState() =>
      user__donation_statusState(email: email);
}

class user__donation_statusState extends State<user_donation_status> {
  timeToString(Timestamp? t) {
    DateTime d = t!.toDate();
    return d.toString();
  }

  final String email;
  user__donation_statusState({required this.email});
  final controller = Get.find<DonationController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<donation_model>>(
        future: controller.getUserDonationData(email: email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return status(
                          id: snapshot.data![index].id.toString(),
                          date: timeToString(snapshot.data![index].timestamp),
                          isApprove: snapshot.data![index].approve,
                          type: snapshot.data![index].type.toString(),
                          quantity: snapshot.data![index].quantity.toString(),
                          item: snapshot.data![index].item.toString(),
                          statusType: 'donation',
                        );
                      }),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Text('Something went wrong.');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
