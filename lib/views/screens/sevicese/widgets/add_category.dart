import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddMainCategorys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                text: "Add Farm ",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            buildtextForm(
              controller: serviceController.categorName,
              label: 'category',
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter category';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            button(
              label: 'SUBMIT ',
              height: 30,
              width: 20,
              onTap: () {
                serviceController
                    .addToCategory(serviceController.categorName.text);
                // if (_formKey.currentState!.validate()) {
                //   authController.login(emailController.text.trim(),
                //       passwordController.text.trim());
                //   // Get.offAll(() => MainHomeHolder());
                // }git
              },
            )
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
