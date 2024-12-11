import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';
class KYCMainProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  final Dio dio = Dio();

  bool _isloaing_kyc = false;
  bool _hasError_kyc = false;
  String _errorMessage_kyc = '';

  bool _isloaing_kycs = false;
  bool _hasError_kycs = false;
  String _errorMessage_kycs = '';
  String _panEnable="";
  String _aadharEnable="";
  String _accountEnable="";
  String get panEnable=>_panEnable;
  String get aadharEnable=>_aadharEnable;
  String get accountEnable=>_accountEnable;
  bool get isloading_kyc => _isloaing_kyc;
  bool get hasError_kyc => _hasError_kyc;
  String get errorMessage_kyc => _errorMessage_kyc;

  bool get isloading_kycs => _isloaing_kycs;
  bool get hasError_kycs => _hasError_kycs;
  String get errorMessage_kycs => _errorMessage_kycs;
// Fetch the logo and background image URLs from the API
  Future<dynamic> getBrandSettingData() async {
    _isloaing_kyc = true;
    _hasError_kyc=false;
    try {
      String result = "VendorAppSetting^VCQRURD092022^"+AppUrl.Comp_ID;
      print(result);
      var re = await sha512Digestfinal(result);
      print("-------" + re);
      Map data = {
        "Comp_ID": AppUrl.Comp_ID,
        "EncData": re
      };
      print(data);
      var value = await _api.postRequest(data,AppUrl.BRAND_SETTING);
      _isloaing_kyc = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        if (value['Status']) {
          print("-----------true---");

          _panEnable = value['Data']['KycDetails']['PANCard'] ?? ''; // Set logo URL
          _aadharEnable = value['Data']['KycDetails']['AadharCard'] ?? ''; // Set logo URL
          _accountEnable = value['Data']['KycDetails']['AccountDetails'] ?? ''; // Set logo URL
          notifyListeners();
        } else {
          print("-----------false---");
          _isloaing_kyc = false;
          _hasError_kyc = true;
          _errorMessage_kyc =value['message'];
          notifyListeners();
        }
        return value;
      } else {
        print("----error---");
        notifyListeners();
        _isloaing_kyc = false;
        _hasError_kyc = true;
        _errorMessage_kyc = "'Something Went Wrong' Please Try Again Later";
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (error, stackTrace) {
      print("----error1---");
      _isloaing_kyc = false;
      _hasError_kyc = true;
      _errorMessage_kyc = "'Something Went Wrong' Please Try Again Later";
      notifyListeners();
      return null;
    }finally {
      _isloaing_kyc = false;
      notifyListeners();
    }

  }
  Future<dynamic> getKYCSTATUS() async {
    _isloaing_kycs = true;
    _hasError_kycs=false;
    try {
      String mConsumerid = await SharedPrefHelper().get("M_Consumerid")??"";
      String mobile = await SharedPrefHelper().get("MobileNumber")??"";
      String result = "UserKycStatus^VCQRURD092022^"+AppUrl.Comp_ID+"^"+mobile+"^"+mConsumerid;
      print(result);
      var re = await sha512Digestfinal(result);
      print("-------" + re);
      Map data = {
        "Comp_ID": AppUrl.Comp_ID,
        "Mobile": mobile,
        "M_Consumerid": mConsumerid,
        "EncData": re
      };
      print(data);
      var value = await _api.postRequest(data,AppUrl.KYC_STATUS);
      _isloaing_kycs = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        if (value['Status']) {
          print("-------kyc staus----true---");

          notifyListeners();
        } else {
          print("-----------false---");
          _isloaing_kycs = false;
          _hasError_kycs = true;
          _errorMessage_kycs =value['message'];
          notifyListeners();
        }
        return value;
      } else {
        print("----error---");
        notifyListeners();
        _isloaing_kycs = false;
        _hasError_kycs = true;
        _errorMessage_kycs = "'Something Went Wrong' Please Try Again Later";
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (error, stackTrace) {
      print("----error1---");
      _isloaing_kycs = false;
      _hasError_kycs = true;
      _errorMessage_kycs = "'Something Went Wrong' Please Try Again Later";
      notifyListeners();
      return null;
    }finally {
      _isloaing_kycs = false;
      notifyListeners();
    }

  }

  Future<void> retryFetchBrandsetting() async {
    await getBrandSettingData();
  }
}