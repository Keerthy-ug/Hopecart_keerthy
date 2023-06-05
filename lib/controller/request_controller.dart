import 'package:admin/controller/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/request_model.dart';

class RequestController extends GetxController {
  static RequestController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final item = TextEditingController();
  final quantity = TextEditingController();
  final donationRepo = Get.put(RequestRepository());
  final authRepo = Get.put(AuthenticationRepository());
  //Call this Function from Design & it will do the rest

  void insertRequests(request_model donations) {
    donationRepo.createRequests(donations);
  }

  Future<List<request_model>> getRequestData() async {
    return await donationRepo.getRequestDetails();
  }

  Future<List<request_model>> getUserRequestData(
      {required String email}) async {
    return await donationRepo.getUserRequestDetails(email: email);
  }

  approve(String id) {
    donationRepo.approve(id);
  }

  disapprove(String id) {
    donationRepo.disapprove(id);
  }

  requestCount({required String email}) {
    return donationRepo.requestCount(email: email);
  }
}
