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

Future<int> getVehicleNo(String userID) async {
  int vehicleNo = 0;
  await _firestore.collection('Users').doc(userID).get().then((value) {
    vehicleNo = value['Cars'];
  });
  return vehicleNo;
}

int vehicleIndex = 0;
Future<String> getVehicleID(String userID) async {
  String vehicleID = '';
  int vNum = await getVehicleNo(userID);
  vehicleIndex = vNum - 1;
  try {
    await _firestore.collection('Users').doc(userID).get().then((value) {
      vehicleID = value['UserVehicles'][vehicleIndex]['VehicleID'].toString();
    });
    return vehicleID;
  } catch (e) {
    return 'Dummy';
  }
}

Future<List<dynamic>> getVehiclesList(String userID) async {
  List vehiclesList = [];

  try {
    await _firestore.collection('Users').doc(userID).get().then((value) {
      vehiclesList = value['UserVehicles'].toList();
    });
    return vehiclesList;
  } catch (e) {
    return [];
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
      'Cars': 0,
      'UserVehicles': [],
    });
  }
}
