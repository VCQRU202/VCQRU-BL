import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/profile_ui/profile_details.dart';

import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/components/circle_profile.dart';
import '../../res/shared_preferences.dart';
import '../../res/values/values.dart';
import '../blogs/blogs_ui.dart';
import '../claim_history_ui/claim_history_ui.dart';
import '../code_details_ui/code_details_ui.dart';
import '../e_kyc_ui/e_kyc_main_dashboard.dart';
import '../gift_claim/gift_claim.dart';
import '../help_support_ui/help_support_ui.dart';
import '../mobile_enter/mobile_enter_screen.dart';
import '../product_catlogs/product_catlog_list.dart';
import '../referral_ui/referral_ui_share.dart';
import '../report_issues/raised_issues_ui.dart';
import '../tds_ui/tds_ui.dart';
import '../wallets/wallet_balance_with_points.dart';

class ProfilePage extends StatelessWidget {
  final double profileCompletion = 0.9; // 90% profile completion (dynamic)

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        backgroundColor: splashProvider.color_bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.notifications_none, color: Colors.white),
        //     onPressed: () {},
        //   ),
        // ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView(
              children: [
                // Profile Heading
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Profile Info Container
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(left: 16,right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Consumer<DashboardProvider>(
                      builder: (context, valustate, child) {
                    if (valustate.isloading_profile) {
                      return Center(
                          child: Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.only(top: 10),
                              child: CircularProgressIndicator()));
                    } else {
                      if (valustate.hasError_profile) {
                        return Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(top: 15, left: 10, right: 10),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${valustate.errorMessage_profile}'),
                                ElevatedButton(
                                  onPressed: () {
                                    valustate.retryProfile();
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileDetail()));
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    // Profile Picture
                                    SizedBox(
                                      width: 42,
                                      height: 42,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // Custom painter for the circular progress
                                          CustomPaint(
                                            painter: CircularPaint(
                                              progressValue: getValidatedPercent(valustate.profile!.percent.toString()), // Set your progress here [0.0 - 1.0]
                                              borderThickness: 4.0, // Adjust the thickness
                                            ),
                                            child: const SizedBox.expand(),
                                          ),
                                          // Inner blue circle with centered text
                                          GestureDetector(
                                            onTap: (){
                                           },
                                            child: Container(
                                              width: 35, // Adjusted for smaller size
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.blue, // Inner blue circle
                                                shape: BoxShape.circle,
                                              ),
                                              child:  Center(
                                                child:Text(
                                                  valustate.profile?.consumerName?.isNotEmpty == true
                                                      ? getInitials(valustate.profile!.consumerName) // Use initials
                                                      : 'U', // Default fallback for User
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   backgroundImage:
                                    //       AssetImage('assets/profile.png'),
                                    //   radius: 30,
                                    // ),
                                    SizedBox(width: 16),
                                    // Name and Phone Number
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valustate.profile?.consumerName.toString().split(' ')[0] ??
                                              "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          valustate.profile?.mobileNo ?? "",
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
                            // Profile Status Bar (Dynamic with percent_indicator)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Profile Status',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12)),
                                    Text(
                                      '${((int.tryParse(valustate.profile!.percent) ?? 0)).toInt()}% ',
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width - 64,
                                  // Adjust width based on padding
                                  lineHeight: 8.0,
                                  percent: getValidatedPercent(valustate.profile!.percent.toString()),
                                  // Dynamic percentage
                                  backgroundColor: Colors.grey.shade300,
                                  progressColor: getValidatedPercent(valustate.profile!.percent.toString()) == 1.0
                                      ? Colors.green // Green for 100%
                                      : splashProvider.color_bg,
                                  barRadius: Radius.circular(10),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    }
                  }),
                ),
                SizedBox(height: 20),
                // Menu Options with Dividers
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(left: 16,right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Consumer<DashboardProvider>(
                          builder: (context, valustate, child) {
                            if (valustate.isLoading) {
                              return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Please Wait"),
                                      CircularProgressIndicator(),
                                    ],
                                  ));
                            } else {
                              if (valustate.hasError) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(' ${valustate.errorMessage}'),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          valustate.retryDashboardIName();
                                        },
                                        child: Text('Retry'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                final filteredIcons = valustate.dashdynaData?.data?.sidebarIcons??[];
                                return Container(
                                  margin: EdgeInsets.only(left: 0,right: 8,bottom: 10,top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Colors.transparent),
                                  child:Container(
                                    width: double.infinity,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: filteredIcons.length,
                                      itemBuilder: (context, index) {
                                        final item = filteredIcons[index];
                                        return Container(
                                          padding: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            color: Colors.white,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              // // Handle item tap
                                              print(item.imagePath);
                                              if(item.id.toString().endsWith("gift")){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=>GiftClaimUI()));
                                              }else if(item.id.toString().endsWith("referandearn")){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=>ReferEarn()));
                                              }else if(item.id.toString().endsWith("wallet")){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=>WalletWithPoints()));
                                              }else if(item.id.toString().endsWith("claimhistory")){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClaimScreen()));                                                }else if(item.id.toString().endsWith("blog")){

                                              }else if(item.id.toString().endsWith("productcatalogue")){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductCatListPage()));
                                              }else if(item.id.toString().endsWith("help")){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupportUI()));
                                              }else if(item.id.toString().endsWith("kycdetails")){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=>KycMainScreenDashboard()));
                                              }else if(item.id.toString().endsWith("codedetails")){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=>CodeDetail()));
                                              }else if(item.id.toString().endsWith("brochure")){
                                                toastRedC("Coming Soon");
                                              }else if(item.id.toString().endsWith("tds")){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>TdsScren()));
                                              }else if(item.id.toString().endsWith("chooselanguage")){
                                                toastRedC("Coming Soon");
                                              }else if(item.id.toString().endsWith("helpandsupport")){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupportUI()));
                                              }else if(item.id.toString().endsWith("aboutus")){
                                                toastRedC("Coming Soon");
                                              }else if(item.id.toString().endsWith("blog")){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
                                              }else if(item.id.toString().endsWith("tremandcondition")){
                                                toastRedC("Coming Soon");
                                              }else if(item.id.toString().endsWith("contactus")){
                                                toastRedC("Coming Soon");
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.network(
                                                      item.imagePath?.trim() ??
                                                          "",
                                                      placeholderBuilder: (context) {
                                                        print('Image URL: ${item.imagePath}'); // Debugging URL
                                                        return CircularProgressIndicator(); // Show loading spinner
                                                      },
                                                      fit: BoxFit.contain,
                                                      color: Colors.grey,
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                    SizedBox(width: 8,),
                                                    Text(
                                                      item.iconName??"",
                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color:  Colors.grey, // Hide arrow for non-clickable items
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Divider(color: Colors.grey.shade300),
                                                SizedBox(height: 8,),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            }
                          })
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            )),
            // Logout Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                color: Colors.white,
              ),
              child: ElevatedButton(
                onPressed: () {
                  _presentBottomSheetLogoutConfirm(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: splashProvider.color_bg,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      IconData icon,
      String title,
      BuildContext context,
      {VoidCallback? onTap} // Nullable onTap (optional click)
      ) {
    return InkWell(
      onTap: onTap, // Allows null, making the item non-clickable if onTap is null
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: onTap != null ? Colors.grey : Colors.transparent, // Hide arrow for non-clickable items
            ),
          ],
        ),
      ),
    );
  }


  double getValidatedPercent(String? percent) {
    if (percent != null && percent.isNotEmpty) {
      double? parsedValue = double.tryParse(percent);
      if (parsedValue != null) {
        double normalizedPercent = parsedValue / 100;

        // Ensure the result is between 0.0 and 1.0
        if (normalizedPercent < 0.0) {
          return 0.0;
        } else if (normalizedPercent > 1.0) {
          return 1.0;
        }

        return normalizedPercent;
      }
    }
    return 0.0; // Return 0.0 as a default if validation fails
  }

  void _presentBottomSheetLogoutConfirm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(7),
            topRight: Radius.circular(7),
          ),
        ),
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 6, // 10%
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                left: 10, top: 0, right: 10),
                            child: const Text(
                              "Log out?",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 10, bottom: 15, top: 10, right: 50),
                      child: Text(
                        "Are you sure, you want to log out from the App",
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              child: const Text("Cancel",
                                  style: TextStyle(color: AppColors.black)),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(
                                              color: AppColors.grey)))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            flex: 4,
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            child: ElevatedButton(
                              child: const Text("Logout",
                                  style: TextStyle(color: AppColors.white)),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.dashboard_color),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.dashboard_color),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(
                                              color:
                                                  AppColors.dashboard_color)))),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await SharedPrefHelper().save("Verify", false);
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return MobileEnterScreen();
                                    },
                                  ),
                                  (_) => false,
                                );
                              },
                            ),
                            flex: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
  String getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return "U"; // Default to 'U' for User

    List<String> parts = name.trim().split(' '); // Split name by spaces
    String initials = '';

    // Get first character of the first part
    if (parts.isNotEmpty) initials += parts[0][0];

    // Get first character of the second part (if exists)
    if (parts.length > 1) initials += parts[1][0];
    else if (parts[0].length > 1) initials += parts[0][1]; // Fallback: Second letter of the first name

    return initials.toUpperCase(); // Ensure uppercase
  }
}
