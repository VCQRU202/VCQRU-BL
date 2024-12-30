import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import '../../providers_of_app/enter_mobile_provider/enter_mobile_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/localization/localization_en.dart';
import '../e_kyc_ui/e_kyc_main_ui.dart';
import '../mobile_pass_login/mobile_login_pass_ui.dart';
import '../otp_screen/otp_screen.dart';
import '../registration_ui/success_msg_register.dart';
import '../registration_ui/user_registration_ui.dart';



class MobileEnterScreen extends StatefulWidget {
  const MobileEnterScreen({Key? key}) : super(key: key);

  @override
  State<MobileEnterScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<MobileEnterScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Dark icons for light background
      statusBarBrightness: Brightness.light, // For iOS
    ));
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
          resizeToAvoidBottomInset: false,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(0), // Set the height to zero
        //   child: AppBar(
        //     backgroundColor: Colors.transparent, // Make background transparent
        //     elevation: 0, // Remove shadow
        //     systemOverlayStyle: SystemUiOverlayStyle(
        //       statusBarColor: Colors.transparent, // Transparent status bar
        //       statusBarIconBrightness: Brightness.dark, // Dark icons for light background
        //       statusBarBrightness: Brightness.light, // For iOS
        //     ),
        //   ),
        // ),
      body: Container(
        decoration: BoxDecoration(
          color: splashProvider.color_bg,
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 7,
                child:Consumer<EnterMobileProvider>(
                  builder: (context, value, child){
                    return Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 30),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          // background image and bottom contents
                          ListView(
                            children: <Widget>[
                              Container(
                                height: 30.0,
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
                                      margin: EdgeInsets.only(top: 70,left: 15,bottom: 2),
                                      child: CustomText(
                                        text:"Welcome To ${splashProvider.companyName.split(" ")[0]}",
                                        fontSize: 24,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 0,left: 15,bottom: 2),
                                      child: CustomText(
                                        text:"We will send you a confirmation code",
                                        fontSize: 14,
                                        color: AppColor.app_btn_color_inactive,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 0,left: 10,bottom: 2),
                                      child: CustomText(
                                        text:"Mobile Number",
                                        fontSize: 12,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      height: 44,
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.only(left: 10,right: 10),
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
                                                hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
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
                                    const SizedBox(
                                      height: 16,
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
                                                style: TextStyle(fontSize: 14.0, color: Color(0xFF6C757D),height: 1.4),
                                                children: [
                                                  TextSpan(
                                                    text: 'By logging in, you agree to our',
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
                                                    text: ' and ',
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
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 44,
                                      margin: EdgeInsets.only(left: 10,right: 10),
                                      child: CustomElevatedButton(
                                        onPressed: () async {
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(builder: (context)=>KycMainScreen()));
                                          // Navigator.pushReplacement(context,
                                          //     MaterialPageRoute(builder: (context)=>OtpBottomSheet(mobile:"9876543212",)));
                                          // Navigator.pushReplacement(context, MaterialPageRoute(
                                          //     builder: (context)=>SuccessMsgSuccessfully(msg:"Register Successfully" ,)));
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
                                          }
                                          else if(!value.isCheckComplete){
                                            toastRedC("Please Accept Terms condition");
                                            return;
                                          }
                                          else if (value.mobileController.text.length == 10) {
                                            var value1 = await value.sendOtp();
                                            if (value1 != null) {
                                              var status = value1["success"] ?? false;
                                              var msg = value1["message"] ?? AppUrl.warningMSG;
                                              if (status) {
                                                Navigator.pushReplacement(context,
                                                    MaterialPageRoute(builder: (context)=>OtpBottomSheet(mobile:value.mobileController.text,)));
                                                toastRedC(msg);
                                              } else {
                                                CustomAlert.showMessage(
                                                    context, "", msg.toString(), AlertType.info);
                                              }
                                            } else {
                                              toastRedC(AppUrl.warningMSG);
                                            }
                                          }
                                        },
                                        buttonColor:value.mobileCOmpleted ? splashProvider.color_bg : AppColor.grey_color,
                                        textColor:value.mobileCOmpleted ? AppColor.white_color : AppColor.app_btn_color_inactive,
                                        widget: value.isloading ? CircularProgressIndicator(
                                          color: AppColor.white_color,
                                          strokeAlign: 0,
                                          strokeWidth: 4,
                                        )
                                            : CustomText(
                                          text: LocalizationEN.GET_OTP,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: value.mobilnum == 10
                                              ? AppColor.white_color
                                              : AppColor.app_btn_color_inactive,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16,),
                                  ],
                                ),
                                ),

                            ],
                          ),
                          // Profile image
                          Positioned(
                            top: 10.0, // (background container size) - (circle height / 2)
                            child: Card(
                              elevation: 4.0, // Controls the elevation
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
                      flex: 1,
                      child: Container(
                        // This can hold other UI elements above the GridView
                        color: Colors.transparent,
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
    );
  }
}
