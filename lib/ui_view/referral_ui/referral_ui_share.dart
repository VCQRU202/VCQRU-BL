import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcqru_bl/res/app_colors/app_colors.dart';
import 'package:vcqru_bl/ui_view/referral_ui/referral_report.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/referral_provider/referral_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/social_media.dart';


class ReferEarn extends StatefulWidget {
  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ReferralProvider>(context, listen: false).getReferCodeMsg();
  }
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
     // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: splashProvider.color_bg,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text("Refer & Earn",style: TextStyle(fontSize: 18,color: Colors.white),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF6F4FC),
                Color(0xFFECE7FA),
                Color(0xFFFDF1F4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                color: splashProvider.color_bg,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Consumer<ReferralProvider>(
                          builder: (context, valustate, child) {
                            if (valustate.isLoading_ref) {
                              return Center(
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      margin: EdgeInsets.only(top: 10),
                                      child: CircularProgressIndicator()));
                            } else {
                              if (valustate.hasError_ref) {
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
                                        Text('${valustate.errorMessage_ref}'),
                                        ElevatedButton(
                                          onPressed: () {
                                            valustate.retrygetReferCodeMsg();
                                          },
                                          child: Text('Retry'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                String referralCode = valustate.getCodeData?.data?.referralCode ?? "";
                                String referralContents = valustate.getCodeData?.data?.referralContents ?? "NA";
                                String referralpoint = valustate.getCodeData?.data?.referralpoint ?? "";

                                return Container(
                                  margin: EdgeInsets.only(top: 0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 150,
                                        child: Image.asset(
                                          'assets/refer.jpg',
                                        ),
                                      ),
                                      Text(
                                        "Refer Your friends and Earn",
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Invite your friends to earn with BL app, and get upto ${referralpoint} points and your friends can get upto.",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color:Color(0xFF5F5E62)
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Share your Referral code via",
                                        style: TextStyle(
                                            fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Your refferel code",
                                        style: TextStyle(
                                            fontSize: 12, fontWeight: FontWeight.bold,color:
                                        Color(0xFF5F5E62) ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),

                                      Container(
                                        child: DottedBorder(
                                          color: Colors.white,
                                          strokeWidth: 1,
                                          dashPattern: [5, 5],
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(10),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                            child: GestureDetector(
                                              onTap: () async {
                                                await Clipboard.setData(ClipboardData(text:referralCode.toString().split('.')[0]));
                                                toastGreen("Referral Code Copied");
                                              },
                                              child: Text(
                                                referralCode.toString(),
                                                style: TextStyle(
                                                    fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          // await Clipboard.setData(ClipboardData(text: "your text"));
                                          // isInstalled();
                                          // bool install=await isInstalled()??false;
                                          // if(install){
                                          //   shareReferral("hello");
                                          // }else{
                                          //   print("Whatsapp not installed ");
                                          // }
                                          print("----clik--reffer hsre--");
                                          shareGeneral(referralCode.split('.')[0], referralContents);
                                        },
                                        child: Container(
                                          width: 120,
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.green),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Share",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(width: 8,),
                                                Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                  size: 16,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How It's Works?",
                          style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: splashProvider.color_bg),
                              height: 40,
                              width: 40,
                              child: Icon(Icons.person_add_alt_1_outlined,color: Colors.white,size: 24,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                                    "Step 1 : Copy and share your referral code to friends.",
                                  style: GoogleFonts.roboto(color:Color(
                                      0xFF6B7280)),
                                )
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: splashProvider.color_bg),
                              height: 40,
                              width: 40,
                              child: Icon(Icons.folder_shared_outlined,color: Colors.white,size: 24,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                                  "Step 2: Ask Your friend to use your referral code while signing up in the app.",
                                  style: GoogleFonts.roboto(color:Color(
                                      0xFF6B7280)),
                                ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:splashProvider.color_bg),
                              height: 40,
                              width: 40,
                              child: Icon(Icons.currency_bitcoin_sharp,color: Colors.white,size: 24,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Step 3 : You both get rewards.",style: GoogleFonts.roboto(color:Color(
                                0xFF6B7280)),)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: splashProvider.color_bg),
                      child: TextButton(
                        onPressed: () {
                         // shareGeneral(valustate.profile!.referralCode??"".toString().split('.')[0]);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RefferelReport()));
                        },
                        child: Text(
                          "Invite Friend",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              )
              // Consumer<DashboardProvider>(
              //     builder: (context, valustate, child) {
              //       if (valustate.isloading_profile) {
              //         return Center(
              //             child: Container(
              //                 height: 40,
              //                 width: 40,
              //                 margin: EdgeInsets.only(top: 10),
              //                 child: CircularProgressIndicator()));
              //       } else {
              //         if (valustate.hasError_profile) {
              //           return Container(
              //             width: double.infinity,
              //             margin:
              //             EdgeInsets.only(top: 15, left: 10, right: 10),
              //             decoration: BoxDecoration(
              //                 gradient: LinearGradient(
              //                     colors: [
              //                       splashProvider.color_bg,
              //                       splashProvider.color_bg,
              //                     ],
              //                     begin: const FractionalOffset(0.0, 0.0),
              //                     end: const FractionalOffset(1.0, 0.0),
              //                     stops: [0.0, 1.0],
              //                     tileMode: TileMode.clamp),
              //                 borderRadius:
              //                 BorderRadius.all(Radius.circular(10))),
              //             child: Center(
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   Text('${valustate.errorMessage_profile}'),
              //                   ElevatedButton(
              //                     onPressed: () {
              //                       valustate.retryProfile();
              //                     },
              //                     child: Text('Retry'),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           );
              //         } else {
              //
              //           return  Container();
              //         }
              //       }
              //     }),
            ],
          ),
        ),
      ),
    );
  }
// Future<void> shareReferral(code) async {
//   // await WhatsappShare.share(
//   //   text: 'Hey!! Sign-up on the app using my referral code and get 100 '
//   //       'points.So sign-up now before the offer expires! \n Download the app :',
//   //   linkUrl: 'https://play.google.com/store/apps/details?id=com.app.orioapp',
//   // );
//   SocialShare.shareWhatsapp(
//     "Hey!! Sign-up on the  app using my referral code $code and get 100 points.So sign-up now before the offer expires! \n Download the app https://play.google.com/store/apps/details?id=com.app.orioapp ",
//   ).then((data) {
//     print(data);
//   });
// }
// Future<bool?> isInstalled() async {
//   final val = await WhatsappShare.isInstalled(package: Package.whatsapp);
//   return val;
// }
  Future<void> shareGeneral(String code,String msg) async {

    // Gneral Sharing
    await Share.share(msg).catchError((error) {
      print("Error sharing: $error");
    });
  }
  Future<void> shareReferral(code) async {
    // await WhatsappShare.share(
    //   text: 'Hey!! Sign-up on the orio app using my referral code and get 100 '
    //       'points.So sign-up now before the offer expires! \n Download the app :',
    //   linkUrl: 'https://play.google.com/store/apps/details?id=com.app.orioapp',
    // );
    SocialShare.shareWhatsapp(
      "Hey!! Sign-up on the app using my referral code $code and get 100 points.So sign-up now before the offer expires! ",
    ).then((data) {
      print(data);
    });
  }

  Future<void> shareReferralbuss(String code) async {
    String message = Uri.encodeComponent(
        "Hey!! Sign-up on the  app using my referral code $code and get 100 points. "
            "Sign up now before the offer expires!");

    bool installbuss=await isInstalledBuss()??false;

    String url = installbuss == true ? "whatsapp://send?text=$message"
        : "https://wa.me/?text=$message";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch WhatsApp.");
    }
  }

  Future<bool?> isInstalled() async {
    final val = await WhatsappShare.isInstalled(package: Package.whatsapp);
    return val;
  }
  Future<bool?> isInstalledBuss() async {
    final val = await WhatsappShare.isInstalled(
        package: Package.businessWhatsapp
    );
    return val;
  }
}
