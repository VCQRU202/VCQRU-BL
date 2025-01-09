import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import 'package:http/http.dart' as http;

import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';
class EditProfileProvider extends ChangeNotifier {
  final _api = RepositoriesApp();
  bool _isLoadingForm = false;
  bool _hasErrorForm = false;
  String _errorMessageForm = '';
  bool get isLoadingForm => _isLoadingForm;
  bool get hasErrorForm => _hasErrorForm;
  String get errorMessageForm => _errorMessageForm;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<dynamic> _formFields = [];
  Map<String, dynamic> _formData = {};

  List<dynamic> get formFields => _formFields;
  Map<String, dynamic> get formData => _formData;

  bool isPasswordVisible = false;

  bool _isLoadingPan = false;
  bool _hasErrorPan = false;
  String _errorMessagePan = '';
  bool _isVerificationSuccessful = false;

  // Getters for state
  bool get isLoadingPan => _isLoadingPan;
  bool get hasErrorPan => _hasErrorPan;
  String get errorMessagePan => _errorMessagePan;
  bool get isVerificationSuccessful => _isVerificationSuccessful;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
  void setFormFields(List<Map<String, dynamic>> fields) {
    _formFields = fields;
    // Initialize formData with pre-filled data
    for (var field in fields) {
      _formData[field['label']] = field['data'] ?? '';
    }
    notifyListeners();
  }
  // Fetch form fields from the API
  Future<void> fetchFormFields() async {
    _isLoadingForm = true;
    _hasErrorForm = false;
    _errorMessageForm = '';
    _formFields = [];
    _formData = {};
    notifyListeners();

    try {
      // API call
      var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
      String mobile = await SharedPrefHelper().get("MobileNumber")??"";
      String m_c=m_Consumerid.toString();
      Map data1 = {
        "Comp_id":AppUrl.Comp_ID,
        "Mobileno":mobile.toString(),
        "M_consumerid":m_c
      };
      print(data1);
      var value = await _api.postRequest(data1,AppUrl.GETPROFILE_DETAIL);

      if (value['success'] == true && value['data'] != null) {
        print("---details fetch");
        // Parse fields
        // _formFields = List<Map<String, dynamic>>.from(value['data'].map((field) {
        //   return {
        //     "type": field['fieldType'] == "text"
        //         ? "text"
        //         : field['fieldType'] == "Radio"
        //         ? "radio"
        //         : field['fieldType'] == "Dropdown"
        //         ? "dropdown"
        //         : field['fieldType'],
        //     "label": field['fieldName'],
        //     "hint": field['hint'] ?? '',
        //     "optional": !(field['isMandatory'] ?? true),
        //     "regex": field['Regex'],
        //     "data": field['data'] ?? '',
        //     "options": field['fieldType'] == "Dropdown" || field['fieldType'] == "Radio"
        //         ? field['values'] ?? ["option1","Option2"] // Use actual options from the API
        //         : null,
        //   };
        // }));
        setFormFields(List<Map<String, dynamic>>.from(value['data'].map((field) {
          return {
          "type": field['fieldType'] == "text"
                  ? "text"
                  : field['fieldType'] == "Radio"
                  ? "radio"
                  : field['fieldType'] == "Dropdown"
                  ? "dropdown"
                  : field['fieldType'],
            "label": field['fieldName'] ?? "",
            "label1": field['lableName'] ?? "",
            "hint": field['hint'] ?? '',
            "optional": !(field['isMandatory'] ?? true),
            "regex": field['Regex'] ?? null,
            "data": field['data'] ?? '',
            "value": field['data'] ?? '',
            "options": (field['fieldType'] == "Dropdown" || field['fieldType'] == "Radio")
                ? field['values'] ?? []
                : null,
          };
        })));
      } else {
        _hasErrorForm = true;
        _errorMessageForm = value['message'] ?? 'Invalid data received.';
      }
    } catch (e) {
      _hasErrorForm = true;
      _errorMessageForm = 'Error fetching form fields';
      print('Error: $e');
    } finally {
      _isLoadingForm = false;
      notifyListeners();
    }
  }
  Future<void> retryFetchfetchFormFields() async {
    await fetchFormFields();
  }
  // Reset state
  void resetState() {
    _isLoadingForm = false;
    _hasErrorForm = false;
    _errorMessageForm = '';
    _formFields = [];
    notifyListeners();
  }

  void updateFormData(String key, dynamic value) {
    _formData[key] = value;
    notifyListeners();
  }

  // Fetch location details based on pincode
  Future<void> fetchLocationDetails(String pincode) async {
    final url = 'https://vrkableuat.vcqru.com/api/Postalcode?pincode=$pincode';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        if (data['Status']) {
          var data1 = data['Data'];
          if(data1!=null){
            var location = data['Data'][0];
            String city = location['Division'];
            String state = location['State'];
            String district = location['District'];
            // Update the provider with fetched location data
            _formData['City'] = city;
            _formData['State'] = state;
            _formData['district'] = district;
            notifyListeners();
          }else{
            toastRedC("Data not found");
            _formData['City'] = "";
            _formData['State'] = "";
            _formData['district'] = "";
            _formData['PinCode'] = "";
            notifyListeners();
          }
          // Notify listeners to update UI
        } else {

          print('Failed to fetch valid location data');
        }
      } else {
        print('Failed to fetch location data');
      }
    } catch (e) {
      print('Error fetching location data: $e');
    }
  }
  Future<dynamic> submitForm(String request) async {
    _isLoadingPan = true;
    _hasErrorPan = false;
    _errorMessagePan = '';
    notifyListeners();

    try {
      // Make API call
      var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
      String m_c=m_Consumerid.toString();
      Map data = {
        "Request": request,
        "Comp_id": AppUrl.Comp_ID,
        "M_Consumerid": m_c,
      };
      print(data);
      final value = await _api.postRequest(data,AppUrl.UPDATE_PROFILE);
      _isLoadingPan = false;
      log(value.toString());
      if (value != null) {
        return value;
      } else {
        toastRedC(AppUrl.warningMSG);
        return null;
      }
    } catch (e, stackTrace) {
      // Handle exceptions
      _hasErrorPan = true;
      _errorMessagePan = "Something went wrong. Please try again later.";
      print("Error submitting form:");
      print("Stack Trace: $stackTrace");
    } finally {
      _isLoadingPan = false;
      notifyListeners();
    }
  }
}