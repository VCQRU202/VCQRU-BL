import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/ekyc_providers/account_verify_provider/account_verify_provider.dart';
import '../../../providers_of_app/ekyc_providers/kyc_main_page_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/components/circle_loader.dart';
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
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AccountVerifyProvider>(context, listen: false).loadAccountHolderName();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccountVerifyProvider>(context);
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
                            'Please Enter your bank account number and IFSC Code',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("Account Number",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                          buildTextField("Account Number", provider.accountNumberController,1),
                          SizedBox(height: 16),
                          Text("Re-enter Account Number",style: TextStyle(fontSize: 12),),
                          buildTextField("Re-enter Account Number", provider.reenterAccountNumberController,1),
                          SizedBox(height: 16),
                          Text("IFSC Code",style: TextStyle(fontSize: 12),),
                          buildTextField("IFSC Code", provider.ifscCodeController,3,
                            onChanged: (value) {
                            if(value!=null&&value.length==11){
                              Provider.of<AccountVerifyProvider>(context, listen: false).verifyIfsc(ifsc: value);
                            }
                           },),
                          SizedBox(height: 16),
                          Text("Bank Name",style: TextStyle(fontSize: 12),),
                          buildTextField("Bank Name", provider.bankNameController,2),
                          SizedBox(height: 16),
                          Text("Account Holder's Name",style: TextStyle(fontSize: 12),),
                          buildTextField("Account Holder's Name", provider.accountHolderController,2),
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
                            presentBottomProgress(context);
                            var value1 = await provider.verifyAccount(
                              account: provider.accountNumberController.text,
                                name: provider.accountHolderController.text,
                                bankname: provider.bankNameController.text,
                                ifsc: provider.ifscCodeController.text
                            );
                            Navigator.pop(context);
                            if (value1 != null) {
                              var status = value1["success"] ?? false;
                              var msg = value1["message"] ?? AppUrl.warningMSG;
                              if (status) {
                                Provider.of<KYCMainProvider>(context, listen: false).setBank("1");
                                var vty=Provider.of<KYCMainProvider>(context, listen: false);
                                vty.setKYCMAIN(1);
                                showSuccessBottomSheet(context);
                              } else {
                                Provider.of<KYCMainProvider>(context, listen: false).setBank("2");
                                var vty=Provider.of<KYCMainProvider>(context, listen: false);
                                vty.setKYCMAIN(1);
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
  void showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Prevent user from dismissing manually
      enableDrag: false, // Disable drag-to-dismiss
      builder: (context) {
        // Start a timer to close the bottom sheet after 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.of(context).canPop()) {
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
              Text('Your Bank has been successfully verified with your account. Please, check status'),
            ],
          ),
        );
      },
    );
  }

  void presentBottomProgress(BuildContext context) {

   // String obscuredPan = obscurePanCardNumber(adhar);
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
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  SpinKitCircle(color: Colors.red,size: 50,),
                  Text("Verify your Bank Account",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  Text("Wait for few seconds...")
                ],
              ),
            );
          });
        });
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
  Widget buildTextField(String label, TextEditingController controller, int type,{Function(String)? onChanged}) {
    return TextFormField(
      controller: controller,
      keyboardType: type == 1
          ? TextInputType.number
          : type == 2
          ? TextInputType.text
          : TextInputType.text,
      inputFormatters: type == 1
          ? [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(18)] // Only numbers allowed
          : type == 3
          ? [
            UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(11),
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
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

}