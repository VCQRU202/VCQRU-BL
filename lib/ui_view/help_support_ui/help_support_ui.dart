import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/help_support_ui/raised_ticket_history.dart';

import '../../providers_of_app/help_support_provider/help_support_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import 'help_top_q_support_ui.dart';
class HelpSupportUI extends StatefulWidget {
  const HelpSupportUI({super.key});

  @override
  State<HelpSupportUI> createState() => _HelpSupportUIState();
}

class _HelpSupportUIState extends State<HelpSupportUI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HelpAndSupportProvider>(context, listen: false).gethelpsupport();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Help & Support',style: GoogleFonts.roboto(fontSize: 18),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [TextButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketHistory()));
        }, child: Text("Tickets",style: GoogleFonts.roboto(fontSize: 14),))],
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffF5FAFF),
              Color(0xffEDD3FF),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text("Select the Topic",style: TextStyle(fontWeight: FontWeight.bold),)
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding:EdgeInsets.all(10) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child:Consumer<HelpAndSupportProvider>(
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
                                    valustate.retrygethelpsupport();
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // return SingleChildScrollView(
                          //   child: Container(
                          //     margin: EdgeInsets.all(10),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.all(Radius.circular(5)),
                          //         color: Colors.white),
                          //     child:Container(
                          //       margin: EdgeInsets.only(left: 15, right: 15,top: 10),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.all(Radius.circular(5)),
                          //         color: Colors.white,
                          //       ),
                          //       child: Column(
                          //         children: [
                          //           // NotificationTile(
                          //           //   avatar: CircleAvatar(
                          //           //     backgroundImage: AssetImage('assets/profile.jpg'),
                          //           //   ),
                          //           //   title: RichText(
                          //           //     text: TextSpan(
                          //           //       text: 'Arbind Kumar ',
                          //           //       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          //           //       children: [
                          //           //         TextSpan(
                          //           //           text: 'has just received your referral! 🎉',
                          //           //           style: TextStyle(fontWeight: FontWeight.normal),
                          //           //         ),
                          //           //       ],
                          //           //     ),
                          //           //   ),
                          //           //   time: '34 min ago',
                          //           // ),
                          //           // NotificationTile(
                          //           //   avatar: CircleAvatar(
                          //           //     child: Icon(Icons.notifications, color: Colors.white),
                          //           //     backgroundColor: Colors.blue,
                          //           //   ),
                          //           //   title: Text(
                          //           //     'VCQRU has posted a new blog! Click the button below to read it and...',
                          //           //     maxLines: 2,
                          //           //     overflow: TextOverflow.ellipsis,
                          //           //   ),
                          //           //   time: 'Today 3:29 PM',
                          //           // ),
                          //           // NotificationTile(
                          //           //   avatar: CircleAvatar(
                          //           //     child: Text('AK'),
                          //           //     backgroundColor: Colors.pinkAccent,
                          //           //   ),
                          //           //   title: Text('You have just scanned a QR code, and this has failed.'),
                          //           //   time: 'Yesterday 3:28 PM',
                          //           // ),
                          //           ...List.generate(2, (index) => NotificationTile(
                          //             avatar: CircleAvatar(
                          //               child: Icon(Icons.check_circle, color: Colors.white),
                          //               backgroundColor: Colors.grey,
                          //             ),
                          //             title: Text('VCQRU has added one more product checkpoint scan detail.',
                          //               style: GoogleFonts.roboto(fontSize: 14),),
                          //             time: 'July 2, 2020 3:29 PM',
                          //           )),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );

                          final helpdat = valustate.helpData?.data ?? [];
                          print("----data----${helpdat}");
                          return helpdat.isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true, // Makes ListView take only the required height
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: helpdat.length,
                            itemBuilder: (context, index) {
                              IconData getIcon(String id) {
                                switch (id) {
                                  case 'cbCashback':
                                    return Icons.account_balance_wallet_outlined; // Cashback Icon
                                  case 'cbProducts':
                                    return FontAwesomeIcons.dropbox; // Products Icon
                                  case 'cbQRCodeNotFound':
                                    return Icons.qr_code_scanner;
                                  case 'cbQRCodeNotWorking':
                                    return Icons.qr_code_sharp;
                                    // QR Code Scanner Icon
                                  case 'cbFeedback':
                                    return Icons.feedback; // Feedback Icon
                                  default:
                                    return Icons.help_outline; // Default Icon
                                }
                              }
                              final notification = helpdat[index];

                              return GestureDetector(
                                onTap: () {

                                },
                                child:Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(getIcon(helpdat[index].id!)),
                                      //leading: Icon(Icons.help_outline),
                                      title: Text(notification.topic!,style: TextStyle(fontSize: 14),),
                                      trailing: Icon(Icons.arrow_forward),
                                      onTap: () {
                                        // Handle the tap event here
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context)=>FAQScreen(subI: notification.id??"",subName:notification.topic??"" ,)));
                                        print('${notification.id}');
                                      },
                                    ),
                                    Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1.0,
                                      indent: 10.0,
                                      endIndent: 10.0,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                              : Center(child: Text("Data Not available."));
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// //for ios setting
//
// /*
// android manifest
//
// <uses-permission android:name="android.permission.CAMERA" />
// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
//
// plist file
//
// <key>NSCameraUsageDescription</key>
// <string>We need access to the camera to take photos for attachments.</string>
// <key>NSPhotoLibraryUsageDescription</key>
// <string>We need access to your photo library to select photos for attachments.</string>
//
// uncomment platform from podfile
//
//  */
//