import 'package:fastmeds/Screens/home_screen.dart';
import 'package:fastmeds/Screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants/Constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FastMeds',
        theme: ThemeData(
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(brightness: Brightness.light),
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
          // textButtonTheme: TextButtonThemeData(
          //   style: ElevatedButton.styleFrom(
          //     primary: primaryColor, // background
          //     onPrimary: Colors.white, // foreground
          //   ),
          // ),
          // fixTextFieldOutlineLabel: true,
          // selectedRowColor: primaryColor,
          primaryColor: primaryColor,
          accentColor: primaryColor,
          backgroundColor: primaryColor,
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ElevatedButton.styleFrom(
          //     primary: primaryColor, // background
          //     onPrimary: Colors.white, // foreground
          //   ),
          // ),
          // buttonTheme: ButtonThemeData(
          //   buttonColor: primaryColor,
          // )
        ),
        home: OnboardingScreen());
  }
}
