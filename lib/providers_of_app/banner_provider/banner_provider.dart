import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/banner/banner_model.dart';
import '../../res/api_url/api_url.dart';

class BannerProvider with ChangeNotifier{
  final _api=RepositoriesApp();
  BannerModel? _bannerModel;
  bool _isLoading = true;
  bool _isloaing = false;
  bool _hasError = false;
  String _errorMessage = '';

  BannerModel? get bannerModel => _bannerModel;
  bool get isLoading => _isLoading;
  bool get isloaing => _isloaing;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> getBanner() async {
    _isLoading = true;
    _hasError = false;
    Map requestData = {"Comp_id": AppUrl.Comp_ID};
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.BANNER);
      print(response);
      print("---banner list----");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _bannerModel=BannerModel.fromJson(response);
        notifyListeners();
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
      _errorMessage = "'Something Went Wrong' Please Try Again Later";
      notifyListeners();
      print('Failed to load profile');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> retryBanner() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getBanner();
  }
}