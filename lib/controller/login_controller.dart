import 'package:admin/controller/authentication_repository.dart';
import 'package:admin/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find<LoginController>();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final userRepo = Get.put(UserRepository());

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> loginUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  Future<List<userModel>> getOrphanges() async {
    return await userRepo.getOrphanages();
  }

  Future<List<userModel>> getDoners() async {
    return await userRepo.getDoners();
  }

  deleteDoner(String id) {
    userRepo.deleteDoner(id);
  }

  deleteOrphanage(String id) {
    userRepo.deleteOrphanage(id);
  }
}

class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure(
      [this.message = 'An unknown error occured']);

  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case '':
        return LogInWithEmailAndPasswordFailure('');
      default:
        return LogInWithEmailAndPasswordFailure();
    }
  }
}
