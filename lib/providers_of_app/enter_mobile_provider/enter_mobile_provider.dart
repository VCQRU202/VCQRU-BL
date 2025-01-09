import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/repositorys/repositories_app.dart';
import '../../models/social_media_model/social_media_model.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/shared_preferences.dart';

class EnterMobileProvider with ChangeNotifier{
   TextEditingController mobileController = TextEditingController();
   final _api = RepositoriesApp();
  bool _isChecked = false;
  bool _isCompleted=false;
  int _mobilenum = 0;
   bool _isloaing = false;
   bool _isloaing_verify_otp = false;
   bool get isloading => _isloaing;
   bool get isloaing_otp => _isloaing_verify_otp;

  int get mobilnum => _mobilenum;
   bool get mobileCOmpleted => _isCompleted;
   bool get isCheckComplete => _isChecked;
  void changeMobileLenght(value) {
    _mobilenum = value;
    if(_mobilenum==10){
      print("-----true===");
      _isCompleted=true;
    }else{
      print("-----false===");
      _isCompleted=false;
    }
    notifyListeners();
  }

   void ischeckStatus(value) {
     _isChecked = value;
     notifyListeners();
   }
   int _start = 30;
   Timer? _timer;

   int get start => _start;
   var _otpValue;

   get otpValue => _otpValue;
   bool _completed = false;

   bool get otpCOmpleted => _completed;
   void startTimer() {
     _start = 30;
     _timer?.cancel();
     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
       if (_start == 0) {
         timer.cancel();
       } else {
         _start--;
         notifyListeners();
       }
     });
   }
   void otpSave(otp) {
     _otpValue = otp;
     notifyListeners();
   }

   void otpCompleted(value) {
     _completed = value;
     notifyListeners();
   }
   void stopTimer() {
     _timer?.cancel();
   }
   void clearData(){
     mobileController.clear();
   }

   @override
   void dispose() {
     _timer?.cancel();
     super.dispose();
   }
   Future<dynamic> sendOtp() async {

     startTimer();
     _isloaing = true;
     notifyListeners();
     var companyName = await SharedPrefHelper().get("CompanyName")??"";
     Map data = {
       "compName":companyName,
       "mobile": mobileController.text,
     };
     print(data.toString());
     try {
       var value = await _api.sendOTP(data,AppUrl.SEND_OTP);
       _isloaing = false;
       notifyListeners();
       log(value.toString());
       if (value != null) {
         return value;
       } else {
         toastRedC(AppUrl.warningMSG);
         return null;
       }
     } catch (error, stackTrace) {
       _isloaing = false;
       notifyListeners();
       return null;
     }
   }

   Future<dynamic> verifyOtp(mobile) async {
     _isloaing_verify_otp = true;
     notifyListeners();
     var companyName = await SharedPrefHelper().get("CompanyName")??"";
     String otp=otpValue.toString();
     Map data = {
       "otpCode": otp,
       "Mobile": mobile,
       "Comp_Name": companyName
     };
     print(data.toString());
     try {
       var value = await _api.verifyOTP(data,AppUrl.Verify_OTP);
       _isloaing_verify_otp = false;
       notifyListeners();
       log(value.toString());
       if (value != null) {
         return value;
       } else {
         toastRedC(AppUrl.warningMSG);
         return null;
       }
     } catch (error, stackTrace) {
       _isloaing_verify_otp = false;
       notifyListeners();
       return null;
     }
   }

   SocialMediaModel? _socialModel_social;
   bool _isLoading_social = true;
   bool _isloaing_social = false;
   bool _hasError_social = false;
   String _errorMessage_social = '';

   SocialMediaModel? get socialModel_social => _socialModel_social;
   bool get isLoading_social => _isLoading_social;
   bool get isloaing_social => _isloaing_social;
   bool get hasError_social => _hasError_social;
   String get errorMessage_social => _errorMessage_social;

   List<Map<String, dynamic>> _socialItems = [];

   List<Map<String, dynamic>> get socialItems => _socialItems;
   Future<void> getSocialMedia() async {
     _isLoading_social = true;
     _hasError_social = false;
     Map requestData = {"Comp_id": AppUrl.Comp_ID};
     print(requestData);
     try {
       final response = await _api.postRequest(requestData, AppUrl.SOCIAL_MEDIA_API);
       print(response);
       print("---social list----");
       print(response['success']);
       if (response['success']&& response['data'] != null) {
         print("-----------true---");
         _isLoading_social = true;
         _hasError_social = false;
         _socialModel_social=SocialMediaModel.fromJson(response);
         notifyListeners();

         _socialItems = [
           {
             'icon': Icons.facebook,
             'label': 'Facebook',
             'url': socialModel_social?.data?.facebookURL ?? '',
             'isEnabled': socialModel_social?.data?.facebookRequired??"false",
           },
           {
             'icon': FontAwesomeIcons.twitter,
             'label': 'Twitter',
             'url': socialModel_social?.data?.tweeterURL ?? '',
             'isEnabled': socialModel_social?.data?.tweeterRequired??"false",
           },
           {
             'icon': FontAwesomeIcons.linkedin,
             'label': 'Linkedin',
             'url': socialModel_social?.data?.linkdInURL ?? '',
             'isEnabled': socialModel_social?.data?.linkdInRequired??"false",
           },
           {
             'icon': FontAwesomeIcons.youtube,
             'label': 'Youtube',
             'url': socialModel_social?.data?.youTubeURL ?? '',
             'isEnabled': socialModel_social?.data?.youTubeRequired??"false",
           },
           {
             'icon': FontAwesomeIcons.instagram,
             'label': 'Instagram',
             'url': socialModel_social?.data?.instagramURL ?? '',
             'isEnabled': socialModel_social?.data?.instagramRequired??"false",
           },
           {
             'icon': Icons.phone,
             'label': 'Call',
             'url': socialModel_social?.data?.contactNumberURL??"",
             'isEnabled': socialModel_social?.data?.contactNumberRequired??"false",
           },
           {
             'icon': Icons.email,
             'label': 'Mail',
             'url': socialModel_social?.data?.eMailURL??"",
             'isEnabled': socialModel_social?.data?.eMailRequired??"false",
           },
           {
             'icon': Icons.help_outline,
             'label': 'Contact',
             'url': socialModel_social?.data?.contactUSURL??"",
             'isEnabled': socialModel_social?.data?.contactUSRequired??"false",
           },
         ];
         print("----social length---${_socialItems.length}-----");
         print("----social items---${_socialItems}");
         notifyListeners();
       } else {
         print("-----------false---");
         _isLoading_social = false;
         _hasError_social = true;
         _errorMessage_social =response['message'];
         notifyListeners();
       }
     } catch (error) {
       _isLoading_social = false;
       _hasError_social = true;
       _errorMessage_social = "'Something Went Wrong' Please Try Again Later";
       notifyListeners();
       print('Failed to load profile');
     } finally {
       _isLoading_social = false;
       notifyListeners();
     }
   }
   Future<void> retrygetSocialMedia() async {
     _isLoading_social = true;
     _hasError_social = false;
     notifyListeners();
     await getSocialMedia();
   }
}