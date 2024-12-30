import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../../res/toast_msg/toast_msg.dart';
import 'base_api_network_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future postAPI(var data, String url) async {
    dynamic responseJson;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      toastRedC("No internet connection");
      return;
    }
    Dio dio = Dio();
    try {
      final response = await dio.post(url, data: data).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return Future.error("TimeOut");
        },
      );
      responseJson = jsonDecode(response.toString());
      print(responseJson);
    } on DioError catch (e) {
    print(e.toString());
    print("DioError: ${e.response?.data}");
    responseJson=e.response?.data;
    }
    return responseJson;
  }
  @override
  Future getAPI( String url) async {
    dynamic responseJson;
    Dio dio = Dio();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      toastRedC("No internet connection");
      return;
    }
    try {
      final response = await dio.get(url).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return Future.error("TimeOut");
        },
      );
      responseJson = jsonDecode(response.toString());
      print(responseJson);
    } on DioError catch (e) {
      print(e.toString());
      print("DioError: ${e.response?.data}");
      responseJson=e.response?.data;
    }
    return responseJson;
  }
  // New method for Multipart Request
  Future multipartRequest(Map<String, String> fields, List<FormData> files, String directory, String url) async {
    dynamic responseJson;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      toastRedC("No internet connection");
      return;
    }

    Dio dio = Dio();
    try {
      // Prepare form data with fields and files
      FormData formData = FormData.fromMap({
        ...fields, // Add regular form fields
        directory: files, // Add file data as a list under a specific directory
      });

      final response = await dio.post(url, data: formData).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return Future.error("TimeOut");
        },
      );
      responseJson = jsonDecode(response.toString());
      print(responseJson);
    } on DioError catch (e) {
      print(e.toString());
      print("DioError: ${e.response?.data}");
      responseJson = e.response?.data;
    }
    return responseJson;
  }
}
