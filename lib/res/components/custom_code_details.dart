import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomCodeDetails extends StatelessWidget {
  final String text1;
  final String text2;
  final Color textColor1;
  final Color imageColor;

  CustomCodeDetails({
    required this.text1,
    required this.text2,
    required this.textColor1,
    required this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9.6,
      width: MediaQuery.of(context).size.width / 4.2,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/verify_icon.png",
              color: imageColor,
              height: 24,
              width: 24,
            ),
            CustomText(text: text1, color: textColor1,fontSize: 18,fontWeight: FontWeight.bold,),
            CustomText(text: text2, color: Colors.black,fontSize: 14,),
          ],
        ),
      ),
    );
  }
}
