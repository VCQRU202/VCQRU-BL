import 'dart:developer';

import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/kyc/kyc_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';
class KycDetailsProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  KycDetailsModel? _kycData;
  KycDetailsModel? get kycData => _kycData;
  bool _isloaing_details = false;
  bool _hasError_details = false;
  String _errorMessage_details = '';
  bool get isloading_kycs => _isloaing_details;
  bool get hasError_kycs => _hasError_details;
  String get errorMessage_kycs => _errorMessage_details;
  Future<dynamic> getKYCDetail() async {
    _isloaing_details = true;
    _hasError_details=false;
    try {
      var mConsumerid = await SharedPrefHelper().get("M_Consumerid");
      String mt=mConsumerid.toString();
      Map data = {
        "M_Consumerid": mt,
      };
      print(data);
      var value = await _api.postRequest(data,AppUrl.KYC_DETAILS);
      _isloaing_details = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        if (value['success']) {
          _kycData=KycDetailsModel.fromJson(value);
          notifyListeners();
        } else {
          print("-----------false---");
          _isloaing_details = false;
          _hasError_details = true;
          _errorMessage_details =value['message'];
          notifyListeners();
        }
        return value;
      } else {
        print("----error---");
        notifyListeners();
        _isloaing_details = false;
        _hasError_details = true;
        _errorMessage_details = "'Something Went Wrong' Please Try Again Later";
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (error, stackTrace) {
      print("----error1---");
      _isloaing_details = false;
      _hasError_details = true;
      _errorMessage_details = "'Something Went Wrong' Please Try Again Later";
      notifyListeners();
      return null;
    }finally {
      _isloaing_details = false;
      notifyListeners();
    }

  }

  Future<void> retryFetchKYCDetail() async {
    notifyListeners();
    await getKYCDetail();
  }
}