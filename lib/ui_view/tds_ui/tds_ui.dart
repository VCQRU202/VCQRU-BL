import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/values/values.dart';
class TdsScren extends StatefulWidget {
  const TdsScren({super.key});

  @override
  State<TdsScren> createState() => _TdsScrenState();
}

class _TdsScrenState extends State<TdsScren> {
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          "TDS",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: splashProvider.color_bg,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(

                margin: EdgeInsets.only(left: 15,top: 30),
                width: double.infinity,// Add padding for spacing
                child: Text(
                  "Disclaimer",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10), // Adjust padding for the text container
                child: Text(
                  "TDS calculation will be done on the basis of the loyalty amounts earned after claiming the points as per the gift table. A user will not be able to get benefits of >19999 in a financial year. Users will be liable to pay 10% or 20% of the TDS applicable to them to the brand.",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  softWrap: true,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10), // Adjust padding for the text container
                child: Text(
                  "Details such as Date, Deducted TDS amount will be displayed here.",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
