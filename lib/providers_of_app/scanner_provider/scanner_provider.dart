import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';


class Scanner_provider extends ChangeNotifier {
  TextEditingController codeCheckController = TextEditingController();
  final _api = RepositoriesApp();
  Barcode? result;
  QRViewController? controller;
  Position? _currentPosition;
  String lat = "";
  String long = "";
  bool _isloaing = false;
  bool _isloaing_code_check = false;
  bool get isloading => _isloaing;
  bool get isloaing_appcodeck => _isloaing_code_check;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Position get currentPosition => _currentPosition!;
  String? _lastVerifiedCode;
  DateTime? _lastScanTime;
  DateTime? _lastApiCallTime;

  // Get the last verified code
  String? get lastVerifiedCode => _lastVerifiedCode;

  // Get the last scan time
  DateTime? get lastScanTime => _lastScanTime;

  void updatePosition(Position position) {
    _currentPosition = position;
    lat = position.latitude.toString();
    long = position.longitude.toString();
    notifyListeners();
  }

  void setQRViewController(QRViewController qrController) {
    controller = qrController;
    notifyListeners();
  }

  void updateResult(Barcode newResult) {
    result = newResult;
    notifyListeners();
  }
  void startScaning() {
    print("--------------start--- --------");
    Future.delayed((Duration(seconds: 2))).then((value) {
      controller!.resumeCamera();
    });
  }
  bool canVerifyScan(String scannedCode) {
    // If it's a new code (or no previous code recorded), allow verification
    if (lastVerifiedCode == null || lastVerifiedCode != scannedCode) {
      print("--------new code---${scannedCode}");
      return true;
    }

    // If it's the same code, check the time difference since the last scan
    if (_lastVerifiedCode == scannedCode) {
      final difference = DateTime.now().difference(_lastScanTime!);

      // If the same code is scanned after 6 seconds, allow verification
      if (difference.inSeconds >= 4) {
        return true;
      } else {
        // If less than 6 seconds, block verification
        print("Scan ignored. Please wait for 4 seconds.");
        return false;
      }
    }

    // Default case: block verification if conditions are not met
    return false;
  }
  void startCemra() {
    print("--------------start-----------");
    Future.delayed((Duration(seconds: 2))).then((value) {
      controller!.resumeCamera();
    });
  }
  // Method to update the last scan details
  void updateScanDetails(String code) {
    _lastVerifiedCode = code;
    _lastScanTime = DateTime.now();
    notifyListeners();  // Notify listeners when state changes
  }
  Future<dynamic> appcodecheck(scanCode) async {
    if (_lastApiCallTime != null &&
        DateTime.now().difference(_lastApiCallTime!).inSeconds < 4) {
      print("API call blocked. Please wait for 4 seconds.");
      return null; // Early exit if last API call was less than 7 seconds ago
    }

    print("Calling scan bar");
    String mobile_number = await SharedPrefHelper().get("MobileNumber");
    _isloaing_code_check = true;
    notifyListeners();
    Map data = {
      "MobileNO": mobile_number,
      "UniqueCode": scanCode,
      "Comp_ID": AppUrl.Comp_ID,
      "Mode": "BL_APP",
      "latitude": lat,
      "longitude": long,
    };
    print(data);
    try {
      print(AppUrl.SCAN_CODE);
      var value = await _api.postRequest(data,AppUrl.SCAN_CODE);
      _isloaing_code_check = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        return value;
      } else {
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (error, stackTrace) {
      _isloaing_code_check = false;
      notifyListeners();
      await EasyLoading.dismiss();
      return null;
    }
  }
}
