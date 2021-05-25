import 'package:fastmeds/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: kSearchBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Search for Meds"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MaterialButton(
            onPressed: () {},
            color: kOrangeColor,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 13,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
