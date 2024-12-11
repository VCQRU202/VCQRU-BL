import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';

import 'Colors.dart';



Future<dynamic> sha512Digestfinal(String input) async {
  var bytesToHash = utf8.encode(input);
  var sha512Digest = sha512.convert(bytesToHash);
  return sha512Digest.toString();
}

generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return digest.bytes;
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
void toastRed(String? text) {
  if (text != null) {
    Fluttertoast.showToast(
      msg: text,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: MyAppColor.DashboardRed,
    );
  }
}
void toastRedC(String? text) {
  if (text != null) {
    Fluttertoast.showToast(
      msg: text,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: MyAppColor.DashboardRed,
    );
  }
}
Future<bool> connectivityChecker() async {
  await EasyLoading.show(
    status: 'loading...',
    maskType: EasyLoadingMaskType.black,
  );
  var connected = false;
  print("Checking internet...");
  try {
    final result = await InternetAddress.lookup('google.com');
    final result2 = await InternetAddress.lookup('facebook.com');
    final result3 = await InternetAddress.lookup('microsoft.com');
    if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty) ||
        (result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) ||
        (result3.isNotEmpty && result3[0].rawAddress.isNotEmpty)) {
      await EasyLoading.dismiss();
      print('connected..');
      connected = true;
    } else {
      await EasyLoading.dismiss();
      print("not connected from else..");
      connected = false;
    }
  } on SocketException catch (_) {
    await EasyLoading.dismiss();
    print('not connected...');
    connected = false;
  }

  return connected;
}
Future<bool> connectivityChecker1() async {
  var connected = false;
  print("Checking internet...");
  try {
    final result = await InternetAddress.lookup('google.com');
    final result2 = await InternetAddress.lookup('facebook.com');
    final result3 = await InternetAddress.lookup('microsoft.com');
    if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty) ||
        (result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) ||
        (result3.isNotEmpty && result3[0].rawAddress.isNotEmpty)) {
      print('connected..');
      connected = true;
    } else {
      print("not connected from else..");
      connected = false;
    }
  } on SocketException catch (_) {
    print('not connected...');
    connected = false;
  }
  return connected;
}



