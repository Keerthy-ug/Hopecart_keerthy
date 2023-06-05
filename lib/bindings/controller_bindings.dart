import 'package:admin/controller/donation_controller.dart';
import 'package:admin/controller/login_controller.dart';
import 'package:admin/controller/request_controller.dart';
import 'package:admin/controller/signup_controller.dart';
import 'package:admin/controller/stock_controller.dart';
import 'package:admin/models/stock_model.dart';
import 'package:admin/models/user_model.dart';
import 'package:get/get.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => DonationController(), fenix: true);
    Get.lazyPut(() => RequestController(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => stockController(), fenix: true);
    Get.lazyPut(() => stockRepository(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
  }
}
