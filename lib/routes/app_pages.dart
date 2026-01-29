import 'package:get/get.dart';
import 'package:getx_with_archit/app/modules/home_screen/binding/home_binding.dart';
import 'package:getx_with_archit/app/modules/home_screen/views/home_view.dart';
import 'package:getx_with_archit/app/modules/product_detail_screen/bindings/details_binding.dart';
import 'package:getx_with_archit/app/modules/product_detail_screen/views/details_view.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/home', page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: '/product-details',
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
  ];
}
