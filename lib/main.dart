import 'package:farmapp/controller/appController.dart';
import 'package:farmapp/controller/auth_controller.dart';
import 'package:farmapp/controller/cart_controller.dart';
import 'package:farmapp/controller/firebaseController.dart';
import 'package:farmapp/controller/product_controller.dart';
import 'package:farmapp/controller/profile_controller.dart';
import 'package:farmapp/controller/service_condroler.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/views/screens/auth/login_screen.dart';
import 'package:farmapp/views/screens/auth/sign_up_screen.dart';
import 'package:farmapp/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:farmapp/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) {
    Get.put(AppController());
    Get.put(UserController());
    Get.put(ProducsController());
    Get.put(CartController());
    Get.put(ServiceContoller());
    Get.put(ProfileContoller());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My app',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: SplashScreen(),
      );
    });
  }
}
