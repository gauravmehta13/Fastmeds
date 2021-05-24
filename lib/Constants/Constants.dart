import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

textfieldDecoration(label, IconData icon) {
  return InputDecoration(
      prefixIcon: Icon(icon),
      isDense: true, // Added this
      contentPadding: EdgeInsets.all(15),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFF2821B5),
        ),
      ),
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Color(0xFF23232))),
      labelText: label);
}

const EdgeInsets padding10 = EdgeInsets.all(10);
const SizedBox box10 = SizedBox(
  height: 10,
);
const SizedBox box5 = SizedBox(
  height: 5,
);
const SizedBox box20 = SizedBox(
  height: 20,
);
const SizedBox box30 = SizedBox(
  height: 30,
);
const Color primaryColor = Color(0xFF3f51b5);
const Color secondaryColor = Color(0xFFf9a825);

class C {
  static const primaryColor = Color(0xFF3f51b5);
  static const secondaryColor = Color(0xFFf9a825);

  static const textfieldBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0));

  static const box10 = SizedBox(
    height: 10,
  );
  static const box20 = SizedBox(
    height: 20,
  );
  static const box30 = SizedBox(
    height: 30,
  );
  static const wbox10 = SizedBox(
    width: 10,
  );
  static const wbox20 = SizedBox(
    width: 20,
  );
  static const wbox30 = SizedBox(
    width: 30,
  );
}

displaySnackBar(text, ctx) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1),
    ),
  );
}

displayTimedSnackBar(text, ctx, seconds) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: seconds),
    ),
  );
}
