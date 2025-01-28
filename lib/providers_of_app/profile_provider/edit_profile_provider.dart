import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import 'package:http/http.dart' as http;

import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';
import '../dashboard_provider/dashboard_provider.dart';
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
    final url = 'https://api2.vcqru.com/api/Postalcode?pincode=$pincode';
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

  File? _image;
  String? _imagePath;
  String? _imageURL;
  String? dataType="";
  File? get image => _image;
  String? get imagePath => _imagePath;
  String? get imageURL => _imageURL;

  Future<void> getImgCamera(BuildContext context) async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image == null) return;
      _image = File(image.path);
      _imagePath = image.path;
      notifyListeners();
      await cropImage(context);
    } on PlatformException catch (e) {
      // Handle exception
    }
  }

  Future<void> getImgGallery(BuildContext context) async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null) return;
      _image = File(image.path);
      _imagePath = image.path;
      notifyListeners();
      await cropImage(context);
    } on PlatformException catch (e) {
      // Handle exception
    }
  }

  Future<void> cropImage(BuildContext context) async {
    if (_imagePath == null) return;

    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _imagePath!,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
        compressQuality: 70
    );

    if (croppedFile != null) {
      _image = File(croppedFile.path);
      _imagePath = croppedFile.path;
      notifyListeners();
      print("-----AadharCardFront-----");
      userProfile(context,_image!);
      notifyListeners();
    } else {
      print("Image is not cropped.");
    }
  }
  Future<void> userProfile(BuildContext context,File image222) async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    String fileName = image222.path.split('/').last;
    var user_id = await SharedPrefHelper().get("User_ID");
    var m_Consumerid = await SharedPrefHelper().get("M_Consumerid");
    String m_c=m_Consumerid.toString();
    print("-------decript----" + user_id);

    var id = fileName.split('.');
    var prefix1 = id[1].trim();
    String? userId = "";
    if (prefix1 == "jpg" || prefix1 == "png") {
      print("jpg/png Found");
      userId = user_id + "." + prefix1;
    } else {
      print("jpg/png not Found");
      userId = user_id + "." + "jpg";
    }
    FormData formData = FormData.fromMap({
      "profilePic": await MultipartFile.fromFile(
        image222.path,
        filename: userId,
      ),
      "Comp_id": AppUrl.Comp_ID, // Add Comp_id
      "M_Consumerid":m_c,  // Add M_Consumerid
    });
    print(formData);

    try {
      final response = await _api.postRequest(formData,AppUrl.USERPROFILE_IMAGE);
      await EasyLoading.dismiss();
      print(response);
      var status = response["success"] ?? false;
      if (status) {
        var data=response["data"];
        if(data!=null){
          var imageURl=response["data"]['imgpath']??"";
          if(imageURl!=null&&imagePath.toString().isNotEmpty){
            _imageURL=imageURl;
            Provider.of<DashboardProvider>(context, listen: false).resetImage();
            Provider.of<DashboardProvider>(context, listen: false).retryKYCSTATUS();
            notifyListeners();
          }else{
            toastRedC(response["message"] ?? AppUrl.warningMSG);
          }
        }else{
          toastRedC(response["message"] ?? AppUrl.warningMSG);
        }
        notifyListeners();
      } else {
        toastRedC(response["message"] ?? AppUrl.warningMSG);
      }
      notifyListeners();
    } on DioError catch (e) {
      await EasyLoading.dismiss();
      print(e.error);
      toastRedC(AppUrl.warningMSG);
    }
  }
}