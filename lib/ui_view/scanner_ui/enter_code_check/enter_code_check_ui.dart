import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../../providers_of_app/scanner_provider/scanner_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/components/custom_elevated_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/components/roundcornertextfield.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../../res/localization/localization_en.dart';
import 'code_check_failed_msg.dart';
import 'code_check_succes_msg.dart';
class EnterCodeCheck extends StatefulWidget {
  const EnterCodeCheck({super.key});

  @override
  State<EnterCodeCheck> createState() => _EnterCodeCheckState();
}

class _EnterCodeCheckState extends State<EnterCodeCheck> {
  TextEditingController codeCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Code Check",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        backgroundColor:AppColor.app_btn_color,
        actions: <Widget>[],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 15.0, left: 20.0, right: 20.0,bottom: 15),
                child: RoundedTextField(
                  hintText:"Enter 13 digit code",
                  icon: Icons.person_pin,
                  color: Colors.black,
                  keyboardtype: TextInputType.number,
                  length: 13,
                  controller: codeCheckController,
                  textFormFieldMargin: EdgeInsets.only(
                      left: 20, right: 20),
                  backgroundColor:
                  Colors.amber,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Mobile Number';
                    }
                  },
                  onChanged: (v) async {

                  },
                ),
              ),

            ],
          ),
          Consumer<Scanner_provider>(builder: (context,scanner_provider,child){
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20,right: 20),
              child: CustomElevatedButton(
                onPressed: () async {
                  if (codeCheckController.text.trim().length == 13) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    var value1 = await scanner_provider.appcodecheck(codeCheckController.text);
                    if (value1 != null) {
                      var status = value1["success"] ?? false;
                      var msg = value1["message"] ?? AppUrl.warningMSG;
                      var data=value1['data'];
                      if(data!=null){
                        if (status) {
                          // Provider.of<DashboardProvider>(context, listen: false).fetchWallet();
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context)=>CodeCheckSuccessScreen(
                            msg: msg,
                            code:value1['data']['codeNumber']??0,
                            codedate:value1['data']['codecheckeddate']??"",
                            point:value1['data']['points']??"",
                            codtype:value1['data']['codeType']??"",
                            status:value1['data']['status']??"",
                          )));
                        } else {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context)=>CodeCheckFailedScreen(
                            msg: msg,
                            code:value1['data']['codeNumber']??0,
                            codedate:value1['data']['codecheckeddate']??"",
                            point:value1['data']['points']?.toString()?? "",
                            codtype:value1['data']['codeType']??"",
                            status:value1['data']['status']??"",
                          )));
                          // CustomAlert.showMessage(
                          //     context, "Info", msg.toString(), AlertType.info);
                        }
                      }else{
                        CustomAlert.showMessage(
                            context, "Info", msg.toString(), AlertType.info);
                      }
                    } else {
                      scanner_provider.startCemra();
                      // toastRedC(AppUrl.warningMSG);
                    }
                    codeCheckController.clear();
                  } else {
                    toastRedC("Please Enter 13 digit code");
                  }
                },
                buttonColor: AppColor.app_btn_color,
                textColor: AppColor.white_color,
                widget: scanner_provider.isloaing_appcodeck ? CircularProgressIndicator(
                  color: AppColor.white_color,
                  strokeAlign: 0,
                  strokeWidth: 4,
                ) : CustomText(
                  text: LocalizationEN.verify_btn,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:  AppColor.white_color,
                ),
              ),
            );
          }),

        ],
      ),
    );
  }
}