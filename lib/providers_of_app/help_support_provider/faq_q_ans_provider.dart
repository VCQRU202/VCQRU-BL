import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/helpsupport/help_sub_model.dart';
import '../../res/api_url/api_url.dart';

class FAQProvider with ChangeNotifier {
  final _api = RepositoriesApp();
  HelpSubAnsModel? _helpData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  HelpSubAnsModel? get helpData => _helpData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  // A list to store the FAQ data
  List<Map<String, dynamic>> _faqList = [];
  List<bool> _isExpanded = [];

  // Getter for faqList
  List<Map<String, dynamic>> get faqList => _faqList;

  // Getter for isExpanded
  List<bool> get isExpanded => _isExpanded;



  // Method to toggle expansion for a specific FAQ
  void toggleExpansion(int index) {
    _isExpanded[index] = !_isExpanded[index];
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  Future<void> gethelpSubQandAns(subId) async {
    _isLoading = true;
    _hasError = false;
    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
      "id":subId
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.HELP_SUPPORT_SUB);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        // Assign the fetched data to _faqList
        _faqList = List<Map<String, dynamic>>.from(response['data']);

        // Initialize the expansion state (all items are collapsed initially)
        _isExpanded = List<bool>.filled(_faqList.length, false);

        notifyListeners();
        _helpData=HelpSubAnsModel.fromJson(response);
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
  Future<void> retrygethelpsupport(subId) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await gethelpSubQandAns(subId);
  }
}