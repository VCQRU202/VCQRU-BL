import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';
import '../../ui_view/scanner_ui/scanner_ui.dart';

class LoginProviderPassword with ChangeNotifier {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;
  bool _isChecked = false;
  bool _isCompleted=false;
  int _mobilenum = 0;
  int get mobilnum => _mobilenum;
  bool get mobileCOmpleted => _isCompleted;
  bool get isCheckComplete => _isChecked;
  bool _isloaing = false;
  bool _isloaing_verify_otp = false;
  bool get isloading => _isloaing;
  bool get isloaing_otp => _isloaing_verify_otp;
  final _api = RepositoriesApp();

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }
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
  Future<void> login(BuildContext context) async {
    if (mobileController.text.isEmpty) {
      _showToast(context, "Please Enter Mobile Number");
    } else if (passwordController.text.isEmpty) {
      _showToast(context, "Please Enter Password");
    } else {
      isLoading = true;
      notifyListeners();
      // Simulate a network call
      await Future.delayed(Duration(seconds: 2));
      isLoading = false;
      notifyListeners();
      // Navigate or show success
      loginWithPassword(mobileController.text, passwordController.text);
      _showToast(context, "Login successful!");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewExample()));
    }
  }
  Future<dynamic> loginWithPassword(String mobileNumber, String password) async {
    await EasyLoading.show(
      status: 'Logging in...',
      maskType: EasyLoadingMaskType.black,
    );
    isLoading = true;
    notifyListeners();
    print("Attempting login...");
    String appName = "Sagar"; // Example app name
    String appMode = "Sagar Petro"; // Example app mode

    // Combine the login data into an encrypted string
    String result = "login^$mobileNumber^$password^$appName^$appMode";
    print("Login Request Data: $result");

    // Generate encrypted hash (using sha512Digestfinal or similar)
    var encryptedData = await sha512Digestfinal(result);
    print("Encrypted Data: $encryptedData");

    // Create request payload

    Map data = {"Password": password, "Mobile": mobileNumber,"compName":"", "EncData": encryptedData};
    print("Request Payload: $data");

    try {
      print(AppUrl.LOGIN_URL); // Example login URL constant
      var response = await _api.postRequest(data, AppUrl.LOGIN_URL);

      // Dismiss loading indicator
      await EasyLoading.dismiss();
      isLoading = false;
      log(response.toString());

      if (response != null) {
        // Successful login logic
        print("Login Successful");
        return response;
      } else {
        // Show warning if login fails
        toastRedC("Invalid login credentials. Please try again.");
        return null;
      }
    } catch (error, stackTrace) {
      print("Error during login: $error");
      await EasyLoading.dismiss();
      toastRedC("Login failed. Please try again later.");
      return null;
    }
  }
  Future<dynamic> sendOtp() async {

    startTimer();
    _isloaing = true;
    notifyListeners();
    var companyName = await SharedPrefHelper().get("CompanyName")??"";
    String result = "SendOTP^VCQRURD092022^"+ mobileController.text + "^" + companyName;
    print(result);
    var re = await sha512Digestfinal(result);
    print("------- " + re);
    Map data = {
      "compName": companyName,
      "mobile": mobileController.text,
      "AppVersion": "",
      "APPName": "Sagar",
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

  Future<dynamic> verifyOtp(mobile) async {
    _isloaing_verify_otp = true;
    notifyListeners();
    var companyName = await SharedPrefHelper().get("CompanyName")??"";
    String result = "BlValidateOtpForLogin^VCQRURD092022^" + otpValue.toString() + "^" +mobile;
    print(result);
    var re = await sha512Digestfinal(result);
    print("------- " + re);
    Map data = {
      "otpCode": otpValue.toString(),
      "Mobile": mobile,
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

  void _showToast(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
