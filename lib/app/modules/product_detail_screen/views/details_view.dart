import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getx_with_archit/app/modules/product_detail_screen/controllers/details_controller.dart';

class ProductDetailsView extends GetView<DetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Detail')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              controller.product.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              controller.product.price.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              controller.product.description,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 26,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Spacer(),
            ElevatedButton(
              onPressed: controller.goBack,
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
