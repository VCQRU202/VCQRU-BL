import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/e_kyc_ui/adhar_card/otp_screen_adhar.dart';

import '../../../providers_of_app/ekyc_providers/aadhar_verify_provider/aadhar_verify_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';
class AadharVerifyUI extends StatefulWidget {
  const AadharVerifyUI({super.key});

  @override
  State<AadharVerifyUI> createState() => _AdharCardVerifyUIState();
}

class _AdharCardVerifyUIState extends State<AadharVerifyUI> {
  final _formKey = GlobalKey<FormState>();
  final _aadharController = TextEditingController();


  @override
  void dispose() {
    _aadharController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE1D7FF), Color(0xFFFDE0E7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(child: ListView(
              children: [
                // Back arrow
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                // Form container
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pan number text field

                        // Title and description
                        Text(
                          'Aadhar card',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Aadhar Card Number",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextFormField(
                          controller: _aadharController,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 9,top: 5,bottom: 5),
                            hintText: 'Enter your Aadhar Card Number',
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Aadhar Card is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                ),
              ],
            )),



            Consumer<AadharVerifyProvider>(
              builder: (context, provider, child) {
                return Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, you can proceed with further actions
                         // showOtpBottomSheet(context,_aadharController.text.toString(),"");
                          var value1 = await provider.sendotpAadhar1(
                              _aadharController.text
                          );
                          if (value1 != null) {
                            var status = value1["Status"] ?? false;
                            var msg = value1["Message"] ?? AppUrl.warningMSG;
                            if (status) {
                              showOtpBottomSheet(context,_aadharController.text.toString(),"");
                            } else {
                              CustomAlert.showMessage(
                                  context, "", msg.toString(), AlertType.info);
                            }
                          } else {
                            toastRedC(AppUrl.warningMSG);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 1),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: provider.isLoading_otp ? CircularProgressIndicator(
                        color: AppColor.white_color,
                        strokeAlign: 0,
                        strokeWidth: 4,
                      ): Text(
                        'Submit',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ); // Default UI
              },
            ),
          ],
        ),
      ),
    );
  }
  void showOtpBottomSheet(BuildContext context,String aadh,String reId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
      ),
      builder: (BuildContext context) {
        return OtpBottomSheetAadhar(aadhar: aadh,requestId: reId,);
      },
    );
  }
}