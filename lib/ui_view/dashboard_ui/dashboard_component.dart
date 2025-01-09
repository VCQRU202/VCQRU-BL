import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../blogs/blogs_ui.dart';
import '../code_check_history_ui/code_check_history.dart';
import '../code_details_ui/code_details_ui.dart';
import '../gift_claim/gift_claim.dart';
import '../help_support_ui/help_support_ui.dart';
import '../product_catlogs/product_catlog_list.dart';
import '../referral_ui/referral_ui_share.dart';
import '../wallets/wallet_balance_with_points.dart';
import 'network_url_svg.dart';

class DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Consumer<DashboardProvider>(
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
                final filteredIcons = valustate.dashdynaData?.data?.dashboardIcons??[];
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.transparent),
                  child:Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
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
                              // Handle item tap
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
                            }else if(item.id.toString().endsWith("history")){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HistroyCodeCheck()));
                            }else if(item.id.toString().endsWith("blog")){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage()));
                            }else if(item.id.toString().endsWith("catalogue")){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductCatListPage()));
                            }else if(item.id.toString().endsWith("help")){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupportUI()));
                            }else if(item.id.toString().endsWith("brochure")){
                              toastRedC("Coming Soon");
                            }else if(item.id.toString().endsWith("codedetails")){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>CodeDetail()));
                            }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.network(
                                  item.imagePath?.trim() ??
                                  "",
                                  placeholderBuilder: (context) {
                                    print('Image URL: ${item.imagePath}'); // Debugging URL
                                    return CircularProgressIndicator(); // Show loading spinner
                                  },
                                  fit: BoxFit.contain,
                                  color: splashProvider.color_bg,
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  item.iconName??"NA",
                                  style: GoogleFonts.roboto(color: Colors.black,fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
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
          });
  }
}