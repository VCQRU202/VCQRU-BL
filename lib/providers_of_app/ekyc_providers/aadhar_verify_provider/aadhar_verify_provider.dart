import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/repositorys/repositories_app.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/shared_preferences.dart';

class AadharVerifyProvider extends ChangeNotifier {

  final aadharController = TextEditingController();
  final _api = RepositoriesApp();
  bool _isLoading_otp = false;
  bool _hasError_otp = false;
  String _errorMessage_otp = '';

  bool _isLoading_verify = false;
  bool _hasError_verify = false;
  String _errorMessage_verify = '';
  String _referenId="";
  String get referenId => _referenId;

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



  @override
  void dispose() {
    aadharController.dispose();
    super.dispose();
  }
  void setReferenceId(val){
    _referenId=val;
    notifyListeners();
  }
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
    startTimer();
    try {

      var mConsumerid = await SharedPrefHelper().get("M_Consumerid");
      String mt=mConsumerid.toString();
      Map data = {
        "AadharNo": aadharNumber,
        "M_Consumerid": mt,
      }; // Simulate network delay
      print(data);
      final value = await _api.postRequest(data,AppUrl.SendADHAROTPFOR_KYC);
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

      String mConsumerid = await SharedPrefHelper().get("M_Consumerid");
      String mt=mConsumerid.toString();
      Map data = {
        "AadharNo": aadharNumber,
        "Request_Id": requestId,
        "Comp_id": AppUrl.Comp_ID,
        "M_Consumerid": mt,
        "Otp": otp
      };
      print(data);
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
