import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/repositorys/repositories_app.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/shared_preferences.dart';

class AccountVerifyProvider extends ChangeNotifier {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController reenterAccountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();

  // Dispose controllers to free up resources
  @override
  void dispose() {
    accountNumberController.dispose();
    reenterAccountNumberController.dispose();
    bankNameController.dispose();
    accountHolderController.dispose();
    ifscCodeController.dispose();
    super.dispose();
  }
  void clearData(){
    accountNumberController.clear();
    reenterAccountNumberController.clear();
    bankNameController.clear();
    accountHolderController.clear();
    ifscCodeController.clear();
  }

  final _api = RepositoriesApp();
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  // Getters for state
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  bool _isLoading_ifsc = false;
  bool _hasError_ifsc = false;
  String _errorMessage_ifsc = '';

  // Getters for state
  bool get isLoading_ifsc => _isLoading_ifsc;
  bool get hasError_ifsc => _hasError_ifsc;
  String get errorMessage_ifsc => _errorMessage_ifsc;

  AccountVerifyProvider() {
    // Auto-fill account holder name on initialization
    loadAccountHolderName();
  }

  // Load Account Holder Name
  Future<void> loadAccountHolderName() async {
    try {
      String? savedName = await SharedPrefHelper().get("Name");
      if (savedName != null && savedName.isNotEmpty) {
        accountHolderController.text = savedName;
        print("------${savedName}--------");// Auto-fill
      }
    } catch (e) {
      print('Failed to load account holder name: $e');
    }
    notifyListeners(); // Notify the UI
  }

  // API Call for Account Verification
  Future<dynamic> verifyAccount({required String account, required String name, required String bankname, required String ifsc,}) async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      String mConsumerid = await SharedPrefHelper().get("M_Consumerid")??"";
      Map data = {
        "AccountNo": account,
        "IFSCCode": ifsc,
        "AccountHolderName": name,
        "BankName": bankname,
        "UserNameForValidatePan": "",
        "M_Consumerid": mConsumerid
      };
      print(data);
      final value = await _api.postRequest(data,AppUrl.BANK_ACCOUNT_VERIFY);
      _isLoading = false;
      log(value.toString());
      if (value != null) {
        return value;
      } else {
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  // API Call for IFSC code Verification
  Future<dynamic> verifyIfsc({required String ifsc}) async {
    _isLoading_ifsc = true;
    _hasError_ifsc = false;
    _errorMessage_ifsc = '';
    notifyListeners();

    try {
      Map data = {
        "ifsccode": ifsc,
      };
      print(data);
      final value = await _api.postRequest(data,AppUrl.IFSC_CODE_GET);
      _isLoading_ifsc = false;
      log(value.toString());
      if (value != null && value['success'] == true) {
        // Parse the response
        final bankData = value['data'];
        if (bankData != null) {
          // Auto-fill the bank name
          toastRedC("Fetch Bank Name");
          bankNameController.text = bankData['bank'] ?? "";
          notifyListeners(); // Notify UI about the update
        }
      } else {
        bankNameController.text="";
        toastRedC(value['message'] ?? "Data Not found");
      }
    } catch (e) {
      _hasError_ifsc = true;
      _errorMessage_ifsc = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading_ifsc = false;
      notifyListeners();
    }
  }
}
