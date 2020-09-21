import 'package:discount_calc/common/colors.dart';
import 'package:discount_calc/common/strings.dart';
import 'package:discount_calc/screens/home/calculator_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          Strings.appName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
            child: Container(
              color: mainColor,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(0.0)),
      ),
      body: CalculatorBody(),
    );
  }
}
