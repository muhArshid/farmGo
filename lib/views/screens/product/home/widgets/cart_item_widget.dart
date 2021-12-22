import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/model/core/cart_item.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemWidget({required Key key, required this.cartItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            cartItem.image.toString(),
            width: 80,
          ),
        ),
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                padding: EdgeInsets.only(left: 14),
                child: CustomText(
                  text: cartItem.name,
                  key: UniqueKey(),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: AppColorCode.brandColor,
                    ),
                    onPressed: () {
                      cartController.decreaseQuantity(cartItem);
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: cartItem.quantity.toString(),
                    key: UniqueKey(),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.chevron_right,
                        color: AppColorCode.brandColor),
                    onPressed: () {
                      cartController.increaseQuantity(cartItem);
                    }),
              ],
            )
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CustomText(
              text: "\$${cartItem.cost}",
              size: 10,
              weight: FontWeight.bold,
              key: UniqueKey()),
        ),
      ],
    );
  }
}
