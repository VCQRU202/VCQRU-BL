import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositorys/repositories_app.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/shared_preferences.dart';
import '../../../ui_view/scanner_ui/enter_code_check/code_check_failed_msg.dart';
import '../../../ui_view/scanner_ui/enter_code_check/code_check_succes_msg.dart';
import '../../dashboard_provider/dashboard_provider.dart';
class TimerQRProvider extends ChangeNotifier {
  final _api = RepositoriesApp();
  int _seconds = 5; // Countdown time
  int get seconds => _seconds;
  bool _isloaing = false;
  bool _isloaing_code_check = false;
  bool get isloading => _isloaing;
  bool get isloaing_appcodeck => _isloaing_code_check;



  TimerQRProvider() {
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners(); // Notify UI to update
      } else {
        timer.cancel(); // Stop the timer at 0
         // Call API when timer ends
      }
    });
  }


  Future<dynamic> appcodecheck(scanCode,lat,long) async {

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
      await Future.delayed(const Duration(seconds: 2));
      print(AppUrl.SCAN_CODE);
      var value = await _api.postRequest(data,AppUrl.SCAN_CODE);
      _isloaing_code_check = false;
      notifyListeners();
      log(value.toString());
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
      return null;
    }
  }

}