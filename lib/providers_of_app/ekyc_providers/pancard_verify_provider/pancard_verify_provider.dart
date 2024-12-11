import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../data/repositorys/repositories_app.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/shared_preferences.dart';

class PanVerificationProvider with ChangeNotifier {
  final _api = RepositoriesApp();
  // State variables
  bool _isLoadingPan = false;
  bool _hasErrorPan = false;
  String _errorMessagePan = '';
  bool _isVerificationSuccessful = false;

  // Getters for state
  bool get isLoadingPan => _isLoadingPan;
  bool get hasErrorPan => _hasErrorPan;
  String get errorMessagePan => _errorMessagePan;
  bool get isVerificationSuccessful => _isVerificationSuccessful;


  String? validatePan(String value) {
    if (value.isEmpty) {
      return 'Pan number is required';
    } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
      return 'Invalid PAN number format';
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain alphabets';
    }
    return null;
  }

  String? validateDob(String value) {
    if (value.isEmpty) {
      return 'Date of Birth is required';
    }
    return null;
  }
// API Call to Submit PAN Verification
  Future<dynamic> submitPanForm(String pan, String name, String dob) async {
    _isLoadingPan = true;
    _hasErrorPan = false;
    _errorMessagePan = '';
    _isVerificationSuccessful = false;
    notifyListeners();

    try {
      // Make API call
      String result = "PancardVerificatioin^VCQRURD092022^" + pan + "^" + name;
      print(result);
      var re = await sha512Digestfinal(result);
      print("-------" + re);
      var mConsumerid = await SharedPrefHelper().get("M_Consumerid")??"";

      Map data = {
        "Pancard": pan,
        "PanHolderName": name,
        "M_Consumerid": mConsumerid.toString(),
        "dob":dob,
        "EncData": re
      };
      print(data);
      final value = await _api.postRequest(data,AppUrl.PAN_VERIFY);
      _isLoadingPan = false;
      log(value.toString());
      if (value != null) {
        return value;
      } else {
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (e, stackTrace) {
      // Handle exceptions
      _hasErrorPan = true;
      _errorMessagePan = "Something went wrong. Please try again later.";
      print("Error submitting form: $e");
      print("Stack Trace: $stackTrace");
    } finally {
      _isLoadingPan = false;
      notifyListeners();
    }
  }

  // Reset the state (optional utility)
  void resetState() {
    _isLoadingPan = false;
    _hasErrorPan = false;
    _errorMessagePan = '';
    _isVerificationSuccessful = false;
    notifyListeners();
  }
}
