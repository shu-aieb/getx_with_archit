import 'package:get/get.dart';
import 'package:getx_with_archit/app/modules/product_detail_screen/controllers/details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsController());
  }
}
