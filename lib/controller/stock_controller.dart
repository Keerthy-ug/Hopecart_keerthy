import 'package:admin/models/stock_model.dart';
import 'package:get/get.dart';

class stockController extends GetxController {
  static stockController get instance => Get.find();

  final stockRepo = Get.find<stockRepository>();

  Future<List<stock_model>> getStockDetails(String type) async {
    return await stockRepo.getStockDetails(type: type);
  }

  updateStock({required num quatity, required String item}) {
    stockRepo.updateStock(item: item, quatity: quatity);
  }

  decreaseStock({required num quatity, required String item}) {
    stockRepo.decreaseStock(item: item, quatity: quatity);
  }
}
