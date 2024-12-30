import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/intro/introduction_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';

class SliderProvider with ChangeNotifier {


  final _api = RepositoriesApp();
  List<IntroData> _introData = [];
  List<IntroData> get introData => _introData;
  bool _isloaing_brand = false;
  bool _hasError_brand = false;
  String _errorMessage_brand = '';
  bool get isloading_brand => _isloaing_brand;
  bool get hasError_brand => _hasError_brand;
  String get errorMessage_brand => _errorMessage_brand;
  int _index = 0;
  // final List<Color> _colors = [
  //   Color(0xFFFFDCA9),
  //   Color(0xFFCDF0EA),
  //   Color(0xFFFFE6E6)
  // ];
  // final List<String> _textsTitle = [
  //   "Anti Counterfeit",
  //   "Build Loyalty",
  //   "E-Warranty"
  // ];
  // final List<String> _texts = [
  //   "Counterfeit products have far-reaching consequences for both brands and consumers.",
  //   "Building customer loyalty is the most challenging thing that most businesses face nowadays.",
  //   "E-warranty services simplify the warranty claim process for customers, manufacturers, & retailers."
  // ];

  int get index => _index;
  String get title => _introData[_index].header??"";
  String get description => _introData[_index].contains??"";
  String get image => _introData[_index].imagePath??"";

  void nextSlide() {
    if (_introData.isNotEmpty) {
      _index = (_index + 1) % _introData.length;
      notifyListeners();
    }
  }

  void startSlider() {
    if (_introData.isNotEmpty) {
      Timer.periodic(Duration(seconds: 3), (timer) {
        nextSlide();
      });
    }
  }
  Future<void> getIntruc() async {
    _isloaing_brand = true;
    _hasError_brand = false;
    try {
      Map data = {
        "Comp_ID": AppUrl.Comp_ID,
      };
      print(data);
      var value = await _api.postRequest(data, AppUrl.INTRODUCTION);
      _isloaing_brand = false;
      if (value != null && value['success']) {
        _introData = (value['data'] as List)
            .map((item) => IntroData.fromJson(item))
            .toList();
        notifyListeners();
      } else {
        _hasError_brand = true;
        _errorMessage_brand = value?['message'] ??
            "'Something Went Wrong' Please Try Again Later";
        toastRedC(_errorMessage_brand);
      }
    } catch (error) {
      print("Error: $error");
      _isloaing_brand = false;
      _hasError_brand = true;
      _errorMessage_brand =
      "'Something Went Wrong' Please Try Again Later";
      toastRedC(_errorMessage_brand);
    } finally {
      _isloaing_brand = false;
      notifyListeners();
    }
  }


  Future<void> retryFetchIntruc() async {
    await getIntruc();
    notifyListeners();
  }

}
