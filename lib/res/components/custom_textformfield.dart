import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../app_colors/Colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final String? labelText;
  final EdgeInsets margin;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.readOnly = false,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Container(
      height: height1/15,
      margin: margin,
      //margin: EdgeInsets.only(left: width1/15,right: width1/15,top: height1/20),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            backgroundColor: Colors.transparent,color: MyAppColor.TextRed),
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: MyAppColor.TextRed2), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),),
          contentPadding: EdgeInsets.only(left: 20),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1.5, color: MyAppColor.TextRed2),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: MyAppColor.TextRed2),
            borderRadius: BorderRadius.circular(50.0),),
          filled: true,
          fillColor: MyAppColor.formFillClr,
          // hintText: 'Enter Phone Number *',
          labelText: labelText,
          labelStyle: TextStyle(color: MyAppColor.TextRed,fontSize: 14,),
        ),
        keyboardType: keyboardType,
        cursorColor: MyAppColor.TextRed2,
      ),
    );
  }
}