import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:vcqru_bl/res/app_colors/Checksun_encry.dart';

import '../../providers_of_app/banner_provider/banner_provider.dart';
import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/circle_profile.dart';
import '../../res/components/custom_text.dart';
import '../../res/values/images_assets.dart';
import '../../res/values/values.dart';
import '../blogs/blogs_ui.dart';
import '../claim_history_ui/claim_history_ui.dart';
import '../code_check_history_ui/code_check_history.dart';
import '../code_details_ui/code_details_ui.dart';
import '../e_kyc_ui/e_kyc_main_dashboard.dart';
import '../e_kyc_ui/e_kyc_main_ui.dart';
import '../gift_claim/gift_claim.dart';
import '../gift_claim/success_msg_claim.dart';
import '../help_support_ui/help_support_ui.dart';
import '../notifications/notification_ui.dart';
import '../product_catlogs/product_catlog_list.dart';
import '../profile_ui/profile_user.dart';
import '../referral_ui/referral_ui_share.dart';
import '../report/report_main_ui.dart';
import '../scanner_ui/scanner_ui.dart';
import '../tset_ui/test_ui.dart';
import '../wallets/wallet_balance_with_points.dart';
import 'banner_widget.dart';

import 'package:badges/badges.dart' as badges;

import 'dashboard_component.dart';
class DashboardApp extends StatefulWidget {
  DashboardApp({super.key});

  @override
  State<DashboardApp> createState() => _Dashboard_vcqruState();
}

