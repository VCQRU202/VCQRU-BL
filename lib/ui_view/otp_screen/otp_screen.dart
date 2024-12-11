import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/res/values/images_assets.dart';

import '../../providers_of_app/mobile_pass_provider/mobile_login_password_provider.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/localization/localization_en.dart';
import '../../res/shared_preferences.dart';
import '../mobile_enter/mobile_enter_screen.dart';

class OtpBottomSheet extends StatelessWidget {
  String mobile;

  OtpBottomSheet({required this.mobile});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>MobileEnterScreen()));
        return true;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFFFFFFF), Color(0xFFE0E0FD),],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/otp_top.png"),
                    // Replace with your asset path
                    fit: BoxFit
                        .cover, // Adjust the fit as needed: cover, contain, fill, etc.
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            // Add your onPressed logic here
                            print("Back icon pressed");
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context)=>MobileEnterScreen())); // Example: Navigate back
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 1, left: 10, right: 10),
                        child: Text(
                          'OTP Verification',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 9, left: 10, right: 10),
                        child: Text(
                          'Enter the 4-digit code sent to you at +91 ' + mobile,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16, color: AppColor.otp_color),
                        ),
                      ),
                      SizedBox(height: 16),
                      Consumer<LoginProvider>(
                        builder: (context, timerProvider, child) {
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: PinCodeTextField(
                              appContext: context,
                              length: 4,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.length != 4) {
                                  timerProvider.otpCompleted(false);
                                }
                              },
                              onCompleted: (value) {
                                timerProvider.otpSave(value);
                                timerProvider.otpCompleted(true);
                              },
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 44,
                                fieldWidth: 70,
                                borderWidth: 0.8,
                                inactiveColor: AppColor.grey_color,
                                activeColor: AppColor.grey_color,
                                activeFillColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                selectedColor: AppColor.app_btn_color,
                                selectedFillColor: Colors.transparent,
                                disabledColor: Colors.transparent,
                              ),
                              animationType: AnimationType.fade,
                              animationDuration: Duration(milliseconds: 300),
                              enableActiveFill: true,
                              blinkWhenObscuring: false,
                              obscureText: false,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 6),
                      Consumer<LoginProvider>(
                        builder: (context, timerProvider, child) {
                          return timerProvider.start == 0
                              ? GestureDetector(
                              onTap: () {
                                timerProvider.sendOtp();
                              },
                              child: Text(
                                "Resend OTP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.app_btn_color, fontSize: 14),
                              ))
                              : Text(
                            'I haven’t received a code (0:${timerProvider.start})',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      Consumer<LoginProvider>(
                        builder: (context, valueProvider, child) {
                          return Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: CustomElevatedButton(
                              onPressed: () async {
                                if (valueProvider.otpCOmpleted) {
                                  var value1 = await valueProvider.verifyOtp(mobile);
                                  if (value1 != null) {
                                    var status = value1["Status"] ?? false;
                                    var msg = value1["Message"] ?? "";
                                    if (status) {
                                      var userData = value1['Data'];
                                      if (userData != null) {
                                        var usertype = value1['Data']['UserType'] ?? "";
                                        var userId = value1['Data']['ID'] ?? "";
                                        var userId1 = value1['Data']['User_ID'] ?? "";
                                        var UserName = value1['Data']['UserName'] ?? "";
                                        var StateName = value1['Data']['StateName'] ?? "";
                                        var M_Consumerid =
                                            value1['Data']['M_Consumerid'] ?? "";
                                        var MobileNumber =
                                            value1['Data']['MobileNumber'] ?? "";
                                        var kycStatus =
                                            value1['Data']['Ekyc_status'] ?? "0";

                                      } else {
                                        CustomAlert.showMessage(
                                            context,
                                            "Info",
                                            "'Something Went Wrong' Please Try Again Later",
                                            AlertType.info);
                                      }
                                    } else {
                                      CustomAlert.showMessage(context, "Info",
                                          msg.toString(), AlertType.info);
                                    }
                                  } else {
                                    CustomAlert.showMessage(
                                        context,
                                        "Info",
                                        "'Something Went Wrong' Please Try Again Later",
                                        AlertType.info);
                                  }
                                } else {
                                  toastRedC("Please Enter OTP");
                                }
                              },
                              buttonColor: AppColor.app_btn_color,
                              textColor: AppColor.white_color,
                              widget: valueProvider.isloaing_otp
                                  ? CircularProgressIndicator(
                                color: AppColor.white_color,
                                strokeAlign: 0,
                                strokeWidth: 4,
                              )
                                  : CustomText(
                                text: LocalizationEN.verify_btn,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColor.white_color,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
