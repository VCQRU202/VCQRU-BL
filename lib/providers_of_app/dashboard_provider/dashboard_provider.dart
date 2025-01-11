import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/dashboard/dashboard_dyamic_model.dart';
import '../../models/dashboard/dashboard_model.dart';
import '../../models/profile/profile_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';
class DashboardProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  // String valustate="1";
  // String get ekycStatus=>valustate;
  //--------Wallet------------
  DashBoardData? _dashboard;
  bool _isLoading_wallet = true;
  bool _hasError_wallet = false;
  String _errorMessage_wallet = '';
  int _countNotication=0;
  int? get countNotication => _countNotication;
  DashBoardData? get dashbaord => _dashboard;
  bool get isLoading_wallet => _isLoading_wallet;
  bool get hasError_wallet => _hasError_wallet;
  String get errorMessage_wallet => _errorMessage_wallet;


  bool _isloaing_kycs = false;
  bool _hasError_kycs = false;
  String _errorMessage_kycs = '';
  bool get isloading_kycs => _isloaing_kycs;
  bool get hasError_kycs => _hasError_kycs;
  String get errorMessage_kycs => _errorMessage_kycs;

  bool _isloaing_profile = false;
  bool _hasError_profile = false;
  String _errorMessage_profile = '';
  bool get isloading_profile => _isloaing_profile;
  bool get hasError_profile => _hasError_profile;
  String get errorMessage_profile => _errorMessage_profile;
  ProfileData? _profile;
  ProfileData? get profile => _profile;
  String _kycStatu="Pending";
  String get kycStatus=>_kycStatu;

  DashboardDynamicModel? _dashdynaData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  DashboardDynamicModel? get dashdynaData => _dashdynaData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  DateTime _currentDate = DateTime.now();

  DateTime get currentDate => _currentDate;

  String get formattedDate => DateFormat('d MMM y').format(_currentDate);

  Future<void> fetchWallet() async {
    _isLoading_wallet = true;
    _hasError_wallet = false;
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c=m_Consumerid.toString();

    Map requestData = {
      "M_Consumerid":m_c,
      "Comp_ID":AppUrl.Comp_ID
    };
    print(requestData);
    try {
      print(AppUrl.DASHBOARD);
      final response = await _api.postRequest(requestData, AppUrl.DASHBOARD);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading_wallet = true;
        _hasError_wallet = false;
        _dashboard=DashBoardData.fromJson(response['data']);
        // String total_Cash = _dashboard!.totalPoint?? "0";
        // String transferred_Cash = _dashboard!.reedemPoint?? "0";
        // var e = double.parse(total_Cash);
        // var f = double.parse(transferred_Cash);
        // var wallett = e - f;
      } else {
        print("-----------false---");
        _isLoading_wallet = false;
        _hasError_wallet = true;
        _errorMessage_wallet =response['message'];
      }
    } catch (error) {
      _isLoading_wallet = false;
      _hasError_wallet = true;
      _errorMessage_wallet = "'Something Went Wrong' Please Try Again Later";
      print('Failed to load profile');
    } finally {
      _isLoading_wallet = false;
      notifyListeners();
    }
  }
  Future<void> retryFetchWallet() async {
    notifyListeners();
    await fetchWallet();

  }
  Future<dynamic> getKYCSTATUS() async {
    _isloaing_kycs = true;
    _hasError_kycs=false;
    try {
      var mConsumerid = await SharedPrefHelper().get("M_Consumerid");
      String mobile = await SharedPrefHelper().get("MobileNumber")??"";
      String mt=mConsumerid.toString();
      Map data = {
        "Comp_ID": AppUrl.Comp_ID,
        "Mobile": mobile,
        "M_Consumerid": mt,
      };
      print(data);
      var value = await _api.postRequest(data,AppUrl.KYC_STATUS);
      _isloaing_kycs = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        if (value['success']) {
          print("-------kyc staus----true---");
          var kycStatus=value['data']['vrKbl_KYC_StatusString']??"";
          var count=value['data']['countNotification']??0;
          _kycStatu=kycStatus;
          _countNotication=count;
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
  Future<void> retryKYCSTATUS() async {
    await getKYCSTATUS();
  }

  Future<dynamic> getProfile() async {
    _isloaing_profile = true;
    _hasError_profile=false;
    try {
      var mConsumerid = await SharedPrefHelper().get("M_Consumerid");
      String mobile = await SharedPrefHelper().get("MobileNumber")??"";
      String mt=mConsumerid.toString();
      Map data ={
        "Comp_id":AppUrl.Comp_ID,
        "Mobileno":mobile,
        "M_consumerid":mt
      };
      print(data);
      var value = await _api.postRequest(data,AppUrl.GETPROFILE);
      _isloaing_profile = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        if (value['success']) {
          _profile=ProfileData.fromJson(value['data']);
          notifyListeners();
        } else {
          print("-----------false---");
          _isloaing_profile= false;
          _hasError_profile = true;
          _errorMessage_profile =value['message'];
          notifyListeners();
        }
        return value;
      } else {
        print("----error---");
        notifyListeners();
        _isloaing_profile = false;
        _hasError_profile = true;
        _errorMessage_profile = "'Something Went Wrong' Please Try Again Later";
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (error, stackTrace) {
      print("----error1---");
      _isloaing_profile = false;
      _hasError_profile = true;
      _errorMessage_profile = "'Something Went Wrong' Please Try Again Later";
      notifyListeners();
      return null;
    }finally {
      _isloaing_profile = false;
      notifyListeners();
    }

  }
  Future<void> retryProfile() async {
    notifyListeners();
    await getProfile();
  }


  Future<void> getDashboardIName() async {
    _isLoading = true;
    _hasError = false;
    var mConsumerid = await SharedPrefHelper().get("M_Consumerid");
    String mobile = await SharedPrefHelper().get("MobileNumber")??"";
    String mt=mConsumerid.toString();
    Map requestData ={
      "Comp_id":AppUrl.Comp_ID,
      "Mobileno":mobile,
      "M_consumerid":mt
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.DASHBOARD_NAME_IMAGE);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _dashdynaData=DashboardDynamicModel.fromJson(response);
      } else {
        print("-----------false---");
        _isLoading = false;
        _hasError = true;
        _errorMessage =response['message'];
        notifyListeners();
      }
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = "'Something Went Wrong' Please Try Again Later1";
      print('Failed to load profile');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> retryDashboardIName() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getDashboardIName();
  }

}