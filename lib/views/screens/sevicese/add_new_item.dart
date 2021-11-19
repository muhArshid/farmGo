import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({Key? key}) : super(key: key);

  @override
  _AddNewScreenState createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  String dropdownvalue = 'Apple';
  var items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: appBar(
          label: '',
        ),
      ),
      Positioned(
        top: 60,
        left: 0,
        right: 10,
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Container(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColorCode.brandColor,
                          radius: 70,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(AssetConstant.profiledemy),
                            radius: 60,
                          ),
                        ),
                        // Positioned(
                        //     right: 10,
                        //     bottom: 0,
                        //     top: 0,
                        //     child: Container(
                        //       height: 25,
                        //       width: 26,
                        //       decoration: BoxDecoration(
                        //           color: AppColorCode.brandColor,
                        //           borderRadius: BorderRadius.circular(40)),
                        //       child: IconButton(
                        //         onPressed: () {},
                        //         icon: const Icon(
                        //           Icons.add,
                        //           size: 15,
                        //         ),
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 40.w,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildtextForm(
                          label: 'Name',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter Email ID';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildtextForm(
                          label: 'Id',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter Email ID';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: buildtextForm(
                            label: 'Dote Of Birth',
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter Email ID';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            buildtextForm(
              maxLines: 7,
              minLines: 7,
              label: 'Discription',
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter Email ID';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Category',
              style: AppFontMain(
                color: AppColorCode.headerColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              width: 85.w,
              child: DropdownButton(
                style: AppFontMain(
                  color: AppColorCode.ratingColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                value: dropdownvalue,
                icon: Container(
                  margin: EdgeInsets.only(top: 0.0, left: 178.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColorCode.ratingColor,
                  ),
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            button(
              label: 'SUBMIT',
              height: size.height * 0.07,
              width: size.width,
              onTap: () {
                // if (_formKey.currentState!.validate()) {
                //   authController.login(emailController.text.trim(),
                //       passwordController.text.trim());
                //   // Get.offAll(() => MainHomeHolder());
                // }
              },
            )
          ]),
        ),
      )
    ])));
  }
}
