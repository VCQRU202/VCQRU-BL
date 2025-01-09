import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/raised_model/raised_ticket_his_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';

// class RaisedTicketHistoryProvider with ChangeNotifier {
//
//   final _api = RepositoriesApp();
//   RaisedTicketHistoryModel? _helpData;
//   bool _isLoading = true;
//   bool _hasError = false;
//   String _errorMessage = '';
//
//   RaisedTicketHistoryModel? get helpData => _helpData;
//   bool get isLoading => _isLoading;
//   bool get hasError => _hasError;
//   String get errorMessage => _errorMessage;
//
//   Future<void> getRaisedHistory() async {
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
//       final response = await _api.postRequest(requestData, AppUrl.RAISED_HISTORY);
//       print(response);
//       print("-------");
//       print(response['success']);
//       if (response['success']) {
//         print("-----------true---");
//         _isLoading = true;
//         _hasError = false;
//         // // Assign the fetched data to _faqList
//         // _faqList = List<Map<String, dynamic>>.from(response['data']);
//         //
//         // // Initialize the expansion state (all items are collapsed initially)
//         // _isExpanded = List<bool>.filled(_faqList.length, false);
//
//         notifyListeners();
//         _helpData=RaisedTicketHistoryModel.fromJson(response);
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
//   Future<void> retrygetRaisedHistory() async {
//     _isLoading = true;
//     _hasError = false;
//     notifyListeners();
//     await getRaisedHistory();
//   }
// }


class RaisedTicketHistoryProvider with ChangeNotifier {
  final _api = RepositoriesApp();
  RaisedTicketHistoryModel? _helpData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  int _expandedIndex = -1; // To track the expanded index (-1 means none expanded)

  RaisedTicketHistoryModel? get helpData => _helpData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  int get expandedIndex => _expandedIndex; // Getter for expanded index

  // Method to set the expanded index
  void setExpandedIndex(int index) {
    if (_expandedIndex == index) {
      _expandedIndex = -1; // Collapse if the same item is clicked again
    } else {
      _expandedIndex = index; // Expand the clicked item
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  Future<void> getRaisedHistory() async {
    _isLoading = true;
    _hasError = false;

    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c = m_Consumerid.toString();

    Map requestData = {
      "Comp_ID": AppUrl.Comp_ID,
      "M_Consumerid": m_c,
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.RAISED_HISTORY);
      print(response);

      if (response['success']) {
        _isLoading = false;
        _hasError = false;

        // Parse response into data model
        _helpData = RaisedTicketHistoryModel.fromJson(response);

        notifyListeners();
      } else {
        _isLoading = false;
        _hasError = true;
        _errorMessage = response['message'];
        notifyListeners();
      }
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = "'Something Went Wrong' Please Try Again Later!";
      print('Failed to load data: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retrygetRaisedHistory() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getRaisedHistory();
  }
}
