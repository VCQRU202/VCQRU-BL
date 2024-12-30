import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/dashboard_ui/dashboard_ui.dart';
import 'package:vcqru_bl/ui_view/e_kyc_ui/pancard_verify/pancard_verify_ui.dart';
import 'package:vcqru_bl/ui_view/e_kyc_ui/upi_verify/upi_verify_ui.dart';

import '../../providers_of_app/ekyc_providers/kyc_main_page_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_button2.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/localization/localization_en.dart';
import '../../res/values/values.dart';
import 'account_verify/account_verify.dart';
import 'adhar_card/adhar_verify.dart';

class KycMainScreen extends StatefulWidget {
  const KycMainScreen({super.key});

  @override
  State<KycMainScreen> createState() => _KycMainScreenState();
}

class _KycMainScreenState extends State<KycMainScreen> {
  String datback = "";
  bool panstatus = false;
  int selectedIndex = -1;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<KYCMainProvider>(context, listen: false).getKYCSTATUS();
    Provider.of<KYCMainProvider>(context, listen: false).getCompanyName();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KYC",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>DashboardApp()));// Navigate back to the previous screen
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change your color here
        ),
        backgroundColor: AppColor.kyc_top_app_color,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColor.kyc_top_app_color,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE1D7FF), Color(0xFFFDE0E7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(color: AppColor.kyc_top_app_color)),
                      Expanded(child: Container(color: Colors.transparent)),
                    ],
                  ),
                  Align(
                    alignment: Alignment(0, 0.5),
                    child: Container(
                      width: double.infinity,
                      height: 110,
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          // Fit container within screen width
                          padding: EdgeInsets.only(
                            left: 8,
                            right: 8,
                            top: 6,
                          ),
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF769EF3), Color(0xFFE2BDF5)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Consumer<KYCMainProvider>(
                                builder: (context, kycP, child) {
                                  return Text(
                                    "Welcome",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              // Text(
                              //   "Welcome ${kycP.comName}",
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              SizedBox(height: 5),
                              Text(
                                "Complete your KYC to unlock exclusive loyalty benefits and rewards!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<KYCMainProvider>(
                  builder: (context, valustate, child) {
                if (valustate.isloading_kycs) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Please Wait"),
                      CircularProgressIndicator(),
                    ],
                  ));
                } else {
                  if (valustate.hasError_kycs) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(' ${valustate.errorMessage_kycs}'),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              valustate.retryFetchBrandsetting();
                            },
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Details to provide",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Please provide the following information, ensuring all details entered are valid and accurate.",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            // Buttons Section
                            Visibility(
                              visible:valustate.panEnable.toString().endsWith("Yes")?true:false,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width:  1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  gradient:valustate.pankycstatus.endsWith("0")?LinearGradient(
                                    colors: [
                                      Color(0xFFF9FAFB), Color(0xFFF9FAFB),Color(0xFFF9FAFB),// Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ):valustate.pankycstatus.endsWith("1")? LinearGradient(
                                    colors: [
                                      Color(0xFFBCFABF), // Lighter red
                                      Color(0xFFDAF8DC),
                                      Color(0xFFF6ECEC),
                                      // Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ):LinearGradient(
                                    colors: [
                                      Color(0xFFFABCBD), // Lighter red
                                      Color(0xFFF8DADA),
                                      Color(0xFFF6ECEC),// Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Step Number
                                    Container(
                                      width: screenHeight * 0.07,
                                      // Dynamic size for circle based on screen height
                                      height: screenHeight * 0.07,
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:valustate.pankycstatus.endsWith("1")?Colors.white: Colors.grey.shade300,
                                      ),
                                      child: Center(
                                        child:valustate.pankycstatus.endsWith("0")? Text(
                                          "${ 1}",
                                          style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ):valustate.pankycstatus.endsWith("1")?Icon(Icons.check_circle_rounded,color: Colors.green,):
                                        Icon(Icons.error,color: Colors.red,),
                                      ),
                                    ),
                                    // Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Pan",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:valustate.pankycstatus.endsWith("1")?
                                              Colors.black:Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            valustate.pankycstatus.endsWith("1")?"Verified": "Kindly provide your full name and PAN number.",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: valustate.pankycstatus.endsWith("1")?false:true,
                                      child: InkWell(
                                        onTap: () {
                                          // Your action here
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PanCardVerifyUI()));
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:valustate.aadharEnable.toString().endsWith("Yes")?true:false,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width:  1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  gradient:valustate.aadharkycstatus.endsWith("0")?LinearGradient(
                                    colors: [
                                      Color(0xFFF9FAFB), Color(0xFFF9FAFB),Color(0xFFF9FAFB)// Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ):valustate.aadharkycstatus.endsWith("2")? LinearGradient(
                                    colors: [
                                      Color(0xFFFABCBD), // Lighter red
                                      Color(0xFFF8DADA),
                                      Color(0xFFF6ECEC),// Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ):LinearGradient(
                                    colors: [
                                      Color(0xFFBCFABF), // Lighter red
                                      Color(0xFFDAF8DC),
                                      Color(0xFFF6ECEC),// Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Step Number
                                    Container(
                                      width: screenHeight * 0.07,
                                      // Dynamic size for circle based on screen height
                                      height: screenHeight * 0.07,
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:valustate.aadharkycstatus.endsWith("1")?Colors.white: Colors.grey.shade300,
                                      ),
                                      child: Center(
                                        child:valustate.aadharkycstatus.endsWith("0")? Text(
                                          "${ 2}",
                                          style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ):valustate.aadharkycstatus.endsWith("1")?Icon(Icons.check_circle_rounded,color: Colors.green,):
                                        Icon(Icons.error,color: Colors.red,),
                                      )
                                    ),
                                    // Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Aadhar",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:valustate.aadharkycstatus.endsWith("1")?
                                              Colors.black:Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            valustate.aadharkycstatus.endsWith("1")?"Verified":"Provide Aadhaar details to complete eKYC",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: valustate.aadharkycstatus.endsWith("1")?false:true,
                                      child: InkWell(
                                        onTap: () {
                                          // Your action here
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AadharVerifyUI()));
                                          print(valustate.kycbtn);
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:valustate.accountEnable.toString().endsWith("Yes")?true:false,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width:  1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  gradient:valustate.accountkycstatus.endsWith("0")?LinearGradient(
                                    colors: [
                                      Color(0xFFF9FAFB), Color(0xFFF9FAFB),Color(0xFFF9FAFB)// Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ):valustate.accountkycstatus.endsWith("1")? LinearGradient(
                                    colors: [
                                      Color(0xFFBCFABF), // Lighter red
                                      Color(0xFFDAF8DC),
                                      Color(0xFFF6ECEC),
                                      // Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ):LinearGradient(
                                    colors: [
                                      Color(0xFFFABCBD), // Lighter red
                                  Color(0xFFF8DADA),
                                  Color(0xFFF6ECEC),
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Step Number
                                    Container(
                                      width: screenHeight * 0.07,
                                      // Dynamic size for circle based on screen height
                                      height: screenHeight * 0.07,
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:valustate.accountkycstatus.endsWith("1")?Colors.white: Colors.grey.shade300,
                                      ),
                                      child: Center(
                                        child:valustate.accountkycstatus.endsWith("0")? Text(
                                          "${ 3}",
                                          style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ):valustate.accountkycstatus.endsWith("1")?Icon(Icons.check_circle_rounded,color: Colors.green,):
                                        Icon(Icons.error,color: Colors.red,),
                                      ),
                                    ),
                                    // Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Bank",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:valustate.accountkycstatus.endsWith("1")?
                                              Colors.black:Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            valustate.accountkycstatus.endsWith("1")?"Verified":
                                            "Please provide Your Bank Account number and IFSC code",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: valustate.accountkycstatus.endsWith("1")?false:true,
                                      child: InkWell(
                                        onTap: () {
                                          // Your action here
                                          print("Arrow icon clicked!");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AccountVerifyUI()));
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),
                            Visibility(
                              visible:valustate.upiEnable.toString().endsWith("Yes")?true:false,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width:  1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  gradient:valustate.upikycstatus.endsWith("0")?LinearGradient(
                                    colors: [
                                      Color(0xFFF9FAFB), Color(0xFFF9FAFB),Color(0xFFF9FAFB)// Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ):valustate.upikycstatus.endsWith("1")? LinearGradient(
                                    colors: [
                                      Color(0xFFBCFABF), // Lighter red
                                      Color(0xFFDAF8DC),
                                      Color(0xFFF6ECEC),
                                      // Darker red
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ):LinearGradient(
                                    colors: [
                                      Color(0xFFFABCBD), // Lighter red
                                      Color(0xFFF8DADA),
                                      Color(0xFFF6ECEC),
                                    ],
                                    begin: Alignment.topLeft, // Start of the gradient
                                    end: Alignment.bottomRight, // End of the gradient
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Step Number
                                    Container(
                                      width: screenHeight * 0.07,
                                      // Dynamic size for circle based on screen height
                                      height: screenHeight * 0.07,
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:valustate.upikycstatus.endsWith("1")?Colors.white: Colors.grey.shade300,
                                      ),
                                      child: Center(
                                        child:valustate.upikycstatus.endsWith("0")? Text(
                                          "${ 4}",
                                          style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ):valustate.upikycstatus.endsWith("1")?Icon(Icons.check_circle_rounded,color: Colors.green,):
                                        Icon(Icons.error,color: Colors.red,),
                                      ),
                                    ),
                                    // Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "UPI",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:valustate.upikycstatus.endsWith("1")?
                                              Colors.black:Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            valustate.upikycstatus.endsWith("1")?"Verified":
                                            "Provide your UPI Id.",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: valustate.upikycstatus.endsWith("1")?false:true,
                                      child: InkWell(
                                        onTap: () {
                                          // Your action here
                                          print("Arrow icon clicked!");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpiIdVerifyUI()));
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  valustate.setKycZero();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context)=>DashboardApp()));
                                },
                                child: const Text(
                                  "Skip",
                                  style: TextStyle(
                                    color: Color(0xFF6F3CA4),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: valustate.kycbtn==0?true:false,
                              child: Container(
                                margin: EdgeInsets.only(left: 15, right: 15,bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 10),
                                        child: CustomElevatedButton(
                                          onPressed: () async {
                                            // Your button action here
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => DashboardApp()));
                                          },
                                          buttonColor: AppColor.app_btn_color,
                                          textColor: AppColor.black_color,
                                          borderRadius: BorderRadius.circular(8.0),
                                          widget: CustomText(
                                            text: LocalizationEN.DASHBOARD,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: AppColor.white_color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
  bool _isVisible(int index, KYCMainProvider valustate) {
    if (index == 0) {
      return valustate.panEnable.endsWith("");
    } else if (index == 1) {
      return valustate.aadharEnable.endsWith("Yes");
    } else if (index == 2) {
      return valustate.accountEnable.endsWith("Yes");
    }
    return false; // Default case
  }
}
