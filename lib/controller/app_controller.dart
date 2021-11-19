
import 'package:get/get.dart';

class MainController extends GetxController {
  //MembershipPackageResponse membershipPackageResponse;
  late String fcmToken;

////////Connectivity
  //StreamSubscription<ConnectivityResult> connectivitySubscription;

  // setUpConnectivity() {
  //   connectivitySubscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.none) {
  //       EasyLoading.showInfo('No Internet');
  //     }
  //   });
  // }

  // disposeConnectivity() {
  //   connectivitySubscription.cancel();
  // }

//////////Notification
  // setNotificationToken() async {
  //   fcmToken = await FirebaseMessaging.instance.getToken();
  // }

  // configureNotification() async {
  //   await setNotificationToken();
  //   print(fcmToken);
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage message) {
  //     if (message != null) {
  //       print(message);
  //     }
  //   });
  // }

}
