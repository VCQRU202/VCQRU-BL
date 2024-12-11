import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';

class SplashScreenProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  final Dio dio = Dio();
  bool _canUpdate = false;
  String _currentVersion = '';
  String _newVersion = '';
  String _appURL = '';
  String _errorMessage = '';
  String logoUrl = '';
  String _productImage = '';
  String _companyName = '';
  String backgroundUrl = '';
  bool isLoading = true;
  String errorMessageSpla = '';


  String get productImage => _productImage;
  String get companyName => _companyName;
  bool _isloaing_brand = false;
  bool _hasError_brand = false;
  String _errorMessage_brand = '';
  bool get isloading_brand => _isloaing_brand;
  bool get hasError_brand => _hasError_brand;
  String get errorMessage_brand => _errorMessage_brand;
  bool get canUpdate => _canUpdate;
  String get currentVersion => _currentVersion;
  String get newVersion => _newVersion;
  String get appURL => _appURL;
  String get errorMessage => _errorMessage;
  String get logoUrlF => logoUrl;
  Color _color = Colors.grey; // Default color
  List<Color> _gradientColors = []; // List to hold multiple colors for gradient

  // Getter for single color
  Color get color_bg => _color;

  // Getter for gradient colors
  List<Color> get gradientColors => _gradientColors;

  // Method to update a single color
  void updateColor(String hexColor) {
    _color = _colorFromHex(hexColor);
    _gradientColors.clear(); // Clear gradient if changing to a single color
    notifyListeners();
  }

  // Method to update a gradient (multiple colors)
  void updateGradientColors(List<String> hexColors) {
    _gradientColors = hexColors.map((color) => _colorFromHex(color)).toList();
    _color = Colors.transparent; // Set color to transparent to show gradient
    notifyListeners();
  }

  // Convert hex string to Color
  Color _colorFromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF' + hex; // Add full opacity if not provided
    }
    return Color(int.parse('0x$hex'));
  }
  Future checkLoginStatus() async{
    var status=await SharedPrefHelper().getWithDefault("Verify", false)??false;
    return status;
  }
  // Future<void> checkForUpdates() async {
  //   final _checker = AppVersionChecker();
  //   final result = await _checker.checkUpdate();
  //
  //   _canUpdate = result.canUpdate;
  //   _currentVersion = result.currentVersion;
  //   _newVersion = result.newVersion??"";
  //   _appURL = result.appURL??"";
  //   _errorMessage = result.errorMessage??"";
  //   print(_canUpdate);
  //   print(_currentVersion);
  //   print(_newVersion);
  //   print(_appURL);
  //   print(_errorMessage);
  //   notifyListeners();
  // }
// Fetch the logo and background image URLs from the API
  Future<dynamic> getBrandSettingData() async {
    _isloaing_brand = true;
    _hasError_brand=false;
    try {
      String result = "VendorAppSetting^VCQRURD092022^"+AppUrl.Comp_ID;
      print(result);
      var re = await sha512Digestfinal(result);
      print("-------" + re);
      Map data = {
        "Comp_ID": AppUrl.Comp_ID,
        "EncData": re
      };
      print(data);
      var value = await _api.postRequest(data,AppUrl.BRAND_SETTING);
      _isloaing_brand = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        if (value['Status']) {
          print("-----------true---");

          logoUrl = value['Data']['CompData']['Logo'] ?? ''; // Set logo URL
          _productImage = value['Data']['CompData']['ProductImage'] ?? ''; // Set logo URL
          _companyName = value['Data']['CompData']['CompName'] ?? ''; // Set logo URL
          print("---URL-------${logoUrl}");

          backgroundUrl = value['Data']['CompData']['BackgroundColor'] ?? '#ffffff';
          if(logoUrl.isNotEmpty&&backgroundUrl.isNotEmpty&&_companyName.isNotEmpty){
            _isloaing_brand = true;
            _hasError_brand = false;
            await SharedPrefHelper().save("CompanyName", _companyName);
             updateColor(backgroundUrl);
            // updateColor("#FF5733");
            //  updateGradientColors("#FF5733");
          }else{
            _isloaing_brand = false;
            _hasError_brand = true;
            _errorMessage_brand ="Data Not Found";
          }
          notifyListeners();
        } else {
          print("-----------false---");
          _isloaing_brand = false;
          _hasError_brand = true;
          _errorMessage_brand =value['message'];
          notifyListeners();
        }
        return value;
      } else {
        print("----error---");
        notifyListeners();
        _isloaing_brand = false;
        _hasError_brand = true;
        _errorMessage_brand = "'Something Went Wrong' Please Try Again Later";
        toastRedC(AppUrl.warningMSG);
        return null;
      }
      // if (value != null) {
      //   print("-----------true---");
      //
      //   logoUrl = value['logo'] ?? ''; // Set logo URL
      //   print("---URL-------${logoUrl}");
      //
      //   backgroundUrl = value['backgroundColor'] ?? '';
      //   if(logoUrl.isNotEmpty&&backgroundUrl.isNotEmpty){
      //     _isloaing_brand = true;
      //     _hasError_brand = false;
      //      updateColor(backgroundUrl);
      //    // updateColor("#FF5733");
      //     //  updateGradientColors("#FF5733");
      //   }else{
      //     _isloaing_brand = false;
      //     _hasError_brand = true;
      //     _errorMessage_brand ="Data Not Found";
      //   }
      //   notifyListeners();
      //   return value;
      // } else {
      //   print("----error---");
      //   notifyListeners();
      //   _isloaing_brand = false;
      //   _hasError_brand = true;
      //   _errorMessage_brand = "'Something Went Wrong' Please Try Again Later";
      //   toastRedC(AppUrl.warningMSG);
      //   return null;
      // }
    } catch (error, stackTrace) {
      print("----error1---");
      _isloaing_brand = false;
      _hasError_brand = true;
      _errorMessage_brand = "'Something Went Wrong' Please Try Again Later";
      notifyListeners();
      return null;
    }finally {
      _isloaing_brand = false;
      notifyListeners();
    }

  }

  Future<void> retryFetchBrandsetting() async {
    await getBrandSettingData();
  }
}