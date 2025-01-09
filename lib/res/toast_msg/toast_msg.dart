import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

void toastRedC(String? text) {
  if (text != null) {
    Fluttertoast.showToast(
      msg: text,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.redAccent,
    );
  }
}
void toastGreen(String? text) {
  if (text != null) {
    Fluttertoast.showToast(
      msg: text,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green.shade200,
    );
  }
}


