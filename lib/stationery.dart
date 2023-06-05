import 'package:admin/controller/stock_controller.dart';
import 'package:admin/item.dart';
import 'package:admin/models/stock_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class stationery extends StatefulWidget {
  const stationery({super.key});

  @override
  State<stationery> createState() => _stationeryState();
}

class _stationeryState extends State<stationery> {
  final controller = Get.find<stockController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        FutureBuilder<List<stock_model>>(
          future: controller.getStockDetails('Stationary'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return item(
                        id: snapshot.data![index].id.toString(),
                        itemName: snapshot.data![index].item.toString(),
                        quantity: snapshot.data![index].quantity,
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
