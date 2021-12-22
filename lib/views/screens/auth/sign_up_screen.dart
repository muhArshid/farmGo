import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/constants.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/auth/login_screen.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
import 'package:farmapp/views/screens/home/user.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordCheck = TextEditingController();

  final fireBase = FirebaseFirestore.instance;
  bool passwordVisible = false;
  bool verifyPasswordVisible = false;
  // create() async {
  //   try {
  //     await fireBase.collection("Users").doc().set(
  //         {"name": name.text, "email": email.text, "password": password.text});
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.4,
            color: AppColorCode.brandColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetConstant.logo),
                SizedBox(height: 14),
                Text(
                  AssetConstant.appName,
                  style: AppFontMain(
                    color: AppColorCode.pureWhite,
                    fontSize: 31,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // buildtextForm(
                  //   label: 'Name',
                  //   controller: name,
                  //   validator: (val) {
                  //     if (val!.isEmpty) return 'Required';
                  //   },
                  // ),
                  buildtextForm(
                    label: 'Email',
                    controller: userController.email,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter Email ID';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                        return 'Enter a Valid Email';
                      }
                      return null;
                    },
                  ),
                  buildtextForm(
                    controller: userController.password,
                    label: 'Password',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      child: passwordVisible
                          ? Icon(
                              Icons.visibility_off,
                              color: AppColorCode.grayMix,
                            )
                          : Icon(
                              Icons.visibility,
                              color: AppColorCode.grayMix,
                            ),
                    ),
                    obscureText: passwordVisible ? false : true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }

                      return null;
                    },
                  ),
                  // buildtextForm(
                  //   controller: userController.password,
                  //   label: 'Verify Password',
                  //   suffixIcon: InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         verifyPasswordVisible = !verifyPasswordVisible;
                  //       });
                  //     },
                  //     child: verifyPasswordVisible
                  //         ? Icon(
                  //             Icons.visibility_off,
                  //             color: AppColorCode.grayMix,
                  //           )
                  //         : Icon(
                  //             Icons.visibility,
                  //             color: AppColorCode.grayMix,
                  //           ),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) return 'Confirm your Password';
                  //     // if (value != newPasswordCt.text)
                  //     //   return 'Password must be same as above';
                  //     // return null;
                  //   },
                  //   obscureText: verifyPasswordVisible ? false : true,
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: button(
              label: 'Next',
              height: size.height * 0.07,
              width: size.width,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // create();
                  if (_formKey.currentState!.validate()) {
                    userController.signUp();
                  }
                }
              },
            ),
          ),
          SizedBox(height: 30),
          InkWell(
              onTap: () {
                Get.to(LoginScreen());
              },
              child: Center(
                  child: Text(
                'Login',
                style: AppFontMain(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              )))
        ],
      )),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
