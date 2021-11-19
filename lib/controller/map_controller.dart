// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;
// import 'package:geocoding/geocoding.dart' as geo;

// class MapController extends GetxController {
//   MainController mainCtr = Get.put(MainController());
//   Set<Marker> _markers = {};
//   Set<Marker> get markers => _markers;
//   BitmapDescriptor? descriptor;

//   LatLng? _latLong;
//   LatLng? get latLong => _latLong;
//   // GetAddressResponse addressData = GetAddressResponse();

//   void setMarker(LatLng latLng) {
//     _markers.clear();
//     _markers.add(
//       Marker(
//           markerId: MarkerId(latLng.toString()),
//           position: latLng,
//           icon: descriptor!,
//           draggable: true,
//           onDragEnd: ((newPosition) {
//             _latLong = newPosition;
//             print(newPosition.latitude);
//             print(newPosition.longitude);
//           })),
//     );
//   }

//   iconMark() async {
//     descriptor = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, AssetConstant.mapMarker);
//   }

//   loc.Location location = new loc.Location();
//   loc.LocationData? _locationData;
//   loc.LocationData? get locationData => _locationData;

//   String? locality;
//   String? subAdministrativeArea;
//   getUserPlace() async {
//     _locationData = await location.getLocation();
//     _latLong = LatLng(_locationData!.latitude!, _locationData!.longitude!);
//     mainCtr.updateuserLocation(_latLong!);

//     placemarks = await geo.placemarkFromCoordinates(
//         _latLong!.latitude, _latLong!.longitude);
//     places = placemarks!.firstWhere((element) => element.name != null);
//     locality = places!.locality;
//     subAdministrativeArea = places!.subAdministrativeArea;
//     placeName = places!.name;
//   }

//   getUserLocation() async {
//     _locationData = await location.getLocation();
//     _latLong = LatLng(_locationData!.latitude!, _locationData!.longitude!);
//     getAddressFromLatLng(_latLong!);
//   }

//   updateLatLong(LatLng latLng) {
//     _latLong = latLng;
//     print(_latLong);
//   }

//   List<geo.Placemark>? placemarks;
//   geo.Placemark? places;
//   String? placeName;
//   getAddressFromLatLng(LatLng latLng) async {
//     placemarks =
//         await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

//     places = placemarks!.firstWhere((element) => element.name != null);
//     placeName = places!.locality!;

//     print(placeName);
//   }
// }
