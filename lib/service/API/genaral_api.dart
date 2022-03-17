// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:farmapp/constants/firebase.dart';

// class FirebaseApi {
//   // static Future uploadUsers() async {
//   //   final currentUsers = await getUsers(1);

//   //   if (currentUsers.docs.isEmpty) {
//   //     final refUsers = FirebaseFirestore.instance.collection('users');

//   //     for (final user in List.of(users)) {
//   //       await refUsers.add(user);
//   //     }
//   //   }
//   // }
//   static Future<QuerySnapshot> getUsers(
//     int limit, {
//     DocumentSnapshot? startAfter,
//   }) async {
//     final refUsers = firebaseFirestore
//         .collection('posts')
//         .orderBy('uploadDate')
//         .limit(limit);

//     if (startAfter == null) {
//       return refUsers.get();
//     } else {
//       return refUsers.startAfterDocument(startAfter).get();
//     }
//   }
// }
