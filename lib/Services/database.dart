import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

Future<DocumentSnapshot<Map<String, dynamic>>?> getUserData(
    String userID) async {
  DocumentSnapshot<Map<String, dynamic>>? userData;

  await _firestore
      .collection('Users')
      .doc(_auth.currentUser!.uid)
      .get()
      .then((value) {
    userData = value;
  });
  return userData;
}

Future<String> getUserID(String userID) async {
  String userID = '';
  await _firestore
      .collection('Users')
      .doc(_auth.currentUser!.uid)
      .get()
      .then((value) {
    userID = value['UserID'].toString();
  });
  return userID;
}

Future<int> getVehicleNo(String userID) async {
  int vehicleNo = 0;
  await _firestore
      .collection('Users')
      .doc(_auth.currentUser!.uid)
      .get()
      .then((value) {
    vehicleNo = value['Cars'];
  });
  return vehicleNo;
}

int vehicleIndex = 0;
Future<String> getVehicleID(String userID) async {
  String vehicleID = '';
  int vNum = await getVehicleNo(_auth.currentUser!.uid);
  vehicleIndex = vNum - 1;
  try {
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      vehicleID = value['UserVehicles'][vehicleIndex]['VehicleID'].toString();
    });
    return vehicleID;
  } catch (e) {
    return 'Dummy';
  }
}

Future<List<dynamic>> getVehiclesList(String userID) async {
  List vehiclesList = [];
  int vNum = await getVehicleNo(_auth.currentUser!.uid);
  vehicleIndex = vNum - 1;
  try {
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
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
