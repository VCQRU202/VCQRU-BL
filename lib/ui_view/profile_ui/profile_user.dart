import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/profile_ui/profile_details.dart';

import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../res/shared_preferences.dart';
import '../../res/values/values.dart';
import '../blogs/blogs_ui.dart';
import '../claim_history_ui/claim_history_ui.dart';
import '../e_kyc_ui/e_kyc_main_dashboard.dart';
import '../gift_claim/gift_claim.dart';
import '../mobile_enter/mobile_enter_screen.dart';
import '../report_issues/raised_issues_ui.dart';

class ProfilePage extends StatelessWidget {
  final double profileCompletion = 0.9; // 90% profile completion (dynamic)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE1D7FF), Color(0xFFFDE0E7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/profile.png'),
                                        radius: 30,
                                      ),
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
                                    width:
                                        MediaQuery.of(context).size.width - 64,
                                    // Adjust width based on padding
                                    lineHeight: 8.0,
                                    percent: getValidatedPercent(valustate.profile!.percent.toString()),
                                    // Dynamic percentage
                                    backgroundColor: Colors.grey.shade300,
                                    progressColor: getValidatedPercent(valustate.profile!.percent.toString()) == 1.0
                                        ? Colors.green // Green for 100%
                                        : Colors.red,
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
                        // buildMenuItem(Icons.settings, 'Setting', context),
                        // Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.card_giftcard,
                            'Gift',
                            context,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GiftClaimUI()));
                        }
                        ),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.account_balance_wallet, 'Wallet', context,onTap: (){

                        }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.file_copy_sharp, 'Claim History', context,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ClaimScreen()));
                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.document_scanner_outlined, 'Code Details', context,
                            onTap: (){

                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.supervised_user_circle_rounded, 'KYC Details', context,
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>KycMainScreenDashboard()));

                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.collections_bookmark, 'Product Catalogue', context,
                            onTap: (){

                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.image, 'Brochure', context,
                            onTap: (){

                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.bar_chart_sharp, 'TDS', context,
                            onTap: (){

                            }),
                        Divider(color: Colors.grey.shade300),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.bookmarks_rounded, 'Blogs', context,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen()));
                            }),
                        Divider(color: Colors.grey.shade300),

                        buildMenuItem(Icons.record_voice_over, 'Choose Language', context,
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen()));
                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.help_outline_rounded, 'Help & Support', context,
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen()));
                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.smartphone_outlined, 'About Us', context,
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen()));
                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(FontAwesomeIcons.bookOpen, 'Terms & Condition', context,
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen()));
                            }),
                        Divider(color: Colors.grey.shade300),
                        buildMenuItem(Icons.perm_contact_cal, 'Contact Us', context,
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen()));
                            }),
                        Divider(color: Colors.grey.shade300),


                        // buildMenuItem(Icons.language, 'Choose Language', context),
                        // Divider(color: Colors.grey.shade300),
                        // buildMenuItem(Icons.card_giftcard, 'Refer & Earn', context),
                        // Divider(color: Colors.grey.shade300),
                        // buildMenuItem(Icons.article, 'Blogs', context),
                        // // Divider(color: Colors.grey.shade300),
                        // buildMenuItem(Icons.help_outline, 'Help & Support', context),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )),
              // Logout Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _presentBottomSheetLogoutConfirm(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
        return parsedValue / 100;
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
}
