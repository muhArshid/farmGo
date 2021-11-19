// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:service_partner/utils/AppColorCode.dart';
// import 'package:service_partner/utils/AppFontOswald.dart';
// import 'package:service_partner/utils/AssetConstants.dart';
// import 'package:service_partner/views/auth/login_screen.dart';
// import 'package:service_partner/views/auth/sign_up_screen.dart';
// import 'package:service_partner/views/widgets/button_icons_widgets.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({Key? key}) : super(key: key);

//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool otpMode = false;
//   String? otp;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//           body: ListView(
//         children: [
//           Container(
//             width: size.width,
//             height: size.height * 0.4,
//             color: AppColorCode.brandColor,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(AssetConstant.logo),
//                 SizedBox(height: 14),
//                 Text(
//                   AssetConstant.appName,
//                   style: AppFontMain(
//                     color: AppColorCode.pureWhite,
//                     fontSize: 31,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 50),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: !otpMode
//                 ? Column(
//                     children: [
//                       Text(
//                         'Welcome!',
//                         style: AppFontMain(
//                           color: AppColorCode.brandColor,
//                           fontSize: 31,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'Sign In or Create Account to quickly manage orders.',
//                         style: AppFontMain(
//                           color: AppColorCode.grey2,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Form(
//                         key: _formKey,
//                         child: buildtextForm(
//                             label: 'Mobile Number',
//                             keyboardType: TextInputType.number,
//                             validator: (val) {
//                               if (val!.length != 10)
//                                 return 'Number Should be 10 digit';
//                             }),
//                       ),
//                     ],
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 30),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Text(
//                           'Enter the verification code',
//                           textAlign: TextAlign.center,
//                           style: AppFontMain(
//                             color: AppColorCode.primaryText,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: PinCodeTextField(
//                           keyboardType: TextInputType.number,
//                           onChanged: (gg) {
//                             print(gg);
//                           },
//                           appContext: context,
//                           length: 4,
//                           obscureText: false,
//                           animationType: AnimationType.fade,
//                           pinTheme: PinTheme(
//                               selectedColor: Colors.black,
//                               activeColor: Colors.black,
//                               shape: PinCodeFieldShape.box,
//                               borderRadius: BorderRadius.circular(5),
//                               fieldHeight: 52,
//                               fieldWidth: 62,
//                               borderWidth: 0,
//                               activeFillColor: Colors.white,
//                               selectedFillColor: Colors.white,
//                               inactiveFillColor: Colors.white,
//                               inactiveColor: Colors.grey),
//                           animationDuration: Duration(milliseconds: 300),
//                           enableActiveFill: true,
//                           onCompleted: (v) {
//                             otp = v;

//                             ///  next what
//                           },
//                           backgroundColor: Colors.transparent,
//                           beforeTextPaste: (text) {
//                             print("Allowing to paste $text");
//                             //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                             //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                             return true;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//           SizedBox(height: 30),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: button(
//               label: !otpMode ? 'Next' : 'Verify Now',
//               height: size.height * 0.07,
//               width: size.width,
//               onTap: () {
//                 if (!otpMode) {
//                   if (_formKey.currentState!.validate()) {
//                     setState(() {
//                       otpMode = true;
//                     });
//                   }
//                 } else {
//                   Get.to(() => SignUpScreen());
//                 }
//               },
//             ),
//           ),
//           SizedBox(height: 20),
//           InkWell(
//             onTap: () {
//               Get.to(() => LoginScreen());
//             },
//             child: Text(
//               'Signin with Password',
//               textAlign: TextAlign.center,
//               style: AppFontMain(
//                 color: AppColorCode.brandColor,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
