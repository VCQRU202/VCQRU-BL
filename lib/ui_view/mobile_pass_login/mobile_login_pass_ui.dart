import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/res/values/values.dart';
import 'package:vcqru_bl/ui_view/mobile_pass_login/success_msg_for_login.dart';

import '../../providers_of_app/mobile_pass_provider/mobile_login_password_provider.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/Colors.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/components/custom_textformfield.dart';
import 'package:provider/provider.dart';

import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/localization/localization_en.dart';
import '../../res/shared_preferences.dart';
import '../../res/values/images_assets.dart';
import '../e_kyc_ui/e_kyc_main_ui.dart';
import '../otp_screen/otp_screen.dart';

class LoginWithPassword extends StatelessWidget {
  const LoginWithPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Login",style: TextStyle(fontSize: 18),),),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Consumer<LoginProvider>(
            builder: (context, value, child){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFe0f2f1),
                        image: DecorationImage(image:AssetImage("assets/logo.png"),fit: BoxFit.contain)
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 0,left: 2,bottom: 2),
                    child: CustomText(
                      text:"Mobile Number",
                      fontSize: 12,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 44,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color:value.isCheckComplete?AppColor.red_color:Colors.grey, width: 1.2),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/indianflag.png',
                          width: 22,
                          height: 24,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '+91 |',
                          style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: value.mobileController,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: '999-999-9999',
                              hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                            ),
                            onChanged: (valuemobile) {
                              if(valuemobile.length==10){
                                value.changeMobileLenght(10);
                              } else{
                                value.changeMobileLenght(0);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 0,left: 2,bottom: 2),
                    child: CustomText(
                      text:"Password",
                      fontSize: 12,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: value.isCheckComplete ? AppColor.red_color : Colors.grey,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              bool _isPasswordVisible = false; // State for password visibility toggle
                              return TextFormField(
                                controller: value.passwordController,
                                obscureText: !_isPasswordVisible, // Hide or show password
                                style: TextStyle(fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  hintText: '*******',
                                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 14),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                                ),
                                onChanged: (value) {
                                  // Handle password change if necessary
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: value.isCheckComplete,
                          activeColor: Colors.green,
                          onChanged: (bool? valueisCheck) {
                            value.ischeckStatus(valueisCheck);
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 12.0, color: Color(0xFF6C757D),height: 1.4),
                              children: [
                                TextSpan(
                                  text: 'By proceeding, you are agreeing to the VCQRU ',
                                ),
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("Terms and Conditions");
                                    },
                                ),
                                TextSpan(
                                  text: ' & ',
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("Privacy Policy");
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>SuccessMsgSuccessfullyLogin(
                        //   msg: "Login Successfully",)));

                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>KycMainScreen()));
                        if (value.mobileController.text.startsWith("0") ||
                            value.mobileController.text.startsWith("1") ||
                            value.mobileController.text.startsWith("2") ||
                            value.mobileController.text.startsWith("3") ||
                            value.mobileController.text.startsWith("4") ||
                            value.mobileController.text.startsWith("5") ||
                            value.mobileController.text.isEmpty ||
                            value.mobileController.text.length != 10) {
                          toastRedC("Please Enter Valid Number");
                          return;
                        }else if(!value.isCheckComplete){
                          toastRedC("Please Accept Terms condition");
                          return;
                        } else if (value.mobileController.text.length == 10) {
                         // showOtpBottomSheet(context,value.mobileController.text);

                        }
                      },
                      buttonColor:AppColor.app_btn_color,
                      textColor: AppColor.white_color,
                      widget: value.isloading ? CircularProgressIndicator(
                        color: AppColor.white_color,
                        strokeAlign: 0,
                        strokeWidth: 4,
                      )
                          : CustomText(
                        text: LocalizationEN.login_btn,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColor.white_color,
                      ),
                    ),
                  ),
                  SizedBox(height: 6,),
                  Container(
                    child: GestureDetector(
                      onTap: () async {
                        showOtpBottomSheet(context,value.mobileController.text);
                        // var value1 = await value.sendOtp();
                        // if (value1 != null) {
                        //   var status = value1["Status"] ?? false;
                        //   var msg = value1["Message"] ?? AppUrl.warningMSG;
                        //   if (status) {
                        //     showOtpBottomSheet(context,value.mobileController.text);
                        //   } else {
                        //     CustomAlert.showMessage(
                        //         context, "", msg.toString(), AlertType.info);
                        //   }
                        // } else {
                        //   toastRedC(AppUrl.warningMSG);
                        // }
                      },
                      child: Text(LocalizationEN.LOGIN_WITH_OTP,style: TextStyle(
                        fontWeight: FontWeight.bold,color: AppColor.app_btn_color),),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  void showOtpBottomSheet(BuildContext context,String mob) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
      ),
      builder: (BuildContext context) {
        return OtpBottomSheet(mobile: mob,);
      },
    );
  }
}
