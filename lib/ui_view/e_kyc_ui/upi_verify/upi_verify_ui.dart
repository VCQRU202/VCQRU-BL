import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/ekyc_providers/kyc_main_page_provider.dart';
import '../../../providers_of_app/ekyc_providers/upi_verify_provider/upi_verify_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/components/circle_loader.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';
class UpiIdVerifyUI extends StatefulWidget {
  const UpiIdVerifyUI({super.key});

  @override
  State<UpiIdVerifyUI> createState() => _UpiIdVerifyUIState();
}

class _UpiIdVerifyUIState extends State<UpiIdVerifyUI> {
  final _formKey = GlobalKey<FormState>();
  final _upiController = TextEditingController();

  @override
  void dispose() {
    _upiController.dispose();
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
                          'UPI',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please Enter your UPI ID',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "UPI Id",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextFormField(
                          controller: _upiController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 9,top: 5,bottom: 5),
                            hintText: 'Enter your UPI Id',
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'UPI ID cannot be empty';
                            }
                            if (!validateUpiID(value)) {
                              return 'Enter a valid UPI ID';
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



            Consumer<UPIVerifyProvider>(
              builder: (context, provider, child) {
                return Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: ElevatedButton(
                      onPressed: () async {
                        // showOtpBottomSheet(context,"987432211465","76ewgdsh");
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, you can proceed with further actions
                          // showOtpBottomSheet(context,_aadharController.text.toString(),"");

                          presentBottomProgress(context,_upiController.text);
                          var value1 = await provider.verifyUpi(
                              _upiController.text
                          );
                          Navigator.pop(context);
                          if (value1 != null) {
                            var status = value1["success"] ?? false;
                            var msg = value1["message"] ?? AppUrl.warningMSG;
                            if (status) {
                              var data=value1['data'];
                              if(data!=null){
                                var name=value1['data']['Consumername'];
                                Provider.of<KYCMainProvider>(context, listen: false).setUPI("1");
                                var vty=Provider.of<KYCMainProvider>(context, listen: false);
                                vty.setKYCMAIN(1);
                                showSuccessBottomSheet(context,name.toString());
                              }else{
                                CustomAlert.showMessage(
                                    context, "", msg.toString(), AlertType.info);
                              }
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
                      child: provider.isLoading_verify ? CircularProgressIndicator(
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
  bool validateUpiID(String value) {
    // Regex to check valid upi_Id
    String regex = r'^[a-zA-Z0-9.-]{2,256}@[a-zA-Z][a-zA-Z]{2,64}$';

    // Compile the RegExp
    RegExp regExp = RegExp(regex);

    // If the upi_Id is null, return false
    if (value == null) {
      return false;
    }

    // Use hasMatch() to find matching between given upiId and regex
    return regExp.hasMatch(value);
  }
  void showSuccessBottomSheet(BuildContext context,String name) {
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
              Text('Your UPI Id has been successfully verified with your account(${name}). Please, check status'),
            ],
          ),
        );
      },
    );
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
                  Text("Verify your UPI Id ${obscuredPan}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
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
}
