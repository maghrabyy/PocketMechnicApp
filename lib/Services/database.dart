import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

Future<DocumentSnapshot<Map<String, dynamic>>?> getUserData(
    String userID) async {
  DocumentSnapshot<Map<String, dynamic>>? userData;
  try {
    await _firestore.collection('Users').doc(userID).get().then((value) {
      userData = value;
    });
    return userData;
  } catch (e) {
    return null;
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>?> getVehicleData(
    String userID) async {
  DocumentSnapshot<Map<String, dynamic>>? userData;
  try {
    await _firestore.collection('VehicleData').doc(userID).get().then((value) {
      userData = value;
    });
    return userData;
  } catch (e) {
    return null;
  }
}

Future<String> getUserID(String userID) async {
  String vehicleNo = '';
  await _firestore.collection('Users').doc(userID).get().then((value) {
    vehicleNo = value['UserID'];
  });
  return vehicleNo;
}

Future<bool> checkIfDocExists(String collectionPath, String docId) async {
  try {
    var collectionRef = _firestore.collection(collectionPath);

    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    rethrow;
  }
}

class DatabaseService {
  final String? uId;
  DatabaseService({required this.uId});

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
      'Vehicle': {'VehicleID': '', 'VehicleName': ''}
    });
  }
}
