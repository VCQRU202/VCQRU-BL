import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import '../../providers_of_app/enter_mobile_provider/enter_mobile_provider.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/localization/localization_en.dart';
import '../mobile_pass_login/mobile_login_pass_ui.dart';
import '../otp_screen/otp_screen.dart';



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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFFFFF), Color(0xFFE0E0FD),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Consumer<EnterMobileProvider>(
            builder: (context, value, child){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
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
                                Navigator.pop(context); // Example: Navigate back
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 0,left: 15,bottom: 2),
                    child: CustomText(
                      text:"Login",
                      fontSize: 24,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
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
                  // Container(
                  //   child: Row(
                  //     children: <Widget>[
                  //       Checkbox(
                  //         value: value.isCheckComplete,
                  //         activeColor: Colors.green,
                  //         onChanged: (bool? valueisCheck) {
                  //           value.ischeckStatus(valueisCheck);
                  //         },
                  //       ),
                  //       Expanded(
                  //         child: RichText(
                  //           text: TextSpan(
                  //             style: TextStyle(fontSize: 12.0, color: Color(0xFF6C757D),height: 1.4),
                  //             children: [
                  //               TextSpan(
                  //                 text: 'By proceeding, you are agreeing to the VCQRU ',
                  //               ),
                  //               TextSpan(
                  //                 text: 'Terms and Conditions',
                  //                 style: TextStyle(color: Colors.blue),
                  //                 recognizer: TapGestureRecognizer()
                  //                   ..onTap = () {
                  //                     print("Terms and Conditions");
                  //                   },
                  //               ),
                  //               TextSpan(
                  //                 text: ' & ',
                  //               ),
                  //               TextSpan(
                  //                 text: 'Privacy Policy',
                  //                 style: TextStyle(color: Colors.blue),
                  //                 recognizer: TapGestureRecognizer()
                  //                   ..onTap = () {
                  //                     print("Privacy Policy");
                  //                   },
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 44,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: CustomElevatedButton(
                      onPressed: () async {
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPassword()));

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
                        // else if(!value.isCheckComplete){
                        //   toastRedC("Please Accept Terms condition");
                        //   return;
                        // }
                        else if (value.mobileController.text.length == 10) {

                          var value1 = await value.sendOtp();
                          if (value1 != null) {
                            var status = value1["Status"] ?? false;
                            var msg = value1["Message"] ?? AppUrl.warningMSG;
                            if (status) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context)=>OtpBottomSheet(mobile:value.mobileController.text,)));
                            } else {
                              CustomAlert.showMessage(
                                  context, "", msg.toString(), AlertType.info);
                            }
                          } else {
                            toastRedC(AppUrl.warningMSG);
                          }
                        }
                      },
                      buttonColor:value.mobileCOmpleted ? AppColor.app_btn_color : AppColor.grey_color,
                      textColor:value.mobileCOmpleted ? AppColor.white_color : AppColor.app_btn_color_inactive,
                      widget: value.isloading ? CircularProgressIndicator(
                        color: AppColor.white_color,
                        strokeAlign: 0,
                        strokeWidth: 4,
                      )
                          : CustomText(
                        text: LocalizationEN.NEXT,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: value.mobilnum == 10
                            ? AppColor.white_color
                            : AppColor.app_btn_color_inactive,
                      ),
                    ),
                  ),
                  SizedBox(height: 6,),
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
