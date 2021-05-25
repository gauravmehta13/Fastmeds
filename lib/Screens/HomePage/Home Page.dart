import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastmeds/Constants/Constants.dart';
import 'package:fastmeds/Screens/Drawer.dart';
import 'package:fastmeds/Widgets/Loading.dart';
import 'package:fastmeds/models/ShopInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                    "Hello ${_auth.currentUser!.displayName}",
                    style: TextStyle(
                      fontSize: 18,
                      color: kTitleTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  box10,
                  Text(
                    'Find Your Desired\nMeds',
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
            buildAllPharmacy(),
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
                  height: 150,
                  width: 110,
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset("assets/prescription.png"),
                        Text(shopList[i].shopName)
                      ],
                    ),
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
      child: Column(
        children: <Widget>[
          DoctorCard(
            'Dr. Stella Kane',
            'Heart Surgeon - Flower Hospitals',
            'assets/images/doctor1.png',
            kBlueColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            'Dr. Joseph Cart',
            'Dental Surgeon - Flower Hospitals',
            'assets/images/doctor2.png',
            kYellowColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            'Dr. Stephanie',
            'Eye Specialist - Flower Hospitals',
            'assets/images/doctor3.png',
            kOrangeColor,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
