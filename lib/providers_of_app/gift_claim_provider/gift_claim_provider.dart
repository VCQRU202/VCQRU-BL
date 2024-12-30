
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/gift/gift_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';

class GiftProvider extends ChangeNotifier {
  final _api = RepositoriesApp();
  bool _isloaing_gift = false;
  bool _hasError_gift = false;
  String _errorMessage_gift = '';
  bool get isloading_gift => _isloaing_gift;
  bool get hasError_gift => _hasError_gift;
  String get errorMessage_gift => _errorMessage_gift;
  GiftModel? _gift;
  GiftModel? get gift1 => _gift;
  // final List<Map<String, String>> _gifts = [
  //   {
  //     'image': 'assets/gift_img.png',
  //     'title': 'APPLE iPhone 15',
  //     'description': '(Black, 128 GB), 128 GB ROM',
  //     'price': '965'
  //   },
  //   {
  //     'image': 'assets/gift_img.png',
  //     'title': 'Apple 2024',
  //     'description': 'MacBook Pro',
  //     'price': '965'
  //   },
  //   {
  //     'image': 'assets/gift_img.png',
  //     'title': 'BAJAJ Freedom',
  //     'description': 'CNG',
  //     'price': '965'
  //   },
  //   {
  //     'image': 'assets/gift_img.png',
  //     'title': 'Apple 2024',
  //     'description': 'MacBook Pro',
  //     'price': '965'
  //   },
  // ];
  //
  // List<Map<String, String>> get gifts => _gifts;


  Future<dynamic> getGift() async {
    _isloaing_gift = true;
    _hasError_gift=false;
    try {
      var mConsumerid = await SharedPrefHelper().get("M_Consumerid");
      String mt=mConsumerid.toString();
      Map data ={
        "Comp_ID":AppUrl.Comp_ID,
        "M_Consumerid":mt
      };
      print(data);
      var value = await _api.postRequest(data,AppUrl.GIFTLIST);
      _isloaing_gift = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        if (value['success']) {
          _gift=GiftModel.fromJson(value);
          notifyListeners();
        } else {
          print("-----------false---");
          _isloaing_gift= false;
          _hasError_gift = true;
          _errorMessage_gift =value['message'];
          notifyListeners();
        }
        return value;
      } else {
        print("----error---");
        notifyListeners();
        _isloaing_gift = false;
        _hasError_gift = true;
        _errorMessage_gift = "'Something Went Wrong' Please Try Again Later";
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (error, stackTrace) {
      print("----error1---");
      _isloaing_gift = false;
      _hasError_gift = true;
      _errorMessage_gift = "'Something Went Wrong' Please Try Again Later";
      notifyListeners();
      return null;
    }finally {
      _isloaing_gift = false;
      notifyListeners();
    }

  }
  Future<void> retryGift() async {
    notifyListeners();
    await getGift();
  }


  bool _isloaing_claim = false;
  bool get isloaing_claim  => _isloaing_claim ;

  Future<dynamic> submitClaim(serviId,productId,ProductV) async {
    _isloaing_claim  = true;
    notifyListeners();
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c=m_Consumerid.toString();
    Map data = {
      "M_Consumerid": m_c,
      "Comp_ID": AppUrl.Comp_ID,
      "ServiceId": "SRV1001",
      "ProductId": productId.toString(),
      "Productvalue": ProductV.toString(),
       "UPIId": "",
    };
    print(data.toString());
    try {
      var value = await _api.postRequest(data,AppUrl.SUBMIT_CLAIM);
      _isloaing_claim  = false;
      notifyListeners();
      log(value.toString());
      if (value != null) {
        return value;
      } else {
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (error, stackTrace) {
      _isloaing_claim  = false;
      notifyListeners();
      return null;
    }
  }
}