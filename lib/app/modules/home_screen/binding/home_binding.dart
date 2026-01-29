import 'package:get/get.dart';
import 'package:getx_with_archit/app/modules/home_screen/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
