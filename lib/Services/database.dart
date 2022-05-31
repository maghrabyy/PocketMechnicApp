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

Future<String> getUserID(String uID) async {
  String userID = '';
  await _firestore.collection('Users').doc(uID).get().then((value) {
    userID = value['UserID'];
  });
  return userID;
}

Future<String> getPartnerID(String pID) async {
  String partnerID = '';
  await _firestore.collection('Partners').doc(pID).get().then((value) {
    partnerID = value['partnerID'];
  });
  return partnerID;
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
    _firestore
        .collection('BugsReports')
        .doc(_auth.currentUser!.uid)
        .set({'Reports': []});
    _firestore
        .collection('sparePartFavourites')
        .doc(_auth.currentUser!.uid)
        .set({'userID': userID, 'favouriteProducts': []});
    _firestore
        .collection('shoppingCart')
        .doc(_auth.currentUser!.uid)
        .set({'userID': userID, 'Cart': []});
    _firestore
        .collection('Orders')
        .doc(_auth.currentUser!.uid)
        .set({'userID': userID, 'ordersList': []});
    _firestore
        .collection('servicesHistory')
        .doc(_auth.currentUser!.uid)
        .set({'userID': userID, 'services': []});
    return await userCollection.set({
      'UserID': userID,
      'FullName': fullName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Vehicle': {'VehicleID': '', 'VehicleName': ''},
      'userType': 'Customer',
      'address': '',
      'partnerID': '',
    });
  }
}
