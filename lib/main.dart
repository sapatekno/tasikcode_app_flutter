import 'package:flutter/material.dart';
import 'package:tasikcode_app_flutter/pages/home/home_page.dart';

void main() => runApp(new MyApp());

final routes = {
  '/': (BuildContext context) => new HomePage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TasikCode App',
      theme: new ThemeData(primarySwatch: Colors.blue),
      routes: routes,
    );
  }
}
