import 'package:connectivity/connectivity.dart';
import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/app_controller.dart';
import 'package:farmapp/controller/auth_controller.dart';
import 'package:farmapp/controller/cart_controller.dart';
import 'package:farmapp/controller/explore_condroller.dart';
import 'package:farmapp/service/FireBase/notification_service.dart';
import 'package:farmapp/controller/product_controller.dart';
import 'package:farmapp/controller/profile_controller.dart';
import 'package:farmapp/controller/service_condroler.dart';
import 'package:farmapp/service/localization_service.dart';
import 'package:farmapp/views/splash_screen.dart';
import 'package:farmapp/views/widgets/red_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:farmapp/constants.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //
  final status = await Permission.camera.request();
  if (status == PermissionStatus.granted) {
    print('Permission granted');
  } else if (status == PermissionStatus.denied) {
    //await openAppSettings();
  } else if (status == PermissionStatus.permanentlyDenied) {
    print('Take the user to the settings page.');
  }
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
  ].request();
  print(statuses[Permission.camera]);

//  await NotificationService().requestIOSPermissions(); //

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDM3IPfwCjnwVvbQP8AYReuhdJcth_w7rk", // Your apiKey
      appId: "1:173393172254:android:699d3be79f1ea63ac99b0f", // Your appId
      messagingSenderId: "XXX", // Your messagingSenderId
      projectId: "gothic-list-230105", // Your projectId
    ),
  );
  // Future<void> backGroundHandler(RemoteMessage message) async {}
  // FirebaseMessaging.onBackgroundMessage(backGroundHandler);
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    Get.snackbar('Please connected', 'network');
  }

  await firebaseInitialization.then((value) {
    Get.put(AppController());
    Get.put(UserController());
    Get.put(ProducsController());
    Get.put(CartController());
    Get.put(ServiceContoller());
    Get.put(ProfileContoller());
    Get.put(ExpolreContoller());
  });
  appController.getLang();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: LocalizationService(),
        locale: LocalizationService.locale,
        title: 'My app',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
          //     .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        routes: {
          "red": (_) => DemoPage(),
        },
        home: SplashScreen(),
      );
    });
  }
}
