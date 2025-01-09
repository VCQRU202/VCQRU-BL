import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';

import '../../models/product_cat_model/product_cat_details_model.dart';
import '../../models/product_cat_model/product_cat_log_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';

class ProductCatListProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  ProductCatListModel? _productListData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  ProductCatListModel? get productListData => _productListData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  ProductCatDetailModel? _productDetailData;
  bool _isLoading_detail = true;
  bool _hasError_detail = false;
  String _errorMessage_detail = '';

  ProductCatDetailModel? get productDetailData => _productDetailData;
  bool get isLoading_detail => _isLoading_detail;
  bool get hasError_detail => _hasError_detail;
  String get errorMessage_detail => _errorMessage_detail;


  ProductCatListProvider() {
    getproductList();
  }

  Future<void> getproductList() async {
    _isLoading = true;
    _hasError = false;
    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.PRODUCT_CAT_LIST);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _productListData=ProductCatListModel.fromJson(response);
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
  Future<void> retrygetNotificationList() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getproductList();
  }

  Future<void> getproductDetailList(prodID) async {
    _isLoading_detail = true;
    _hasError_detail = false;
    Map requestData = {
      "Comp_id":AppUrl.Comp_ID,
      "Productid":prodID,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.PRODUCT_CAT_DETAILS);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading_detail = true;
        _hasError_detail = false;
        _productDetailData=ProductCatDetailModel.fromJson(response);
      } else {
        print("-----------false---");
        _isLoading_detail = false;
        _hasError_detail = true;
        _errorMessage_detail =response['message'];
        notifyListeners();
      }
    } catch (error) {
      _isLoading_detail = false;
      _hasError_detail = true;
      _errorMessage_detail = "'Something Went Wrong' Please Try Again Later1";
      print('Failed to load profile');
    } finally {
      _isLoading_detail = false;
      notifyListeners();
    }
  }
  Future<void> retrygetDetailList(product) async {
    _isLoading_detail = true;
    _hasError_detail = false;
    notifyListeners();
    await getproductDetailList(product);
  }
}