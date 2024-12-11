import 'package:flutter/material.dart';

import '../../data/network_services/network_api_services.dart';

class RepositoriesApp{
  final _apiServices=NetworkApiServices();

  Future<dynamic> sendOTP(data,url) async{
    print(url);
    final response=await _apiServices.postAPI(data, url);
    return response;
  }

  Future<dynamic> verifyOTP(var data,url) async{
    print(url);
    final response=await _apiServices.postAPI(data,url);
    return response;
  }

  Future<dynamic> getListState(url) async{
    print(url);
    final response=await _apiServices.getAPI(url);
    return response;
  }

  Future<dynamic> postRequest(var data,url) async{
    print(url);
    final response=await _apiServices.postAPI(data,url);
    return response;
  }

}