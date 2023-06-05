import 'package:admin/controller/donation_controller.dart';
import 'package:admin/controller/request_controller.dart';
import 'package:admin/models/request_model.dart';
import 'package:admin/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/donation_model.dart';

class user_request_status extends StatefulWidget {
  final email;
  const user_request_status({super.key, required this.email});

  @override
  State<user_request_status> createState() =>
      user_request_statusState(email: email);
}

class user_request_statusState extends State<user_request_status> {
  timeToString(Timestamp? t) {
    DateTime d = t!.toDate();
    return d.toString();
  }

  final String email;
  user_request_statusState({required this.email});
  final controller = Get.find<RequestController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<request_model>>(
        future: controller.getUserRequestData(email: email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return status(
                      id: snapshot.data![index].id.toString(),
                      date: timeToString(snapshot.data![index].timestamp),
                      isApprove: snapshot.data![index].approve,
                      type: snapshot.data![index].type.toString(),
                      quantity: snapshot.data![index].quantity.toString(),
                      item: snapshot.data![index].item.toString(),
                      statusType: 'requests',
                    );
                  });
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
