import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/ekyc_providers/kyc_main_page_provider.dart';
import '../../../providers_of_app/ekyc_providers/pancard_verify_provider/pancard_verify_provider.dart';
import '../../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/app_colors/Checksun_encry.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../../res/components/circle_loader.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../../res/shared_preferences.dart';

class PanCardVerifyUI extends StatefulWidget {
  const PanCardVerifyUI({super.key});

  @override
  State<PanCardVerifyUI> createState() => _PanCardVerifyUIState();
}

class _PanCardVerifyUIState extends State<PanCardVerifyUI> {
  final _formKey = GlobalKey<FormState>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PanVerificationProvider>(context, listen: false).loadAccountHolderName();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PanVerificationProvider>(context);
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.clearData();
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
              children: [
                // Scrollable content
                Expanded(
                  child: ListView(
                    children: [
                      // Back arrow
                      Container(
                        color: splashProvider.color_bg,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                provider.clearData();
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                            ),
                          ],
                        ),
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
                              // PAN number text field
                              Text(
                                'Pan Card',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please input your pan number and full name',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Pan Number",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextFormField(
                                controller: provider.panController,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 5),
                                  hintText: 'Enter your PAN number.',
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),

                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),UpperCaseTextFormatter(),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Pan number is required';
                                  } else if (!RegExp(
                                          r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$')
                                      .hasMatch(value)) {
                                    return 'Invalid PAN Number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 6),
                              // Name text field
                              Text(
                                "Name",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextFormField(
                                controller: provider.nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 5),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is required';
                                  } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                      .hasMatch(value)) {
                                    return 'Name can only contain alphabets';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 6),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Fixed submit button

                Consumer<PanVerificationProvider>(
                  builder: (context, provider, child) {
                    return   Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                           // Provider.of<KYCMainProvider>(context, listen: false).setAadhar("1");
                           // showSuccessBottomSheet(context);
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, you can proceed with further actions
                              presentBottomProgress(context,provider.panController.text);
                              var value1 = await provider.submitPanForm(
                                  provider.panController.text,
                                  provider.nameController.text
                              );
                              Navigator.pop(context);
                              if (value1 != null) {
                                var status = value1["success"] ?? false;
                                var msg = value1["message"] ?? AppUrl.warningMSG;
                                if (status) {
                                  provider.panController.clear();
                                  provider.nameController.clear();
                                  var data=value1["data"];
                                  if(data!=null){
                                    var resultData = value1["data"]["IspanVerify"]??false;
                                    var name = value1["data"]["PanName"]??"";
                                    await SharedPrefHelper().save("Name", name.toString());
                                    if(resultData){
                                      Provider.of<KYCMainProvider>(context, listen: false).setPanKyc("1");
                                      var vty=Provider.of<KYCMainProvider>(context, listen: false);
                                      vty.setKYCMAIN(1);
                                      showSuccessBottomSheet(context);
                                    }
                                  }
                                } else {
                                  Provider.of<KYCMainProvider>(context, listen: false).setPanKyc("2");
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
                            backgroundColor: splashProvider.color_bg,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: provider.isLoadingPan ? CircularProgressIndicator(
                            color: AppColor.white_color,
                            strokeAlign: 0,
                            strokeWidth: 4,
                          ) :Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ); // Default UI
                  },
                ),
              ],
            )),
      ),
    );
  }
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
            Text('Your PAN Card has been successfully verified with your account. Please, check status'),
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
                Text("Verify your Pan No ${obscuredPan}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
