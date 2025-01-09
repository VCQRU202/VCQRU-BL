import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/notifications/notification_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';
//
// class NotificationsProvider with ChangeNotifier{
//   final _api = RepositoriesApp();
//   NotificationModel? _notifiData;
//   bool _isLoading = true;
//   bool _hasError = false;
//   String _errorMessage = '';
//
//   NotificationModel? get notifiData => _notifiData;
//   bool get isLoading => _isLoading;
//   bool get hasError => _hasError;
//   String get errorMessage => _errorMessage;
//
//
//   NotificationsProvider() {
//     getNotificationList();
//   }
//
//   Future<void> getNotificationList() async {
//     _isLoading = true;
//     _hasError = false;
//     var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
//     String m_c=m_Consumerid.toString();
//
//     Map requestData = {
//       "Comp_ID":AppUrl.Comp_ID,
//       "M_Consumerid":m_c,
//     };
//     print(requestData);
//     try {
//       final response = await _api.postRequest(requestData, AppUrl.NOTIFICATIONS);
//       print(response);
//       print("-------");
//       print(response['success']);
//       if (response['success']) {
//         print("-----------true---");
//         _isLoading = true;
//         _hasError = false;
//         _notifiData=NotificationModel.fromJson(response);
//       } else {
//         print("-----------false---");
//         _isLoading = false;
//         _hasError = true;
//         _errorMessage =response['message'];
//         notifyListeners();
//       }
//     } catch (error) {
//       _isLoading = false;
//       _hasError = true;
//       _errorMessage = "'Something Went Wrong' Please Try Again Later1";
//       print('Failed to load profile');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//   Future<void> retrygetNotificationList() async {
//     _isLoading = true;
//     _hasError = false;
//     notifyListeners();
//     await getNotificationList();
//   }
// }

import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/notifications/notification_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';

class NotificationsProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  NotificationModel? _notifiData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  NotificationModel? get notifiData => _notifiData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;


  NotificationsProvider() {
    getNotificationList();
  }



  //
  // Future<void> getNotificationList() async {
  //   _isLoading = true;
  //   _hasError = false;
  //   var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
  //   String m_c=m_Consumerid.toString();
  //
  //   Map requestData = {
  //     "Comp_ID":AppUrl.Comp_ID,
  //     "M_Consumerid":m_c,
  //   };
  //   print(requestData);
  //   try {
  //     final response = await _api.postRequest(requestData, AppUrl.NOTIFICATIONS);
  //     print(response);
  //     print("-------");
  //     print(response['success']);
  //     if (response['success']) {
  //       print("-----------true---");
  //       _isLoading = true;
  //       _hasError = false;
  //       _notifiData=NotificationModel.fromJson(response);
  //     } else {
  //       print("-----------false---");
  //       _isLoading = false;
  //       _hasError = true;
  //       _errorMessage =response['message'];
  //       notifyListeners();
  //     }
  //   } catch (error) {
  //     _isLoading = false;
  //     _hasError = true;
  //     _errorMessage = "'Something Went Wrong' Please Try Again Later1";
  //     print('Failed to load profile');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> getNotificationList() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
      String m_c = m_Consumerid.toString();

      Map requestData = {
        "Comp_ID": AppUrl.Comp_ID,
        "M_Consumerid": m_c,
      };

      print("Request Data: $requestData");

      final response = await _api.postRequest(requestData, AppUrl.NOTIFICATIONS);
      print("Response: $response");

      if (response['success']) {
        _isLoading = false;
        _hasError = false;
        _notifiData = NotificationModel.fromJson(response);
      } else {
        _isLoading = false;
        _hasError = true;
        _errorMessage = response['message'] ?? 'An unknown error occurred';
        print("API Error: $_errorMessage");
      }
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = "Something went wrong. Please try again later. Error: $error";
      print("Exception: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retrygetNotificationList() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getNotificationList();
  }
}