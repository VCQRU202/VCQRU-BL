import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/ekyc_providers/aadhar_verify_provider/aadhar_verify_provider.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/components/custom_elevated_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../../res/localization/localization_en.dart';


class OtpBottomSheetAadhar extends StatelessWidget {
  String aadhar,requestId;
  OtpBottomSheetAadhar({required this.aadhar,required this.requestId});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 10.0,
        top: 0.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              // GestureDetector(
              //   onTap: (){
              //     Navigator.pop(context);
              //     print("----click--");
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     alignment: Alignment.topRight,
              //     margin: EdgeInsets.only(top: 10),
              //     child: CircleAvatar(
              //       radius: 20,
              //       backgroundColor: Colors.grey.shade300,
              //       child:Icon(
              //         Icons.clear,
              //         color: Colors.red,
              //       ),
              //     ),
              //   ),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      'OTP Verification',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Enter the 4-digit code sent to you at  '+aadhar,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14,color: AppColor.otp_color),
                    ),
                  ),
                  SizedBox(height: 16),
                  Consumer<AadharVerifyProvider>(
                    builder: (context, timerProvider, child) {
                      return PinCodeTextField(
                        appContext: context,
                        length: 4,
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          if(value.length!=4){
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
                          activeFillColor: Colors.transparent,
                          inactiveFillColor: Colors.transparent,
                          selectedColor: AppColor.app_btn_color,
                          selectedFillColor: Colors.transparent,
                          disabledColor: Colors.transparent,
                        ),
                        animationType: AnimationType.fade,
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        blinkWhenObscuring: false,
                        obscureText: false,
                      );
                    },
                  ),
                  SizedBox(height: 6),
                  Consumer<AadharVerifyProvider>(
                    builder: (context, timerProvider, child) {
                      return timerProvider.start==0?GestureDetector(
                        onTap: (){
                          timerProvider.sendotpAadhar1(aadhar);
                        },
                          child: Text("Resend OTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColor.app_btn_color,fontSize: 14),)):Text(
                        'I haven’t received a code (0:${timerProvider.start})',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Consumer<AadharVerifyProvider>(
                    builder: (context, valueProvider, child){
                      return CustomElevatedButton(
                        onPressed: () async {
                          if(valueProvider.otpCOmpleted){
                            var value1 = await valueProvider.verifyAadhar1(aadhar,requestId,valueProvider.otpValue);
                            if(value1!=null){
                              var status = value1["Status"] ?? false;
                              var msg = value1["Message"] ??"";
                              if (status) {

                              } else {
                                CustomAlert.showMessage(
                                    context, "Info", msg.toString(), AlertType.info);
                              }
                            }else{
                              CustomAlert.showMessage(
                                  context, "Info", "'Something Went Wrong' Please Try Again Later", AlertType.info);
                            }
                          }else{
                            toastRedC("Please Enter OTP");
                          }
                        },
                        buttonColor:AppColor.app_btn_color,
                        textColor: AppColor.white_color,
                        widget: valueProvider.isLoading_verify ? CircularProgressIndicator(
                          color: AppColor.white_color,
                          strokeAlign: 0,
                          strokeWidth: 4,
                        )
                            : CustomText(
                          text: LocalizationEN.verify_btn,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:AppColor.white_color ,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}