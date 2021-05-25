import 'package:fastmeds/Constants/Constants.dart';
import 'package:fastmeds/Screens/Ambulance/Ambulance.dart';
import 'package:fastmeds/Screens/Consultation/Consultation.dart';
import 'package:fastmeds/Screens/Diseases/Diseases.dart';
import 'package:fastmeds/Screens/Doctors/Doctors.dart';
import 'package:fastmeds/Screens/HomePage/HomePage.dart';
import 'package:fastmeds/Screens/Hospital/Hospital.dart';
import 'package:fastmeds/Screens/Pharmacy/Pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Fade Route.dart';

List gridData = [
  {"title": "Doctors", "page": Doctors(), "icon": FontAwesomeIcons.stethoscope},
  {"title": "Hospital", "page": Hospital(), "icon": FontAwesomeIcons.hospital},
  {"title": "Diseases", "page": Diseases(), "icon": FontAwesomeIcons.disease},
  {
    "title": "Ambulance",
    "page": Ambulance(),
    "icon": FontAwesomeIcons.ambulance
  },
  {
    "title": "Consultation",
    "page": Consultation(),
    "icon": FontAwesomeIcons.facebookMessenger
  },
  {"title": "Pharmacy", "page": Pharmacy(), "icon": FontAwesomeIcons.pills},
];

class HomeGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: gridData.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  FadeRoute(page: gridData[index]["page"]),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        gridData[index]["icon"],
                        color: primaryColor.withOpacity(0.7),
                      ),
                      Text(
                        gridData[index]["title"],
                        style: TextStyle(color: primaryColor, fontSize: 13),
                      ),
                    ],
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            );
          }),
    );
  }
}
