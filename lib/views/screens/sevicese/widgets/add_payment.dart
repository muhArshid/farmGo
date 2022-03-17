import 'dart:io';
import 'package:farmapp/model/core/category_item.dart';
import 'package:get/get.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddPayment extends StatefulWidget {
  final String? textName;
  final String? passName;
  final MainCategoryItemModel? modal;
  const AddPayment({Key? key, this.textName, this.passName, this.modal})
      : super(key: key);
  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  bool isLoading = true;
  String? fileName;
  File? imageFile;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: CustomText(
                  text: "Add".tr,
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              buildtextForm(
                keyboardType: TextInputType.number,
                controller: serviceController.amount,
                label: widget.textName.toString(),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter_amount'.tr;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              buildtextForm(
                keyboardType: TextInputType.text,
                controller: serviceController.amountCondent,
                label: 'Description'.tr,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter_Description'.tr;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              button(
                label: 'SUBMIT'.tr,
                height: 30,
                width: 20,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    serviceController.updateToCategory(
                        widget.modal!, widget.passName!);
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
