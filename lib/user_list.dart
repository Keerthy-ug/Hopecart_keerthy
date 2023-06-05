import 'package:admin/controller/donation_controller.dart';
import 'package:admin/controller/login_controller.dart';
import 'package:admin/controller/request_controller.dart';
import 'package:admin/user_donations.dart';
import 'package:admin/user_requests.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class user_list extends StatelessWidget {
  final String email;
  final String phone;
  final String name;
  final String id;
  final String userType;
  final donRepo = Get.find<DonationController>();
  final reqRepo = Get.find<RequestController>();
  final controller = Get.find<LoginController>();
  user_list(
      {super.key,
      required this.id,
      required this.email,
      required this.phone,
      required this.name,
      required this.userType});

  approveCheck(bool? isApprove) {
    return isApprove == true
        ? const Icon(Icons.check)
        : const Icon(Icons.pending);
  }

  String count(String userType) {
    if (userType == 'doner') {
      return '\nTotal donation:' + donRepo.donationCount(email: email);
    }
    if (userType == 'orphanage') {
      return '\nTotal requests:' + reqRepo.requestCount(email: email);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(name),
      subtitle: Text("Email: " +
          email +
          "\n" +
          "Phone no: " +
          phone), //+ count(userType)),
      trailing: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              if (userType == 'doner') {
                controller.deleteDoner(id);
              }
              if (userType == 'orphanage') {
                controller.deleteOrphanage(id);
              }
            },
          ),
          IconButton(
              onPressed: () {
                if (userType == 'doner') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            user_donation_status(email: email)),
                  );
                }
                if (userType == 'orphanage') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            user_request_status(email: email)),
                  );
                }
              },
              icon: Icon(Icons.info))
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
