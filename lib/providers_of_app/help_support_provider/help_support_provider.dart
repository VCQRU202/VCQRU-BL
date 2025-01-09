import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';

import '../../models/helpsupport/help_support_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';


class HelpAndSupportProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  HelpSupportModel? _helpData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  HelpSupportModel? get helpData => _helpData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;


  HelpAndSupportProvider() {
    gethelpsupport();
  }

  Future<void> gethelpsupport() async {
    _isLoading = true;
    _hasError = false;
    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.HELP_SUPPORT);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _helpData=HelpSupportModel.fromJson(response);
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
  Future<void> retrygethelpsupport() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await gethelpsupport();
  }
}