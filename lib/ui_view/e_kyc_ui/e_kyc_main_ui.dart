import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/e_kyc_ui/pancard_verify/pancard_verify_ui.dart';

import '../../providers_of_app/ekyc_providers/kyc_main_page_provider.dart';
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
    Provider.of<KYCMainProvider>(context, listen: false).getBrandSettingData();
    Provider.of<KYCMainProvider>(context, listen: false).getKYCSTATUS();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "KYC",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: AppColor.kyc_top_app_color,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColor.kyc_top_app_color,
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          )),
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
                            children: const [
                              Text(
                                "Welcome Vendor",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Thank you for choosing E-KYC. Please have the following requirements ready for the next steps.",
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
                if (valustate.isloading_kyc) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Please Wait"),
                      CircularProgressIndicator(),
                    ],
                  ));
                } else {
                  if (valustate.hasError_kyc) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(' ${valustate.errorMessage_kyc}'),
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
                              "The following is the information we want from you.",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            // Buttons Section
                            ...List.generate(3, (index) {
                              String title = "";
                              String subtitle = "";

                              if (index == 0) {
                                title = "Pan";
                                subtitle = "Provide your Name, Pan no and OTP.";
                              } else if (index == 1) {
                                title = "Aadhar";
                                subtitle =
                                    "Provide your Name, Aadhar no and OTP.";
                              } else {
                                title = "Bank";
                                subtitle =
                                    "Provide your Name, account no and IFSC.";
                              }

                              return GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PanCardVerifyUI()));
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AadharVerifyUI()));
                                  }
                                  if (index == 2) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountVerifyUI()));
                                  }

                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Visibility(
                                  visible:_isVisible(index, valustate),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: selectedIndex == index
                                            ? const Color(0xFF6F3CA4)
                                            : Colors.grey.shade300,
                                        width: selectedIndex == index ? 2 : 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
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
                                            color: selectedIndex == index
                                                ? const Color(0xFF6F3CA4)
                                                : Colors.grey.shade300,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                color: selectedIndex == index
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: selectedIndex == index
                                                      ? const Color(0xFF6F3CA4)
                                                      : Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                subtitle,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 16),
                                        const SizedBox(width: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Skip",
                                  style: TextStyle(
                                    color: Color(0xFF6F3CA4),
                                    fontSize: 16,
                                  ),
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
      return valustate.panEnable.endsWith("Yes");
    } else if (index == 1) {
      return valustate.aadharEnable.endsWith("Yes");
    } else if (index == 2) {
      return valustate.accountEnable.endsWith("Yes");
    }
    return false; // Default case
  }
}
