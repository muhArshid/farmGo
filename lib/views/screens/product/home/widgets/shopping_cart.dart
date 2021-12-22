import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/views/screens/product/home/widgets/cart_item_widget.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                text: "Shopping Cart",
                size: 24,
                weight: FontWeight.bold,
                key: UniqueKey(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: userController.userModel.value.cart!
                      .map((cartItem) => CartItemWidget(
                            cartItem: cartItem,
                            key: UniqueKey(),
                          ))
                      .toList(),
                )),
          ],
        ),
        // Positioned(
        //     bottom: 30,
        //     child: Container(
        //       width: MediaQuery.of(context).size.width,
        //       padding: EdgeInsets.all(8),
        //       child: Obx(() => CustomButton(
        //           text: "Pay (\$${cartController.totalCartPrice.value.toStringAsFixed(2)})", onTap: () {}),)
        //     ))
      ],
    );
  }
}
