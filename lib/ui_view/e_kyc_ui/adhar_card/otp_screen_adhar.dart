import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/ekyc_providers/aadhar_verify_provider/aadhar_verify_provider.dart';
import '../../../providers_of_app/ekyc_providers/kyc_main_page_provider.dart';
import '../../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/components/circle_loader.dart';
import '../../../res/components/custom_elevated_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../../res/localization/localization_en.dart';



class OtpBottomSheetAadhar extends StatelessWidget {
  String aadhar;
  BuildContext context2;
  OtpBottomSheetAadhar({required this.aadhar,required this.context2});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
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
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  print("----click--");
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey.shade300,
                    child:Icon(
                      Icons.clear,
                      size: 19,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
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
                      'Enter the 6-digit code sent to you at  '+aadhar,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14,color: AppColor.otp_color),
                    ),
                  ),
                  SizedBox(height: 16),
                  Consumer<AadharVerifyProvider>(
                    builder: (context, timerProvider, child) {
                      return PinCodeTextField(
                        appContext: context,
                        length: 6,
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          if(value.length!=6){
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
                          fieldWidth: 50,
                          borderWidth: 0.8,
                          inactiveColor: AppColor.grey_color,
                          activeColor: AppColor.grey_color,
                          activeFillColor: Colors.transparent,
                          inactiveFillColor: Colors.transparent,
                          selectedColor: splashProvider.color_bg,
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
                        onTap: () async {
                          var value1=await timerProvider.sendotpAadhar1(aadhar);
                          if (value1 != null) {
                            var status = value1["success"] ?? false;
                            var msg = value1["message"] ?? AppUrl.warningMSG;
                            if (status) {
                              var data=value1['data'];
                              if(data!=null){
                                var refreID=value1['data']['aadharRefrenceId'];
                                timerProvider.setReferenceId(refreID);
                              }
                              toastRedC(msg);
                            } else {
                              CustomAlert.showMessage(
                                  context, "", msg.toString(), AlertType.info);
                            }
                          } else {
                            toastRedC(AppUrl.warningMSG);
                          }
                        },
                          child: Text("Resend OTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: splashProvider.color_bg,fontSize: 14),)):Text(
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

                            var value1 = await valueProvider.verifyAadhar1(aadhar,valueProvider.referenId,valueProvider.otpValue);
                            if(value1!=null){
                              var status = value1["success"] ?? false;
                              var msg = value1["message"] ??"";
                              if (status) {
                                Navigator.pop(context);
                                presentBottomProgress(context2, aadhar);
                                var data=value1["data"];
                                if(data!=null){
                                  var resultData = value1["data"]["isaadharVerify"]??false;
                                  if(resultData){
                                    Provider.of<KYCMainProvider>(context2, listen: false).setAadhar("1");
                                    var vty=Provider.of<KYCMainProvider>(context2, listen: false);
                                    vty.setKYCMAIN(1);
                                    Future.delayed(Duration(seconds: 3), () {
                                      // Code to execute after 3 seconds
                                      showSuccessBottomSheet(context2);
                                    });
                                  }
                                }
                              } else {
                                CustomAlert.showMessage(
                                    context2, "Info", msg.toString(), AlertType.info);
                                Provider.of<KYCMainProvider>(context2, listen: false).setAadhar("2");
                                var vty=Provider.of<KYCMainProvider>(context2, listen: false);
                                vty.setKYCMAIN(1);
                              }
                            }else{
                              CustomAlert.showMessage(
                                  context2, "Info", "'Something Went Wrong' Please Try Again Later", AlertType.info);
                            }
                          }else{
                            toastRedC("Please Enter OTP");
                          }
                        },
                        buttonColor:splashProvider.color_bg,
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
  void showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Prevent user from dismissing manually
      enableDrag: false, // Disable drag-to-dismiss
      builder: (context) {
        // Start a timer to close the bottom sheet after 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.of(context).canPop()) {
            // Close the BottomSheet
            Navigator.of(context).pop(); // Close the BottomSheet
            Navigator.of(context).pop(); // Close the BottomSheet
            Navigator.of(context).pop(); // Close the BottomSheet
          }
        });

        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 48),
              SizedBox(height: 16),
              Text(
                'Verified Now !',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Your Aadhar Card has been successfully verified with your account. Please, check status'),
            ],
          ),
        );
      },
    );
  }
  String obscurePanCardNumber(String aadhar) {
    if (aadhar.length == 12) {
      // Replace characters from index 5 to 8 with asterisks
      String obscuredPart = aadhar.substring(2, 8).replaceAll(RegExp(r'.'), '*');

      // Concatenate the parts
      return aadhar.substring(0, 2) + obscuredPart + aadhar.substring(8);
    } else {
      return aadhar; // Handle invalid phone numbers
    }
  }
  void presentBottomProgress(BuildContext context,adhar) {

    String obscuredPan = obscurePanCardNumber(adhar);
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        isDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context); // Manual Close
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Space between widgets
                  const Center(
                    child: SpinKitCircle(
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Verify your Adhar No $obscuredPan",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Text("Wait for a few seconds..."),
                ],
              ),
            );
          });
        });
  }

}