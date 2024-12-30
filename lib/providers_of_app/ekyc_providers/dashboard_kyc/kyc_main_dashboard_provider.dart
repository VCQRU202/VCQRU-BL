import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../data/repositorys/repositories_app.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/shared_preferences.dart';

class KYCMainDashboardProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  final Dio dio = Dio();

  int _kycbtn=0;
  int get kycbtn=>_kycbtn;

  bool _isloaing_kyc = false;
  bool _hasError_kyc = false;
  String _errorMessage_kyc = '';
  String _comName="";
  String get comName=>_comName;

  bool _isloaing_kycs = false;
  bool _hasError_kycs = false;
  String _errorMessage_kycs = '';
  String _panEnable="";
  String _aadharEnable="";
  String _accountEnable="";
  String get panEnable=>_panEnable;
  String get aadharEnable=>_aadharEnable;
  String get accountEnable=>_accountEnable;
  String _pankycstatus="";
  String _aadharkycstatus="";
  String _accountkycstatus="";
  String _upikycstatus="";
  String get pankycstatus=>_pankycstatus;
  String get aadharkycstatus=>_aadharkycstatus;
  String get accountkycstatus=>_accountkycstatus;
  String get upikycstatus=>_upikycstatus;
  bool get isloading_kyc => _isloaing_kyc;
  bool get hasError_kyc => _hasError_kyc;
  String get errorMessage_kyc => _errorMessage_kyc;

  bool get isloading_kycs => _isloaing_kycs;
  bool get hasError_kycs => _hasError_kycs;
  String get errorMessage_kycs => _errorMessage_kycs;
// Fetch the logo and background image URLs from the API
  KYCMainProvider() {
    getCompanyName(); // Call on provider initialization
  }

  void getCompanyName() async{
    String com = await SharedPrefHelper().get("CompanyName")??"Vender";
    print("----com-----${com}");
    _comName=com.split(" ")[0];
    notifyListeners();
  }
  void setPanKyc(value){
    _pankycstatus=value;
    notifyListeners();
  }
  void setAadhar(value){
    _aadharkycstatus=value;
    notifyListeners();
  }
  void setBank(value){
    _accountkycstatus=value;
    notifyListeners();
  }
  void setUPI(value){
    _upikycstatus=value;
    notifyListeners();
  }
  void setKYCMAIN(int value){
    if (_kycbtn > 0) {
      _kycbtn--; // Subtract 1
      notifyListeners();
    } else {
      print("Value cannot go below zero");
    }
  }
  Future<dynamic> getKYCSTATUS() async {
    _isloaing_kycs = true;
    _hasError_kycs=false;
    try {
      String mConsumerid = await SharedPrefHelper().get("M_Consumerid")??"";
      String mobile = await SharedPrefHelper().get("MobileNumber")??"";

      Map data = {
        "Comp_ID": AppUrl.Comp_ID,
        "Mobile": mobile,
        "M_Consumerid": mConsumerid,
      };
      print(data);
      var value = await _api.postRequest(data,AppUrl.KYC_STATUS);
      _isloaing_kycs = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        if (value['success']) {
          print("-------kyc staus----true---");
          var panekycStatusString=value['data']['panekycStatusString'];
          var aadharkycStatusString=value['data']['aadharkycStatusString'];
          var bankekycStatusString=value['data']['bankekycStatusString'];
          var bankkyccEnable=value['data']['bankkyccEnable']??"";
          var panekycEnable=value['data']['panekycEnable']??"";
          var aadharekycEnable=value['data']['aadharekycEnable']??"";
          var upikyccEnable=value['data']['upikyccEnable']??"";

          _panEnable=panekycEnable;
          _aadharEnable=aadharekycEnable;
          _accountEnable=bankkyccEnable;
          if(bankkyccEnable.toString().endsWith("Yes")){
            _kycbtn=_kycbtn+1;
            notifyListeners();
          }
          if(bankkyccEnable.toString().endsWith("Yes")){
            _kycbtn=_kycbtn+1;
            notifyListeners();
          }
          if(bankkyccEnable.toString().endsWith("Yes")){
            _kycbtn=_kycbtn+1;
            notifyListeners();
          }
          print("------_kycbtn-----${_kycbtn}---");
          _pankycstatus=panekycStatusString;
          _aadharkycstatus=aadharkycStatusString;
          _accountkycstatus=bankekycStatusString;
          _upikycstatus="";

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
    await getKYCSTATUS();
  }
}