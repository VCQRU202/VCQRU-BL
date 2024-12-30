import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/dashboard_ui/dashboard_ui.dart';

import '../../providers_of_app/enter_mobile_provider/enter_mobile_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/localization/localization_en.dart';
import '../../res/shared_preferences.dart';
import '../mobile_enter/mobile_enter_screen.dart';
import '../registration_ui/user_registration_ui.dart';

class OtpBottomSheet extends StatelessWidget {
  String mobile;

  OtpBottomSheet({required this.mobile});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MobileEnterScreen()));
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:Container(
          decoration: BoxDecoration(
            color: splashProvider.color_bg,
          ),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20,top: 30),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MobileEnterScreen()));
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 7,
                  child:Consumer<EnterMobileProvider>(
                    builder: (context, value, child){
                      return Container(
                        margin: EdgeInsets.only(left: 10,right: 10,),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            // background image and bottom contents
                            ListView(
                              children: <Widget>[
                                Container(
                                  height: 16.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 70, left: 10, right: 10),
                                        child: Text(
                                          'OTP Verification',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 9, left: 20, right: 20),
                                        child: Text(
                                          'Enter the 4-digit code received on your \n mobile no +91 ' + mobile,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.otp_color1),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Consumer<EnterMobileProvider>(
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
                                                selectedColor: splashProvider.color_bg,
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
                                      Consumer<EnterMobileProvider>(
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
                                      Consumer<EnterMobileProvider>(
                                        builder: (context, valueProvider, child) {
                                          return Container(
                                            margin: EdgeInsets.only(left: 10, right: 10,bottom: 20),
                                            width: double.infinity,
                                            child: CustomElevatedButton(
                                              onPressed: () async {
                                                if (valueProvider.otpCOmpleted) {
                                                  var value1 = await valueProvider.verifyOtp(mobile);
                                                  if (value1 != null) {
                                                    var status = value1["success"] ?? false;
                                                    var msg = value1["message"] ?? "";
                                                    if (status) {
                                                      var userData = value1['data'];
                                                      if (userData != null) {
                                                        var usertype = value1['data']['UserType'] ?? "";
                                                        var userId1 = value1['data']['user_ID'] ?? "";
                                                        var UserName = value1['data']['consumerName'] ?? "";
                                                        var M_Consumerid = value1['data']['m_consumerid'] ?? "";
                                                        var MobileNumber = value1['data']['mobileNo'] ?? "";
                                                        var kycStatus = value1['data']['Ekyc_status'] ?? "0";
                                                        if(userId1.toString().isNotEmpty&&M_Consumerid.toString().isNotEmpty
                                                            &&MobileNumber.toString().isNotEmpty){
                                                          await SharedPrefHelper().save("User_ID", userId1);
                                                          await SharedPrefHelper().save("Verify", true);
                                                          await SharedPrefHelper().save("Name", UserName);
                                                          await SharedPrefHelper().save("M_Consumerid", M_Consumerid.toString());
                                                          await SharedPrefHelper().save("MobileNumber", MobileNumber.toString());
                                                          Navigator.pushReplacement(context,
                                                              MaterialPageRoute(builder: (context)=>DashboardApp()));
                                                          toastRedC(msg);
                                                        }else {
                                                          Navigator.pushReplacement(context,
                                                              MaterialPageRoute(builder: (context)=>RegistrationFormPage(mobile:mobile,)));
                                                        }
                                                      } else {
                                                        CustomAlert.showMessage(
                                                            context,
                                                            "Info",
                                                            msg,
                                                            AlertType.info);
                                                      }
                                                    } else {
                                                      CustomAlert.showMessage(
                                                          context,
                                                          "Info",
                                                          msg,
                                                          AlertType.info);
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
                                              buttonColor: splashProvider.color_bg,
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
                                  ),
                                ),

                              ],
                            ),
                            // Profile image
                            Positioned(
                              top: 0.0, // (background container size) - (circle height / 2)
                              child: Card(
                                elevation: 2.0, // Controls the elevation
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50), // Ensures circular shape
                                ),
                                child: Container(
                                  height: 80.0, // Height of the circular container
                                  width: 80.0,  // Width of the circular container
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle, // Ensures the container is circular
                                    image: DecorationImage(
                                      image: NetworkImage(splashProvider.logoUrlF), // Replace with your image URL
                                      fit: BoxFit.cover, // Adjust fit to cover the entire circle
                                    ),
                                    color: Colors.grey.shade200, // Optional background color while the image loads
                                  ),
                                  child: splashProvider.logoUrlF.isNotEmpty
                                      ? null
                                      : Center(
                                    child: CircularProgressIndicator(), // Loader while the image is being fetched
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: Container(
                          // This can hold other UI elements above the GridView
                          color: Colors.indigo,
                        ),
                      ),
                      Expanded(
                        flex: 9, // Adjust this flex value to control the size of the grid area
                        child: Container(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, // Number of columns set to 4
                                crossAxisSpacing: 0, // Spacing between columns
                                mainAxisSpacing: 0,
                                childAspectRatio: 1// Spacing between rows
                            ),
                            itemCount: splashProvider.socialItems.length,
                            itemBuilder: (context, index) {
                              final item = splashProvider.socialItems[index];
                              return GestureDetector(
                                onTap: () {
                                  // Example: Show a snackbar with the selected item's label
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Clicked: ${item['label']}")),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20, // Circle size
                                      child: Icon(
                                        item['icon'],
                                        color: Colors.purple, // Icon color
                                        size: 22, // Icon size
                                      ),
                                    ),
                                    SizedBox(height: 3), // Spacing between icon and label
                                    Text(
                                      item['label'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
