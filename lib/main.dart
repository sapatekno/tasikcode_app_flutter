import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasikcode_app_flutter/pages/home/home_page.dart';

void main() => runApp(new MyApp());

final routes = {
  '/': (BuildContext context) => new HomePage(),
};

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TasikCode App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: routes,
    );
  }
}
