import 'package:cloud_firestore/cloud_firestore.dart';

class ShopDetails {
  late String shopName;
  late String gstNo;
  late String address;
  late String state;
  late String city;
  late String phone;
  late String uid;

  ShopDetails.fromMap(QueryDocumentSnapshot<Object?> data) {
    // uid = data['uid'] ?? "";
    shopName = data['shopName'];
    gstNo = data['gstNo'];
    address = data['address'];
    state = data['state'];
    city = data['city'];
    phone = data['phone'];
  }
}
