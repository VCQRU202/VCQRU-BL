import 'package:flutter/material.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/claim/claim_history_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';
 // Import your service file

class ClaimHistoryProvider with ChangeNotifier {
  final _api = RepositoriesApp();
  ClaimHistoryModel? _historyData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  int? _currentFilter; // Filter status (null = all, 0 = pending, 1 = approved, 2 = rejected)
  List<ClaimData> _claims = [];
  List<ClaimData> _filteredClaims = [];

  // Getters
  ClaimHistoryModel? get historyData => _historyData;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  List<ClaimData> get claims => _claims;
  List<ClaimData> get filteredClaims => _filteredClaims;
  int? get currentFilter => _currentFilter;

  ClaimHistoryProvider() {
    getClaimHistory(true);
  }

  // Set claims and apply the current filter
  void setClaims(List<ClaimData> claims) {
    _claims = claims;
    _applyFilter();
    notifyListeners();
  }

  // Apply the filter to update _filteredClaims
  void applyFilter(int? status) {
    _currentFilter = status;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_currentFilter == null) {
      _filteredClaims = _claims;
    } else {
      _filteredClaims = _claims.where((claim) => claim.isapproved == _currentFilter).toList();
    }
  }

  // Fetch data from the API
  Future<void> getClaimHistory(valu) async {
    _isLoading = true;
    _hasError = false;
    if(valu){
      notifyListeners();
    }
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c = m_Consumerid.toString();

    Map requestData = {
      "Comp_ID": AppUrl.Comp_ID,
      "M_Consumerid": m_c,
    };

    try {
      final response = await _api.postRequest(requestData, AppUrl.CLAIM_HISTORY);
      if (response['success']) {
        _isLoading = false;
        _hasError = false;
        _historyData = ClaimHistoryModel.fromJson(response);
        setClaims(_historyData?.data ?? []);
      } else {
        _isLoading = false;
        _hasError = true;
        _errorMessage = response['message'];
      }
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = "'Something Went Wrong' Please Try Again Later!";
    } finally {
      notifyListeners();
    }
  }

  Future<void> retryFetchClaimHistory() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    await getClaimHistory(true);
  }
}

