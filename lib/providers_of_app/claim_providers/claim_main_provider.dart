import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/claim/claim_confirm_data_model.dart';
import '../../models/claim/claim_main_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';

class CliamMainProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  ClaimMainModel? _historyData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  ClaimMainModel? get historyData => _historyData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;


  CliamMainProvider() {
    getClaimMainData();
  }

  Future<void> getClaimMainData() async {
    _isLoading = true;
    _hasError = false;
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c=m_Consumerid.toString();

    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.CLIAM_MAIN);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _historyData=ClaimMainModel.fromJson(response);
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
  Future<void> retryFetchClaimMainData() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getClaimMainData();
  }
  int? selectedOption; // State variable for selected radio button
  Map<int, bool> subtitleVisibility = {}; // Track visibility of subtitles

  void selectOption(int index) {
    selectedOption = index;
    subtitleVisibility.clear();
    subtitleVisibility[index] = true; // Show only the selected subtitle
    notifyListeners();
  }

  void confirmSelection(BuildContext context, List<String> radioOptions) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Option selected: ${radioOptions[selectedOption!]}'),
      ),
    );
  }
  String? _selectedIconName;


  String? get selectedIconName => _selectedIconName;

  void setSelectedIconName( iconName) {
    _selectedIconName = iconName;

    notifyListeners(); // Notify listeners about the change
  }
  String? _selectedTypeMethod;
  String? get selectedTypeMethod => _selectedTypeMethod;

  void setselectedTypeMethod( tye) {
    _selectedTypeMethod = tye;
    notifyListeners(); // Notify listeners about the change
  }
  ClaimConfirmDataModel? _historyData_confirm;
  bool _isLoading_confirm = false;
  bool _hasError_confirm = false;
  String _errorMessage_confirm = '';

  ClaimConfirmDataModel? get historyData_confirm => _historyData_confirm;
  bool get isLoading_confirm => _isLoading_confirm;
  bool get hasError_confirm => _hasError_confirm;
  String get errorMessage_confirm => _errorMessage_confirm;

  Future<dynamic> getDataForClaimConfirm(type) async {
    _isLoading_confirm = true;
    _hasError_confirm = false;
    notifyListeners();
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c=m_Consumerid.toString();

    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
      "M_Consumerid":m_c.toString(),
      "Gift_type":type,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.CLAIM_CONFIRM_DATA);
      print(response);
      print("-------");
      print(response['success']);
      if(response!=null){
        if (response['success']) {
          print("-----------true---");
          _isLoading_confirm = true;
          _hasError_confirm = false;
          _historyData_confirm=ClaimConfirmDataModel.fromJson(response);
        } else {
          print("-----------false---");
          _isLoading_confirm = false;
          _hasError_confirm = true;
          _errorMessage_confirm =response['message'];
          notifyListeners();
        }
        return response;
      }else{
        return null;
      }
    } catch (error) {
      _isLoading_confirm = false;
      _hasError_confirm = true;
      _errorMessage_confirm = "'Something Went Wrong' Please Try Again Later";
      print('Failed to load profile');
      return null;
    } finally {
      _isLoading_confirm = false;
      notifyListeners();
    }
  }
  Future<void> retryFetchDataForClaimConfirm(type) async {
    _isLoading_confirm = true;
    _hasError_confirm = false;
    notifyListeners();
    await getDataForClaimConfirm(type);
  }

  bool _isLoading_subclaim = false;
  bool _hasError_subclaim = false;
  String _errorMessage_subclaim = '';

  bool get isLoading_subclaim => _isLoading_subclaim;
  bool get hasError_subclaim => _hasError_subclaim;
  String get errorMessage_subclaim => _errorMessage_subclaim;
  Future<dynamic> getSubmitClaimForCash(type,amount) async {
    _isLoading_subclaim = true;
    _hasError_subclaim = false;
    notifyListeners();
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String mobile = await SharedPrefHelper().get("MobileNumber")??"";
    String m_c=m_Consumerid.toString();

    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
      "M_Consumerid":m_c.toString(),
      "MobileNo":mobile.toString(),
      "Claim_Type_Id":type,
      "Ammount":amount,
      "ProductId":"",
      "Productvalue":"",
    };
    print(requestData);
    try {
      final value = await _api.postRequest(requestData, AppUrl.SUBMIT_CLIAM_CASH);
      _isLoading_subclaim = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        return value;
      } else {
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (error) {
      _isLoading_subclaim = false;
      notifyListeners();
      return null;
    }
  }
  // Future<void> reTrySubmitClaimForCash(type) async {
  //   _isLoading_subclaim = true;
  //   _hasError_subclaim = false;
  //   notifyListeners();
  //   await getSubmitClaimForCash(type);
  // }

}
