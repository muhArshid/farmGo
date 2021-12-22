import 'package:farmapp/constants.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/auth/sign_up_screen.dart';
import 'package:farmapp/views/screens/home/main_home_holder.dart';
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
                    coutomIcon: Icon(
                      Icons.email_outlined,
                      color: AppColorCode.brandColor,
                    ),
                  ),
                  SizedBox(height: 25),
                  buildtextFormLogin(
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
                    coutomIcon: Icon(
                      Icons.lock_outlined,
                      color: AppColorCode.brandColor,
                    ),
                    obscureText: passwordVisible ? false : true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
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
                  //       'Remember Me',
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         // Get.to(() => ForgotPassword());
                  //       },
                  //       child: Text(
                  //         'Forgot Password',
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: button(
              label: 'Log In',
              height: size.height * 0.07,
              width: size.width,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  userController.signIn();
                  // authController
                  //     .signIn(
                  //         emaildata: emailController.text,
                  //         passworddata: passwordController.text)
                  //     .then((result) {
                  //   if (result == null) {
                  //     Get.to(() => MainHomeHolder());
                  //   } else {
                  //     Fluttertoast.showToast(
                  //         msg: result,
                  //         backgroundColor: AppColorCode.brandColor);
                  //   }
                  // });
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: button(
              label: 'SingUP',
              height: size.height * 0.07,
              width: size.width,
              onTap: () {
                Get.to(() => SignUpScreen());
              },
            ),
          ),

          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.red,
          //   ),
          //   onPressed: () {
          //     authController.signInWithGoogle();
          //   },
          //   child: const Text("Sign In with Google"),
          // ),
          // SizedBox(height: 30),
        ],
      )),
    );
  }
}
