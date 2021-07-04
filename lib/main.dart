import 'package:first_flutter_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home/home.dart';

// this must be in shared preferences
String username;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          button: GoogleFonts.lato(fontSize: 17, color: Colors.white),
          bodyText1: GoogleFonts.lato(fontSize: 17),
          headline1: GoogleFonts.lato(color: Colors.white, fontSize: 20),
        ),
        primarySwatch: Colors.lightBlue,
        backgroundColor: Colors.blueGrey[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: HomePage(),
      onGenerateRoute: RouteGenerator.generateRoute,
      // routes: ,
    );
  }
}
