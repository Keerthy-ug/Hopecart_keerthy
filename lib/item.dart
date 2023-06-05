import 'package:admin/controller/login_controller.dart';
import 'package:admin/controller/stock_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class item extends StatelessWidget {
  final stockRepo = Get.find<stockController>();
  final String itemName;
  final num? quantity;
  final String id;
  final controller = Get.find<LoginController>();
  item(
      {super.key,
      required this.id,
      required this.itemName,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(itemName),
      subtitle: Text("Stock: " + quantity.toString()),
      trailing: Row(
        children: [
          IconButton(
              onPressed: () {
                stockRepo.updateStock(quatity: 1, item: itemName);
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                stockRepo.decreaseStock(quatity: 1, item: itemName);
              },
              icon: Icon(Icons.remove))
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
