import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/ekyc_providers/account_verify_provider/account_verify_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';
import '../e_kyc_main_ui.dart';
import '../pancard_verify/pancard_verify_ui.dart';
class AccountVerifyUI extends StatefulWidget {
  AccountVerifyUI({super.key});

  @override
  State<AccountVerifyUI> createState() => _AadharVerifyUIState();
}

class _AadharVerifyUIState extends State<AccountVerifyUI> {
  final _formKey = GlobalKey<FormState>();
   TextEditingController accountNumberController= TextEditingController();
   TextEditingController reenterAccountNumberController= TextEditingController();
   TextEditingController bankNameController= TextEditingController();
   TextEditingController accountHolderController= TextEditingController();
   TextEditingController ifscCodeController= TextEditingController();

  @override
  void dispose() {
    accountNumberController = TextEditingController();
    reenterAccountNumberController = TextEditingController();
    bankNameController = TextEditingController();
    accountHolderController = TextEditingController();
    ifscCodeController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>KycMainScreen()));
        return true;
      },
      child: Scaffold(
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
      
              Expanded(
                  child: ListView(
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
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
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
                            'Bank',
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
                          SizedBox(height: 20),
                          Text("Account Number",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                          buildTextField("Account Number", accountNumberController,1),
                          SizedBox(height: 16),
                          Text("Re-enter Account Number",style: TextStyle(fontSize: 12),),
                          buildTextField("Re-enter Account Number", reenterAccountNumberController,1),
                          SizedBox(height: 16),
                          Text("IFSC Code",style: TextStyle(fontSize: 12),),
                          buildTextField("IFSC Code", ifscCodeController,3),
                          SizedBox(height: 16),
                          Text("Bank Name",style: TextStyle(fontSize: 12),),
                          buildTextField("Bank Name", bankNameController,2),
                          SizedBox(height: 16),
                          Text("Account Holder's Name",style: TextStyle(fontSize: 12),),
                          buildTextField("Account Holder's Name", accountHolderController,2),
                          SizedBox(height: 10),
      
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              Consumer<AccountVerifyProvider>(
                builder: (context, provider, child) {
                  return    Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, you can proceed with further actions
                            var value1 = await provider.verifyAccount(
                              account: accountNumberController.text,
                                ifsc: ifscCodeController.text
                            );
                            if (value1 != null) {
                              var status = value1["Status"] ?? false;
                              var msg = value1["Message"] ?? AppUrl.warningMSG;
                              if (status) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context)=>KycMainScreen()));
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
                        child: Text(
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
      ),
    );
  }
  Widget buildTextField(String label, TextEditingController controller, int type) {
    return TextFormField(
      controller: controller,
      keyboardType: type == 1
          ? TextInputType.number
          : type == 2
          ? TextInputType.text
          : TextInputType.text,
      inputFormatters: type == 1
          ? [FilteringTextInputFormatter.digitsOnly] // Only numbers allowed
          : type == 3
          ? [
            UpperCaseTextFormatter(),
            FilteringTextInputFormatter.deny(RegExp("[#,%,^,&,*,(,),-,{,},:,;,?,~,!,₹,+,@,=,÷,€,¥,¢]")),
      ] // Alphanumeric for IFSC
          : null, // No restrictions for other types
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 9, top: 5, bottom: 5),
        hintText: 'Please enter $label',
        labelStyle: TextStyle(color: Colors.black),
        errorStyle: TextStyle(color: Colors.red, fontSize: 11),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

}