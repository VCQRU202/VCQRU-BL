import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../data/network_services/network_api_services.dart';
import '../../res/app_colors/Checksun_encry.dart';

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
  // Multipart Request for File Upload
  Future<dynamic> multipartRequest(Map<String, String> fields, List<File> files, String directory, String url) async {
    dynamic responseJson;

    // Check for internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      toastRedC("No internet connection");
      return;
    }
    print(url);
    Dio dio = Dio();

    try {
      // Prepare form data (fields and files)
      List<MultipartFile> multipartFiles = files.map((file) {
        return MultipartFile.fromFileSync(file.path, filename: file.path.split('/').last);
      }).toList();

      FormData formData = FormData.fromMap({
        ...fields, // Adding regular form fields
        directory: multipartFiles, // Adding files under the specified directory key
      });

      // Perform the POST request with multipart data
      final response = await dio.post(url, data: formData).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return Future.error("TimeOut");
        },
      );

      responseJson = jsonDecode(response.toString());
      print(responseJson);
    } on DioError catch (e) {
      print("DioError: ${e.toString()}");
      print("Response: ${e.response?.data}");
      responseJson = e.response?.data;
    }

    return responseJson;
  }

}