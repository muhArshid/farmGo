import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/service/API/genaral_api.dart';
import 'package:get/get.dart';

class ExpolreContoller extends GetxController {
  final _usersSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  int documentLimit = 15;
  bool _hasNext = true;
  bool _isFetchingUsers = false;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  // Future fetchNextUsers() async {
  //   if (_isFetchingUsers) return;

  //   _errorMessage = '';
  //   _isFetchingUsers = true;

  //   try {
  //     final snap = await FirebaseApi.getUsers(
  //       documentLimit,
  //       startAfter: _usersSnapshot.isNotEmpty ? _usersSnapshot.last : null,
  //     );
  //     _usersSnapshot.addAll(snap.docs);

  //     if (snap.docs.length < documentLimit) _hasNext = false;
  //     update();
  //   } catch (error) {
  //     _errorMessage = error.toString();
  //     update();
  //   }

  //   _isFetchingUsers = false;
  // }
}
