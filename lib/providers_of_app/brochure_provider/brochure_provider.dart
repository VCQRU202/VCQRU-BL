import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';

import '../../models/brochure_model/brochure_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';


class BochureProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  BochureModel? _brochureData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  BochureModel? get brochureData => _brochureData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;


  BochureProvider() {
    getBochureProvider();
  }

  Future<void> getBochureProvider() async {
    _isLoading = true;
    _hasError = false;
    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.BROCHURE);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _brochureData=BochureModel.fromJson(response);
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
  Future<void> retryBochureProvider() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getBochureProvider();
  }
}