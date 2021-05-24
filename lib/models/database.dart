import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection("userInfo");

  Future updateUserData(
      List meds, String shopName, String gstNo, String address) async {
    await userInfo.doc(uid).set({
      'shopName': shopName,
      'address': address,
      'availableMeds': meds,
      "gstNo": gstNo,
    });
  }
}
