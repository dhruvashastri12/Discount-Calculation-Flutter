import 'package:discount_calc/common/strings.dart';
import 'package:discount_calc/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      home: HomePage(),
    );
  }
}