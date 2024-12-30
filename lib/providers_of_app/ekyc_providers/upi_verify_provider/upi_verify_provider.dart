import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vcqru_bl/res/api_url/api_url.dart';

import '../../../data/repositorys/repositories_app.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/shared_preferences.dart';
class UPIVerifyProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  bool _isLoading_verify = false;
  bool _hasError_verify = false;
  String _errorMessage_verify = '';
  bool get isLoading_verify => _isLoading_verify;
  bool get hasError_verify => _hasError_verify;
  String get errorMessage_verify => _errorMessage_verify;
  Future<dynamic> verifyUpi(String upi) async {
    _isLoading_verify = true;
    _hasError_verify = false;
    _errorMessage_verify = '';
    notifyListeners();

    try {

      String mConsumerid = await SharedPrefHelper().get("M_Consumerid");
      String mt=mConsumerid.toString();
      Map data = {
        "UPIID":upi,
        "M_Consumerid":mt,
        "Comp_id":AppUrl.Comp_ID
      };
      print(data);
      final value = await _api.postRequest(data,AppUrl.UPIVERIFY);
      _isLoading_verify = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        return value;
      } else {
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (e, stackTrace) {
      // Handle exceptions
      _hasError_verify = true;
      _errorMessage_verify = "Something went wrong. Please try again later.";
      print("Error submitting form: $e");
      print("Stack Trace: $stackTrace");
    } finally {
      _isLoading_verify = false;
      notifyListeners();
    }
  }
}