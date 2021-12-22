import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/model/core/product.dart';
import 'package:farmapp/views/screens/product/home/widgets/single_product.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .63,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 10,
        children: producsController.products.map((ProductModel product) {
          return SingleProductWidget(
            product: product,
          );
        }).toList()));
  }
}
