import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';

import '../../models/referal_model/referal_code_model.dart';
import '../../models/referal_model/referal_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';
class ReferralProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  ReferralModel? _notifiData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  ReferralModel? get notifiData => _notifiData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;


  bool _isLoading_ref = true;
  bool _hasError_ref = false;
  String _errorMessage_ref = '';
  ReferralCodeModel? _getCodeData;

  bool get isLoading_ref => _isLoading_ref;
  bool get hasError_ref => _hasError_ref;
  String get errorMessage_ref => _errorMessage_ref;
  ReferralCodeModel? get getCodeData => _getCodeData;



  NotificationsProvider() {
    getNotificationList();
  }

  Future<void> getNotificationList() async {
    _isLoading = true;
    _hasError = false;
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c=m_Consumerid.toString();

    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
      "M_Consumerid":m_c,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.REFERAL_HISTORY);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _notifiData=ReferralModel.fromJson(response);
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
  Future<void> retrygetNotificationList() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getNotificationList();
  }


  Future<void> getReferCodeMsg() async {
    _isLoading_ref = true;
    _hasError_ref = false;
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c=m_Consumerid.toString();

    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
      "M_Consumerid":m_c,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.REFERAL_CONTENT);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading_ref = true;
        _hasError_ref = false;
        _getCodeData=ReferralCodeModel.fromJson(response);
      } else {
        print("-----------false---");
        _isLoading_ref = false;
        _hasError_ref = true;
        _errorMessage_ref =response['message'];
        notifyListeners();
      }
    } catch (error) {
      _isLoading_ref = false;
      _hasError_ref = true;
      _errorMessage_ref = "'Something Went Wrong' Please Try Again Later1";
      print('Failed to load profile');
    } finally {
      _isLoading_ref = false;
      notifyListeners();
    }
  }
  Future<void> retrygetReferCodeMsg() async {
    _isLoading_ref = true;
    _hasError_ref = false;
    notifyListeners();
    await getReferCodeMsg();
  }
}