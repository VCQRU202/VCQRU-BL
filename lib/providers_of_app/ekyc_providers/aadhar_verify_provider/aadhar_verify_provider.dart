import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/repositorys/repositories_app.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/shared_preferences.dart';

class AadharVerifyProvider extends ChangeNotifier {
  final _api = RepositoriesApp();
  bool _isLoading_otp = false;
  bool _hasError_otp = false;
  String _errorMessage_otp = '';

  bool _isLoading_verify = false;
  bool _hasError_verify = false;
  String _errorMessage_verify = '';

  // State getters
  bool get isLoading_otp => _isLoading_otp;
  bool get hasError_otp => _hasError_otp;
  String get errorMessage_otp => _errorMessage_otp;

  bool get isLoading_verify => _isLoading_verify;
  bool get hasError_verify => _hasError_verify;
  String get errorMessage_verify => _errorMessage_verify;
  int _start = 30;
  Timer? _timer;

  int get start => _start;
  var _otpValue;

  get otpValue => _otpValue;
  bool _completed = false;

  bool get otpCOmpleted => _completed;
  void startTimer() {
    _start = 30;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        _start--;
        notifyListeners();
      }
    });
  }
  void otpSave(otp) {
    _otpValue = otp;
    notifyListeners();
  }

  void otpCompleted(value) {
    _completed = value;
    notifyListeners();
  }
  void stopTimer() {
    _timer?.cancel();
  }
  // Aadhar verification otp send method
  Future<dynamic> sendotpAadhar1(String aadharNumber) async {
    _isLoading_otp = true;
    _hasError_otp = false;
    _errorMessage_otp = '';
    notifyListeners();

    try {
      // Make API call
      String result = "SendOTPForKYC^VCQRURD092022^" + aadharNumber;
      print(result);
      var re = await sha512Digestfinal(result);
      print("-------" + re);
      var mConsumerid = await SharedPrefHelper().get("M_Consumerid");
      Map data = {
        "AadharNo": aadharNumber,
        "M_Consumerid": mConsumerid,
        "EncData": re
      }; // Simulate network delay
      print(data);
      final value = await _api.postRequest(data,AppUrl.SendOTPFOR_KYC);
      _isLoading_otp = false;
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
      _hasError_otp = true;
      _errorMessage_otp = "Something went wrong. Please try again later.";
      print("Error submitting form: $e");
      print("Stack Trace: $stackTrace");
    } finally {
      _isLoading_otp = false;
      notifyListeners();
    }
  }

  // Aadhar otp verification method
  Future<dynamic> verifyAadhar1(String aadharNumber,String requestId,String otp) async {
    _isLoading_verify = true;
    _hasError_verify = false;
    _errorMessage_verify = '';
    notifyListeners();

    try {
      // Make API call
      String result =
          "ValidateOTPForKYC^VCQRURD092022^" + requestId + "^" + otp;
      print(result);
      var re = await sha512Digestfinal(result);
      print("-------" + re);
      String mConsumerid = await SharedPrefHelper().get("mConsumerid");
      Map data = {
        "AadharNo": aadharNumber,
        "Request_Id": requestId,
        "M_Consumerid": mConsumerid,
        "Otp": otp,
        "EncData": re
      };
      final value = await _api.postRequest(data,AppUrl.AADHAR_VERIFY_OTP);
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
