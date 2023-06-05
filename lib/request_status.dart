import 'package:admin/controller/request_controller.dart';
import 'package:admin/models/request_model.dart';
import 'package:admin/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class request_status extends StatefulWidget {
  const request_status({super.key});

  @override
  State<request_status> createState() => _request_statusState();
}

class _request_statusState extends State<request_status> {
  timeToString(Timestamp? t) {
    DateTime d = t!.toDate();
    return d.toString();
  }

  final controller = Get.find<RequestController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        FutureBuilder<List<request_model>>(
          future: controller.getRequestData(),
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
                        statusType: 'request',
                        item: snapshot.data![index].item.toString(),
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
      ]),
    );
  }
}
