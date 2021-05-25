import 'package:fastmeds/Constants/Constants.dart';
import 'package:fastmeds/Screens/HomePage/Gridveiw.dart';
import 'package:fastmeds/Screens/Pharmacy/components/search_bar.dart';
import 'package:fastmeds/Widgets/Loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Drawer.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ${_auth.currentUser!.displayName!.split(" ")[0]}",
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    box10,
                    Text(
                      'Find your\nmedical solution!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                HomeGridView()
              ],
            ),
          ),
        ));
  }
}
