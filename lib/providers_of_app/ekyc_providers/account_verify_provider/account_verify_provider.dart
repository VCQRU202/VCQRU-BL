import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/repositorys/repositories_app.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/shared_preferences.dart';

class AccountVerifyProvider extends ChangeNotifier {
  final _api = RepositoriesApp();
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  // Getters for state
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  // API Call for Account Verification
  Future<dynamic> verifyAccount({
    required String account,
    required String ifsc,
  }) async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      String result =
          "BankAccountVerification^VCQRURD092022^" + account + "^" + ifsc;
      print(result);
      var re = await sha512Digestfinal(result);
      print("-------" + re);
      String mConsumerid = await SharedPrefHelper().get("M_Consumerid")??"";
      Map data = {
        "AccountNo": account,
        "IFSCCode": ifsc,
        "M_Consumerid": mConsumerid,
        "EncData": re
      };
      print(data);
      final value = await _api.postRequest(data,AppUrl.BANK_ACCOUNT_VERIFY);
      _isLoading = false;
      log(value.toString());
      if (value != null) {
        return value;
      } else {
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
