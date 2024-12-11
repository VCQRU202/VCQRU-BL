import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';

class EnterMobileProvider with ChangeNotifier{
   TextEditingController mobileController = TextEditingController();
   final _api = RepositoriesApp();
  bool _isChecked = false;
  bool _isCompleted=false;
  int _mobilenum = 0;
   bool _isloaing = false;
   bool _isloaing_verify_otp = false;
   bool get isloading => _isloaing;
   bool get isloaing_otp => _isloaing_verify_otp;

  int get mobilnum => _mobilenum;
   bool get mobileCOmpleted => _isCompleted;
   bool get isCheckComplete => _isChecked;
  void changeMobileLenght(value) {
    _mobilenum = value;
    if(_mobilenum==10){
      print("-----true===");
      _isCompleted=true;
    }else{
      print("-----false===");
      _isCompleted=false;
    }
    notifyListeners();
  }

   void ischeckStatus(value) {
     _isChecked = value;
     notifyListeners();
   }
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
   void clearData(){
     mobileController.clear();
   }

   @override
   void dispose() {
     _timer?.cancel();
     super.dispose();
   }
   Future<dynamic> sendOtp() async {

     startTimer();
     _isloaing = true;
     notifyListeners();
     var companyName = await SharedPrefHelper().get("CompanyName")??"";
     String result = "SendOTPLogin^VCQRURD092022^"+ mobileController.text + "^" +companyName;
     print(result);
     var re = await sha512Digestfinal(result);
     print("------- " + re);
     Map data = {
       "compName":companyName,
       "mobile": mobileController.text,
       "EncData": re
     };
     print(data.toString());
     try {
       var value = await _api.sendOTP(data,AppUrl.SEND_OTP);
       _isloaing = false;
       notifyListeners();
       log(value.toString());
       if (value != null) {
         return value;
       } else {
         toastRedC(AppUrl.warningMSG);
         return null;
       }
     } catch (error, stackTrace) {
       _isloaing = false;
       notifyListeners();
       return null;
     }
   }

   Future<dynamic> verifyOtp() async {
     _isloaing_verify_otp = true;
     notifyListeners();
     var companyName = await SharedPrefHelper().get("CompanyName")??"";
     String result = "validateotp^VCQRURD092022^" + otpValue.toString() + "^" + mobileController.text;
     print(result);
     var re = await sha512Digestfinal(result);
     print("------- " + re);
     Map data = {
       "otpCode": otpValue.toString(),
       "Mobile": mobileController.text,
       "EncData": re,
       "Comp_Name": companyName
     };
     print(data.toString());
     try {
       var value = await _api.verifyOTP(data,AppUrl.Verify_OTP);
       _isloaing_verify_otp = false;
       notifyListeners();
       log(value.toString());
       if (value != null) {
         return value;
       } else {
         toastRedC(AppUrl.warningMSG);
         return null;
       }
     } catch (error, stackTrace) {
       _isloaing_verify_otp = false;
       notifyListeners();
       return null;
     }
   }
}