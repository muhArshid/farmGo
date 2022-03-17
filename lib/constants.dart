import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFDEE4EF);
const bgColor = Color(0xFFDEE4EF);

const defaultPadding = 16.0;
//AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
