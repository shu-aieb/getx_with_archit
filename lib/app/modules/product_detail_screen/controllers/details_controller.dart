import 'package:get/get.dart';
import 'package:getx_with_archit/app/data/models/product_model.dart';

class DetailsController extends GetxController {
  late Product product;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Product;
  }

  void goBack() {
    Get.back();
  }
}
