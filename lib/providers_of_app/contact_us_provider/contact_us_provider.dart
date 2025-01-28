import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/code_check_history/code_check_history_model.dart';
import '../../models/contact/contact_us_model.dart';
import '../../res/api_url/api_url.dart';
class ContactDetailsProvider with ChangeNotifier {
  final _api = RepositoriesApp();
  ContactUsModel? _historyContact;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  ContactUsModel? get historyContact => _historyContact;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;


  ContactDetailsProvider() {
    getContactHistory();
  }

  Future<void> getContactHistory() async {
    _isLoading = true;
    _hasError = false;
    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.CONTACT_US);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _historyContact=ContactUsModel.fromJson(response);
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
  Future<void> retryFetchContact() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getContactHistory();
  }
}