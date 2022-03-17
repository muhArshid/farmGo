import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/auth/sign_up_screen.dart';
import 'package:farmapp/views/splash_screen.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _uidFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool rememberMe = false;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.4,
//color: AppColorCode.brandColor,
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
                  buildtextFormLogin(
                    label: 'Email'.tr,
                    controller: userController.email,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter_Email_ID'.tr;
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                        return 'Enter a Valid Email';
                      }
                      return null;
                    },
                    coutomIcon: Icon(
                      Icons.email_outlined,
                      color: AppColorCode.brandColor,
                    ),
                  ),
                  SizedBox(height: 25),
                  buildtextFormLogin(
                    controller: userController.password,
                    label: 'Password'.tr,
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
                    coutomIcon: Icon(
                      Icons.lock_outlined,
                      color: AppColorCode.brandColor,
                    ),
                    obscureText: passwordVisible ? false : true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter_Password'.tr;
                      }

                      return null;
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     CustomCeckBox(
                  //       (bool val) {
                  //         rememberMe = val;
                  //       },
                  //       'Remember Me'.tr,
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         // Get.to(() => ForgotPassword());
                  //       },
                  //       child: Text(
                  //         'Forgot Password'.tr,
                  //         style: AppFontMain(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: isLoading
                  ? loadingButton(
                      label: ' '.tr,
                      height: size.height * 0.07,
                      width: size.width,
                      onTap: () {},
                    )
                  : button(
                      label: 'Log_In'.tr,
                      height: size.height * 0.07,
                      width: size.width,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          var flag = await userController.signIn();
                          if (!flag) {
                            Fluttertoast.showToast(
                                msg: 'please_check_credentials'.tr,
                                backgroundColor: AppColorCode.brandColor);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                    )),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: button(
              labelColor: AppColorCode.brandColor,
              buttonColor: AppColorCode.pureWhite,
              label: 'Sing_UP'.tr,
              height: size.height * 0.07,
              width: size.width,
              onTap: () {
                Get.to(() => SplashScreen());
              },
            ),
          ),
        ],
      )),
    );
  }
}