class _Dashboard_vcqruState extends State<DashboardApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(_selectedIndex==1){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>ReportMainUI()));
    }
    if(_selectedIndex==2){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>ProfilePage()));

    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DashboardProvider>(context, listen: false).fetchWallet();
    Provider.of<DashboardProvider>(context, listen: false).getKYCSTATUS();
    Provider.of<DashboardProvider>(context, listen: false).getProfile();
    Provider.of<DashboardProvider>(context, listen: false).getDashboardIName();
  }
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    // Simulating network request\
    Provider.of<DashboardProvider>(context, listen: false).fetchWallet();
    Provider.of<DashboardProvider>(context, listen: false).getKYCSTATUS();
    Provider.of<DashboardProvider>(context, listen: false).getProfile();
    Provider.of<BannerProvider>(context, listen: false).getBanner();
  }
  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashboardProvider>(context, listen: false);
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffF8F9FAFF),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: _buildIconWithIndicator(
              icon: Icons.home,
              isSelected: _selectedIndex == 0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithIndicator(
              icon: Icons.bar_chart,
              isSelected: _selectedIndex == 0,
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithIndicator(
              icon: Icons.person,
              isSelected: _selectedIndex == 0,
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),

      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE1E1F6), Color(0xFFE4E4E7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    gradient: SweepGradient(
                      center: Alignment(0.11, 0.76),
                      startAngle: -0.78,
                      endAngle: -0.11,
                      colors: [
                        splashProvider.color_bg,
                        splashProvider.color_bg],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x1E000000),
                        blurRadius: 16,
                        offset: Offset(0, 12),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                     // ---------------------profile --------------
                      Consumer<DashboardProvider>(
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
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            splashProvider.color_bg,
                                            splashProvider.color_bg,
                                          ],
                                          begin: const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 0.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
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

                                return Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16,left: 16), // Adjust as needed
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //CircleAvatar(),
                                        // GestureDetector(
                                        //   onTap: (){
                                        //     Navigator.push(context,
                                        //         MaterialPageRoute(builder: (context)=>ProfilePage()));
                                        //   },
                                        //   child: Container(
                                        //     width: 40,
                                        //     height: 40,
                                        //     decoration: BoxDecoration(
                                        //         borderRadius: BorderRadius.circular(8),
                                        //         border: Border.all(width: 1.0, color: Colors.white),
                                        //         color: Color(0xFFFFFFFF)),
                                        //     padding: EdgeInsets.all(5),
                                        //     child: Center(child: Image.asset('assets/logo.png')),
                                        //   ),
                                        // ),
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
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context)=>ProfilePage()));
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


                                      const SizedBox(width: 10),
                                        // Second Widget
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: "Hello, ${valustate.profile?.consumerName?.isNotEmpty == true
                                                  ? valustate.profile!.consumerName.toString().split(' ')[0] : 'User'}",
                                              color: AppColors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            Text("${valustate.profile?.mobileNo}",
                                              style: TextStyle(color: Colors.white),)
                                            // Row(
                                            //   children: [
                                            //     CustomText(
                                            //       text: _getKYCStatusText(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                            //       color: _getKYCStatusColor(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                            //       fontSize: 12,
                                            //     ),
                                            //     const SizedBox(width: 4), // Spacing between text and icon
                                            //     Icon(
                                            //       _getKYCStatusIcon(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                            //       color: _getKYCStatusColor(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                            //       size: 16,
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                        const SizedBox(width: 50),
                                        // Third Widget
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 15),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  // Navigate to notification screen
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => NotificationsPage()),
                                                  );
                                                },
                                                icon: Stack(
                                                  clipBehavior: Clip.none, // Allow the badge to overflow
                                                  children: [
                                                    // Notification Icon
                                                    Icon(
                                                      Icons.notifications,
                                                      color: Colors.white,
                                                      size: 26,
                                                    ),

                                                    // Badge (Only show if count > 0)
                                                    if (valustate.countNotication! > 0)
                                                      Positioned(
                                                        top: -8, // Adjust position to move slightly above
                                                        right: -4, // Adjust position to move slightly right
                                                        child: Container(
                                                          padding: EdgeInsets.all(4), // Padding for badge
                                                          decoration: BoxDecoration(
                                                            color: Colors.red, // Badge color
                                                            shape: BoxShape.circle, // Circular badge
                                                          ),
                                                          constraints: BoxConstraints(
                                                            minWidth: 18, // Minimum width
                                                            minHeight: 18, // Minimum height
                                                          ),
                                                          child: Text(
                                                            valustate.countNotication.toString(), // Notification count
                                                            style: TextStyle(
                                                              color: Colors.white, // Text color
                                                              fontSize: 11, // Text size
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
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
                                );
                              }
                            }
                          }),
                     // ---------------------wallet and points--------------
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 20,left: 16,right: 16),
                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFFFFF).withOpacity(0.16),
                        ),
                        child: Consumer<DashboardProvider>(
                            builder: (context, valustate, child) {
                              if (valustate.isLoading_wallet) {
                                return Center(
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        margin: EdgeInsets.only(top: 10),
                                        child: CircularProgressIndicator()));
                              } else {
                                if (valustate.hasError_wallet) {
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                    // decoration: BoxDecoration(
                                    //     gradient: LinearGradient(
                                    //         colors: [
                                    //           const Color(0xFF3366FF),
                                    //           const Color(0xFF00CCFF),
                                    //         ],
                                    //         begin: const FractionalOffset(0.0, 0.0),
                                    //         end: const FractionalOffset(1.0, 0.0),
                                    //         stops: [0.0, 1.0],
                                    //         tileMode: TileMode.clamp),
                                    //     borderRadius:
                                    //     BorderRadius.all(Radius.circular(10))),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(' ${valustate.errorMessage_wallet}'),
                                          ElevatedButton(
                                            onPressed: () {
                                              valustate.retryFetchWallet();
                                            },
                                            child: Text('Retry'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  String total_point = valustate.dashbaord!.totalPoint ?? "0";
                                  String transferred_point = valustate.dashbaord!.reedemPoint ?? "0";
                                  var points;
                                  if(total_point.isNotEmpty&&transferred_point.isNotEmpty){
                                    var e = double.parse(total_point);
                                    var f = double.parse(transferred_point);
                                   var points1 = e - f;
                                  //  points =points1.toString();
                                    points =points1 % 1 == 0 ? points1.toInt().toString() : points1.toString();
                                  }else{
                                    points="0";
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 15, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(total_point,style: TextStyle(fontSize: 20,
                                                  fontWeight: FontWeight.bold,color: Colors.white)),
                                              Text("Total Points",style: TextStyle(fontSize: 14,color: Colors.white),)
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(transferred_point,style: TextStyle(fontSize: 20,
                                                  fontWeight: FontWeight.bold,color: Colors.white)),
                                              Text("Redeem Points",style: TextStyle(fontSize: 14,color: Colors.white),)
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(points,style: TextStyle(fontSize: 20,
                                                  fontWeight: FontWeight.bold,color: Colors.white)),
                                              Text("Balance Points",style: TextStyle(fontSize: 14,color: Colors.white),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 0,right: 0,top: 15),
                    child: BannerWidget()
                ),
                Consumer<DashboardProvider>(
                    builder: (context, valustate, child) {
                      if (valustate.isloading_kycs) {
                        return Center(
                            child: Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.only(top: 10),
                                child: CircularProgressIndicator()));
                      } else {
                        if (valustate.hasError_kycs) {
                          return Container(
                            width: double.infinity,
                            margin:
                            EdgeInsets.only(top: 15, left: 10, right: 10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF3366FF),
                                      const Color(0xFF00CCFF),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(' ${valustate.errorMessage_kycs}'),
                                  ElevatedButton(
                                    onPressed: () {
                                      valustate.retryKYCSTATUS();
                                    },
                                    child: Text('Retry'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Visibility(
                            visible:dashProvider.kycStatus.endsWith("Approved")?false:true,
                            child: Container(
                                margin:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    // _presentBottomSheet(context);
                                  },
                                  child: Card(
                                    color: AppColor.kyc_color,
                                    elevation: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  width: 45,
                                                  height: 40,
                                                  margin: EdgeInsets.only(
                                                      right: 15, bottom: 5),
                                                  child:dashProvider.kycStatus!.endsWith("Approved")?Image.asset(
                                                    "assets/verify.png",
                                                    width: 15,
                                                    height: 15,
                                                  ):(dashProvider.kycStatus!.endsWith("Pending")?Image.asset(
                                                    "assets/pending.png",
                                                    width: 15,
                                                    height: 15,
                                                  ):Image.asset(
                                                    "assets/reject.png",
                                                    width: 15,
                                                    height: 15,
                                                  )
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Expanded(
                                                flex: 9,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                                  children: [
                                                    Text(
                                                      dashProvider.kycStatus!
                                                          .endsWith("Approved")
                                                          ? "Your KYC Completed"
                                                          : "Complete Your KYC",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    Text(
                                                      dashProvider.kycStatus!
                                                          .endsWith("Approved")
                                                          ? "VERIFIED"
                                                          : (dashProvider
                                                          .kycStatus!
                                                          .endsWith("Pending")
                                                          ? "KYC is pending"
                                                          : "REJECTED"),
                                                      style: TextStyle(
                                                        color: dashProvider
                                                            .kycStatus!
                                                            .endsWith("Approved")
                                                            ? Colors.green
                                                            : Colors.red,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context)=>KycMainScreenDashboard()));
                                                },
                                                child: Visibility(
                                                  visible:dashProvider.kycStatus!
                                                      .endsWith("Approved")
                                                      ? false
                                                      : (dashProvider.kycStatus!
                                                      .endsWith("Pending")
                                                      ? true
                                                      : true),
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Click Here",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.green),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          );
                        }
                      }
                    }),
                DashboardGrid(),
SizedBox(height: 50,)
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           padding: EdgeInsets.only(top: 9,bottom: 9),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               color: Colors.white
//
//                           ),
//                           child: GestureDetector(
//                             onTap: (){
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context)=>GiftClaimUI()));
//                             },
//                             child: icon_contianer_middle(
//                               image_name: ImagesAssets.dashboard_loyality_imgage,
//                               colour: Color(0xFF52D5BA),
//                               title: "Gift",
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           padding: EdgeInsets.only(top: 9,bottom: 9),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               color: Colors.white
//
//                           ),
//                           child:  GestureDetector(
//                             onTap: (){
//                              // toastRedC("Coming Soon");
//                               print("------click----");
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context)=>ReferEarn()));
//                             },
//                             child: icon_contianer_middle(
//                                 title: "Refer & Earn",
//                                 image_name: ImagesAssets.refer_image,
//                                 colour: Color(0xFF05AE25)
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               color: Colors.white
//
//                           ),
//                           padding: EdgeInsets.only(top: 9,bottom: 9),
//                           child: GestureDetector(
//                             onTap: (){
//                              // toastRedC("Coming Soon");
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context)=>WalletWithPoints()));
//
//                             },
//                             child: icon_contianer_middle(
//                                 title: "Wallet",
//                                 image_name: ImagesAssets.dashboard_wallet_image,
//                                 colour: Color(0xFF5207F7)
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),),
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           padding: EdgeInsets.only(top: 9,bottom: 9),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                             color: Colors.white
//
//                           ),
//                           child: GestureDetector(
//                             onTap: (){
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>HistroyCodeCheck()));
//                             },
//                             child: icon_contianer_middle(
//                               image_name: ImagesAssets.dashboard_history_image,
//                               colour: Color(0xFFEB3678),
//                               title: "History",
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           padding: EdgeInsets.only(top: 9,bottom: 9),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               color: Colors.white
//
//                           ),
//                           child:  GestureDetector(
//                             onTap: (){
//                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
//                               //toastRedC("Coming Soon");
//                             },
//                             child: icon_contianer_middle(
//                                 title: "Blog",
//                                 image_name: ImagesAssets.blog_image,
//                                 colour: Color(0xFFFB6B18)
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               color: Colors.white
//
//                           ),
//                           padding: EdgeInsets.only(top: 9,bottom: 9),
//                           child: GestureDetector(
//                             onTap: (){
//                              // toastRedC("Coming Soon");
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductCatListPage()));
//
//                             },
//                             child: icon_contianer_middle(
//                                 title: "Catalogue",
//                                 image_name: ImagesAssets.catlog_image,
//                                 colour: Color(0xFFED2B2A)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),),
// //-----dyanmic icom image ,name
//                 Container(
//                   margin: EdgeInsets.only(left: 10,right: 10,bottom: 80),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: GestureDetector(
//                           onTap: (){
//                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>HistroyCodeCheck()));
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupportUI()));
//                           },
//                           child: Container(
//                             padding: EdgeInsets.only(top: 9,bottom: 9),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.all(Radius.circular(8)),
//                                 color: Colors.white
//
//                             ),
//                             child: icon_contianer_middle(
//                                 title:"Help",
//                                 image_name: ImagesAssets.help_image,
//                                 colour: Color(0xFFFF1515)),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           padding: EdgeInsets.only(top: 9,bottom: 9),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               color: Colors.white
//
//                           ),
//                           child:  GestureDetector(
//                             onTap: (){
//                               // Navigator.push(context,
//                               //     MaterialPageRoute(builder: (context)=>GiftClaimUI()));
//
//                                toastRedC("Coming Soon");
//                             },
//                             child: icon_contianer_middle(
//                                 title: "Brochure",
//                                 image_name: ImagesAssets.brocher_image,
//                                 colour: Color(0xFFED2B2A)),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           padding: EdgeInsets.only(top: 9,bottom: 9),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               color: Colors.white
//
//                           ),
//                           child:  GestureDetector(
//                             onTap: (){
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context)=>CodeDetail()));
//                              // toastRedC("Coming Soon");
//                             },
//                             child: icon_contianer_middle(
//                               title: "Code Details",
//                               image_name: ImagesAssets.code_check_image,
//                               colour: Color(0xFFFB6B18),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        label: Text("Scan",style: TextStyle(color: Colors.white),),
        icon: Icon(Icons.qr_code_rounded,color: Colors.white,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewExample()));
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScanScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  String _getKYCStatusText(int? status) {
    switch (status) {
      case 0:
        return "Pending";
      case 1:
        return "Verified";
      case 2:
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  Color _getKYCStatusColor(int? status) {
    switch (status) {
      case 0:
        return Colors.orange; // Pending - Orange color
      case 1:
        return Colors.green; // Verified - Green color
      case 2:
        return Colors.red; // Rejected - Red color
      default:
        return Colors.grey; // Unknown - Grey color
    }
  }

  IconData _getKYCStatusIcon(int? status) {
    switch (status) {
      case 0:
        return Icons.hourglass_top; // Pending
      case 1:
        return Icons.verified; // Verified
      case 2:
        return Icons.cancel; // Rejected
      default:
        return Icons.help_outline; // Unknown
    }
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



  Widget _buildIconWithIndicator({required IconData icon, required bool isSelected}) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Icon(icon),
        if (isSelected)
          Positioned(
            top: -5, // Adjust to align with your design
            child: Icon(
              Icons.circle,
              color: Colors.yellow,
              size: 10, // Size of the yellow indicator
            ),
          ),
      ],
    );
  }
}

class icon_contianer_middle extends StatelessWidget {
  String? image_name;
  Color colour;
  String? title;

  icon_contianer_middle({required this.title, required this.image_name, required this.colour});

  @override
  Widget build(BuildContext context) {
    return dashboard_top(
        image_name: image_name!, //"claim_history.png",
        colour: colour!, //App_Colors.App_Claim_history_Color,
        title: title! //'Claim History'
    );
  }
}

class dashboard_top extends StatelessWidget {
  String? image_name;
  Color colour;
  String? title;

  dashboard_top(
      {required this.image_name, required this.colour, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icons_vcqru(
          imgScr: image_name,
          icon_color: colour,
        ),
        Text(title!)
      ],
    );
  }
}

class Icons_vcqru extends StatelessWidget {
  String? imgScr;
  Color icon_color;

  Icons_vcqru({required this.imgScr, required this.icon_color});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(icon_color, BlendMode.srcIn),
        child: Image.asset(
          '${ImagesAssets.asset}$imgScr',
          height: 40,
        ));
  }
}

