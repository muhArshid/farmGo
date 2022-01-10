import 'dart:io';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/utils/helper/showLoading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:farmapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddPayment extends StatefulWidget {
  final String? textName;
  final MainCategoryItemModel? modal;
  const AddPayment({Key? key, this.textName, this.modal}) : super(key: key);
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
                  text: "Add ",
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
                    return 'Enter amount';
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
                  if (_formKey.currentState!.validate()) {
                    serviceController.updateToCategory(
                        widget.modal!, widget.textName!);
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
