import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastmeds/Constants/Constants.dart';
import 'package:fastmeds/Screens/Drawer.dart';
import 'package:fastmeds/Widgets/Loading.dart';
import 'package:fastmeds/models/ShopInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/doctor_card.dart';
import 'components/search_bar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference shops = FirebaseFirestore.instance.collection('Shops');
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  late List<ShopDetails> shopList = [];
  bool loading = true;
  List colors = [kBlueColor, kYellowColor, kOrangeColor];
  Random random = new Random();

  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      await shops.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          ShopDetails tempShop = ShopDetails.fromMap(doc);
          shopList.add(tempShop);
        });
      });
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: primaryColor),
          elevation: 0,
          backgroundColor: kBackgroundColor,
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 30, 10),
              child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(_auth.currentUser!.photoURL ??
                      "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png")),
            ),
          ],
        ),
        drawer: MyDrawer(),
        backgroundColor: kBackgroundColor,
        body: mainPage());
  }

  mainPage() {
    return SafeArea(
      key: _drawerKey,
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, ${_auth.currentUser!.displayName!.split(" ")[0]}",
                    style: TextStyle(
                      fontSize: 18,
                      color: kTitleTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  box10,
                  Text(
                    'Find your\nmedical solution!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: kTitleTextColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SearchBar(),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Nearby Pharmacy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kTitleTextColor,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            loading ? Loading() : buildNearbyPharmacy(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'All Pharmacy in Your Area',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kTitleTextColor,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            loading ? Loading() : buildAllPharmacy(),
          ],
        ),
      ),
    );
  }

  buildNearbyPharmacy() {
    return Container(
      constraints: new BoxConstraints(maxHeight: 150, minHeight: 50),
      child: ListView.builder(
          padding: EdgeInsets.only(left: 30),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: shopList.length,
          itemBuilder: (BuildContext context, int i) => Container(
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: 150,
                  width: 110,
                  decoration: BoxDecoration(
                    color: colors[random.nextInt(3)].withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Image.asset("assets/pharmacy.png")),
                      box5,
                      Text(
                        shopList[i].shopName,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )),
    );
  }

  buildAllPharmacy() {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: shopList.length,
            itemBuilder: (BuildContext context, int i) => Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: DoctorCard(
                      shopList[i].shopName,
                      shopList[i].address,
                      'assets/pharmacy2.png',
                      colors[random.nextInt(3)],
                    ),
                  ),
                )));
  }
}
