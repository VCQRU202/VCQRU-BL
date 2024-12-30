import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/profile/profile_detail_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';
class ProfileProvider with ChangeNotifier{

  final _api = RepositoriesApp();
  ProfileDetailModel? _historyProfile;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  ProfileDetailModel? get historyProfile => _historyProfile;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  Future<void> getProfileDetail() async {
    _isLoading = true;
    _hasError = false;
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String mobile = await SharedPrefHelper().get("MobileNumber")??"";
    String m_c=m_Consumerid.toString();

    Map requestData = {
      "Comp_id":AppUrl.Comp_ID,
      "M_Consumerid":m_c,
      "Mobileno":mobile.toString(),
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.GETPROFILE_DETAIL);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _historyProfile=ProfileDetailModel.fromJson(response);
      } else {
        print("-----------false---");
        _isLoading = false;
        _hasError = true;
        _errorMessage =response['message'];
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
  Future<void> retryFetchProfileDetail() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getProfileDetail();
  }

}