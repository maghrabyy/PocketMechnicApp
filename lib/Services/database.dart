import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uId;
  DatabaseService({required this.uId});

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future registerationData(
      String fullName, String email, String phoneNumber) async {
    final firebaseUser = _auth.currentUser;
    var rng = Random();
    var randNum = rng.nextInt(900000) + 100000;
    String userID = 'U$randNum';
    DocumentReference userCollection = _firestore.collection('Users').doc(uId);
    await firebaseUser?.updateDisplayName(fullName);
    return await userCollection.set({
      'UserID': userID,
      'FullName': fullName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Cars': 0,
      'UserVehicles': [],
    });
  }
}
