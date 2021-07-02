import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastmeds/Constants/Constants.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:fastmeds/Widgets/Loading.dart';
import 'package:fastmeds/models/PharmacyInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/doctor_card.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Pharmacy extends StatefulWidget {
  @override
  _PharmacyState createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  CollectionReference pharmacy =
      FirebaseFirestore.instance.collection('Pharmacy');
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  late List<PharmacyDetails> shopList = [];
  bool loading = true;
  List colors = [kBlueColor, kYellowColor, kOrangeColor];
  Random random = new Random();

  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      await pharmacy.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PharmacyDetails tempShop = PharmacyDetails.fromMap(doc);
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

  late SearchBar searchBar;
  _PharmacyState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(color: primaryColor),
        elevation: 0,
        centerTitle: true,
        title: Column(children: [
          Text(
            "Current Location",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 11),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.gps_fixed_rounded,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Loading...',
                  style: TextStyle(
                      letterSpacing: 1,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 20,
                ),
              ],
            ),
            onTap: () {},
          )
        ]),
        backgroundColor: kBackgroundColor,
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: searchBar.build(context),
        backgroundColor: kBackgroundColor,
        body: mainPage());
  }

  mainPage() {
    return SafeArea(
      key: _drawerKey,
      bottom: false,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
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
                        shopList[i].pharmacyName,
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
                      shopList[i].pharmacyName,
                      shopList[i].address,
                      'assets/pharmacy2.png',
                      colors[random.nextInt(3)],
                    ),
                  ),
                )));
  }
}
