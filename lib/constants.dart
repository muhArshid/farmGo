import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/controller/firebaseController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFDEE4EF);
const bgColor = Color(0xFFDEE4EF);

const defaultPadding = 16.0;
//AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
GoogleSignIn googleSign = GoogleSignIn();
