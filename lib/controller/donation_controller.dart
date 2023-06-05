import 'package:admin/controller/authentication_repository.dart';
import 'package:admin/models/donation_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DonationController extends GetxController {
  static DonationController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final item = TextEditingController();
  final quantity = TextEditingController();
  final donationRepo = Get.put(donationRepository());
  final authRepo = Get.put(AuthenticationRepository());
  //Call this Function from Design & it will do the rest

  void insertDonation(donation_model donations) {
    donationRepo.createDonations(donations);
  }

  Future<List<donation_model>> getDonationData() async {
    return await donationRepo.getDonationDetails();
  }

  Future<List<donation_model>> getUserDonationData(
      {required String email}) async {
    return await donationRepo.getUserDonationDetails(email: email);
  }

  approve(String id) {
    donationRepo.approve(id);
  }

  disapprove(String id) {
    donationRepo.disapprove(id);
  }

  donationCount({required String email}) {
    return donationRepo.donationCount(email: email);
  }
}
