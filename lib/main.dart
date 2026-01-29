import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_with_archit/app/data/services/storage_services.dart';
import 'package:getx_with_archit/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await _initServices();
  runApp(MyApp());
}

Future<void> _initServices() async {
  await Get.putAsync<StorageServices>(() async => StorageServices());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Get X Demo',
      initialRoute: '/home',
      getPages: AppPages.routes,
    );
  }
}
