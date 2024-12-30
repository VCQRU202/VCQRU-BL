import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/code_check_history/code_check_history_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';


class CodeCheckHistoryProvider with ChangeNotifier{
  final _api = RepositoriesApp();
  CodeheckHistoryModel? _historyData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  CodeheckHistoryModel? get historyData => _historyData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;


  CodeCheckHistoryProvider() {
    getCodeCheckHistory();
  }

  Future<void> getCodeCheckHistory() async {
    _isLoading = true;
    _hasError = false;
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c=m_Consumerid.toString();

    Map requestData = {
      "Comp_ID":AppUrl.Comp_ID,
      "M_Consumerid":m_c,
      "limit":"Full",
    };
    print(requestData);
    try {
      final response = await _api.postRequest(requestData, AppUrl.CODE_HISTORY);
      print(response);
      print("-------");
      print(response['success']);
      if (response['success']) {
        print("-----------true---");
        _isLoading = true;
        _hasError = false;
        _historyData=CodeheckHistoryModel.fromJson(response);
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
  Future<void> retryFetchProfile() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getCodeCheckHistory();
  }
}