import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class RegistrationFormProvider extends ChangeNotifier {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   List<dynamic> _formFields = [];
//   Map<String, dynamic> _formData = {};
//
//   List<dynamic> get formFields => _formFields;
//   Map<String, dynamic> get formData => _formData;
//   bool isPasswordVisible = false;
//   void togglePasswordVisibility() {
//     isPasswordVisible = !isPasswordVisible;
//     notifyListeners(); // if using Provider
//     // if using StatefulWidget
//   }
//
//
//   // Update fields based on Pincode API response
//   Future<void> fetchFormFields() async {
//     _formFields = [
//       {
//         "type": "text",
//         "label": "Name",
//         "hint": "Enter your name",
//         "optional": false,
//         "regex": "^[a-zA-Z ]+\$"
//       },
//       {
//         "type": "text",
//         "label": "Email",
//         "hint": "Enter your email",
//         "optional": false,
//         "regex": "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
//       },
//       {
//         "type": "text",
//         "label": "Pass",
//         "isPassword": true,
//         "hint": "Enter your Password",
//         "optional": true,
//         "regex": ""
//       },
//       {
//         "type": "text",
//         "label": "Pincode",
//         "hint": "Enter your Pincode",
//         "optional": false,
//         "regex": ""
//       },
//       {
//         "type": "text",
//         "label": "State",
//         "hint": "Enter your State",
//         "optional": false,
//         "regex": ""
//       },
//       {
//         "type": "text",
//         "label": "District",
//         "hint": "Enter your District",
//         "optional": false,
//         "regex": ""
//       },
//       {
//         "type": "text",
//         "label": "City",
//         "hint": "Enter your City",
//         "optional": false,
//         "regex": ""
//       },
//       {
//         "type": "DOB",
//         "label": "Date of birth",
//         "hint": "Enter your DOB",
//         "optional": false,
//         "regex": ""
//       },
//       {
//         "type": "text",
//         "label": "Mobile",
//         "optional": false,
//         "hint": "Enter your Mobile No",
//         "regex": "^[0-9]{10}\$"
//       },
//       {
//         "type": "dropdown",
//         "label": "Gender",
//         "optional": false,
//         "options": ["Male", "Female", "Other"]
//       },
//       {
//         "type": "dropdown",
//         "label": "Marital Status",
//         "optional": false,
//         "options": ["Married", "UnMarried"]
//       },
//       {
//         "type": "radio",
//         "label": "Subscribe",
//         "optional": false,
//         "options": ["Yes", "No"]
//       }
//     ];
//     notifyListeners(); // Notify listeners after fetching form fields
//   }
//
//   void updateFormData(String key, dynamic value) {
//     _formData[key] = value;
//     notifyListeners(); // Notify listeners to update UI
//   }
//   Future<void> fetchLocationDetails(String pincode) async {
//     final url = 'https://vrkableuat.vcqru.com/api/Postalcode?pincode=$pincode';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['Status'] == true) {
//           var location = data['Data'][0];
//           String city = location['Name'];
//           String state = location['State'];
//           String district = location['District'];
//
//           // Update the provider with fetched location data
//           _formData['City'] = city;
//           _formData['State'] = state;
//           _formData['District'] = district;
//
//           notifyListeners(); // Notify listeners to update UI
//         } else {
//           print('Failed to fetch valid location data');
//         }
//       } else {
//         print('Failed to fetch location data');
//       }
//     } catch (e) {
//       print('Error fetching location data: $e');
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';

class RegistrationFormProvider extends ChangeNotifier {
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
      String result = "VendorAppSetting^VCQRURD092022^"+AppUrl.Comp_ID;
      print(result);
      var re = await sha512Digestfinal(result);
      print("-------" + re);
      Map data1 = {
        "Comp_ID": AppUrl.Comp_ID,
        "EncData": re
      };
      print(data1);
      var value = await _api.postRequest(data1,AppUrl.BRAND_SETTING);

      if (value['Status'] == true && value['Data']['RegistrationFields'] != null) {
        print("---details fetch");
        // Parse fields
        _formFields = List<Map<String, dynamic>>.from(value['Data']['RegistrationFields'].map((field) {
          return {
            "type": field['FieldType'] == "text"
                ? "text"
                : field['FieldType'] == "Radio"
                ? "radio"
                : field['FieldType'] == "Dropdown"
                ? "dropdown"
                : field['FieldType'],
            "label": field['FieldName'],
            "hint": field['Hint'] ?? '',
            "optional": !(field['IsMandatory'] ?? true),
            "regex": field['Regex'],
            "options": field['FieldType'] == "Dropdown" || field['FieldType'] == "Radio"
                ? field['Values'] ?? ["option1","Option2"] // Use actual options from the API
                : null,
          };
        }));
      } else {
        _hasErrorForm = true;
        _errorMessageForm = value['Message'] ?? 'Invalid data received.';
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
        if (data['Status'] == true) {
          var location = data['Data'][0];
          String city = location['Name'];
          String state = location['State'];
          String district = location['District'];

          // Update the provider with fetched location data
          _formData['City'] = city;
          _formData['State'] = state;
          _formData['Dist'] = district;

          notifyListeners(); // Notify listeners to update UI
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
      Map data = {
        "Request": request,
      };
      print(data);
      final value = await _api.postRequest(data,AppUrl.REGISTER);
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
