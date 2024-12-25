import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Apis {
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance;

  User get currentUser => firebaseAuth.currentUser!;

  double deviceWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  double deviceHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
