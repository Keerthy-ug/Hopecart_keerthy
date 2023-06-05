import 'package:admin/controller/donation_controller.dart';
import 'package:admin/controller/request_controller.dart';
import 'package:admin/controller/stock_controller.dart';
import 'package:admin/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class status extends StatelessWidget {
  final reqRepo = Get.find<RequestController>();
  final donRepo = Get.find<DonationController>();
  final stockRepo = Get.find<stockController>();
  final String id;
  final String date;
  final bool? isApprove;
  final String type;
  final String statusType;
  final String quantity;
  final String item;
  status(
      {super.key,
      required this.id,
      required this.date,
      required this.isApprove,
      required this.type,
      required this.item,
      required this.statusType,
      required this.quantity});
  returnImage(String type) {
    if (type == 'Food') {
      return Image.asset("assets/icons/diet.png");
    }
    if (type == 'Cloth') {
      return Image.asset("assets/icons/clothes.png");
    }
    if (type == 'Stationery') {
      return Image.asset("assets/icons/stationery.png");
    }
    if (type == 'Medicine') {
      return Image.asset("assets/icons/medicine.png");
    }
  }

  approveCheck(bool? isApprove) {
    return isApprove == true ? const Text('Cancel') : const Text('Approve');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: returnImage(type),
      title: Text(item),
      subtitle: Text(date),
      trailing: TextButton(
        child: approveCheck(isApprove),
        onPressed: () {
          print(id);
          print(isApprove);
          if (isApprove == true) {
            if (statusType == 'request') {
              reqRepo.disapprove(id);
            }
            if (statusType == 'donation') {
              donRepo.disapprove(id);
            }
          } else {
            if (statusType == 'request') {
              reqRepo.approve(id);
              stockRepo.decreaseStock(quatity: int.parse(quantity), item: item);
            }
            if (statusType == 'donation') {
              donRepo.approve(id);
              stockRepo.updateStock(quatity: int.parse(quantity), item: item);
            }
          }
        },
      ),
    );
  }
}
