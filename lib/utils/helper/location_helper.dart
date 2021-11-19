// import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart' as geo;
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loca;

// class LocationHelper {
//   loca.Location location = new loca.Location();
//   double? lat;
//   double? long;
//   String? error;
//   loca.LocationData? _locationData;

//   Future<void> getUserLocation() async {
//     try {
//       _locationData = await location.getLocation();
//       lat = _locationData?.latitude;
//       long = _locationData?.longitude;
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         // Fluttertoast.showToast(
//         //     msg: 'Please allow location permission',
//         //     backgroundColor: Colors.red[900],
//         //     textColor: Colors.white);
//         error = 'please grant permission';
//         print(error);
//       }
//       if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
//         // Fluttertoast.showToast(
//         //     msg: 'Please allow location permission',
//         //     backgroundColor: Colors.red[900],
//         //     textColor: Colors.white);
//         error = 'permission denied- please enable it from app settings';
//         print(error);
//       }
//       _locationData = null;
//     }

//     return;
//   }

//   //List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(52.2165157, 6.9437819);
//   Future<Map<String, dynamic>> addressFromLatLng(LatLng latLng) async {
//     var addresses =
//         await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

//     var data = {
//       'address': addresses,
//     };
//     return data;
//   }

//   Future<Map<String, dynamic>> addressFromUserLocation() async {
//     if (_locationData == null) {
//       await getUserLocation();
//     }
//     var addresses = await geo.placemarkFromCoordinates(lat!, long!);
//     var data = {
//       'locality': addresses.first.locality,
//       'country': addresses.first.country,
//       'address': addresses.first.administrativeArea,
//       'pincode': addresses.first.postalCode,
//       'lat': lat,
//       'long': long
//     };
//     return data;
//   }

//   // Future<List<Address>> searchFromQuery(String query) async {
//   //   var addresses = await Geocoder.local.findAddressesFromQuery(query);
//   //   return addresses;
//   // }

//   // static String getDirectionUrl(LatLng latLng) {
//   //   MainController ct = Get.find();
//   //   var baseUrl = 'https://www.google.com/maps/dir/?api=1&';
//   //   var para =
//   //       'origin=${ct.userLocation.latitude},${ct.userLocation.longitude}&destination=${latLng.latitude},${latLng.longitude}';
//   //   return baseUrl + para;
//   // }
// }
