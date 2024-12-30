import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/claim_history_ui/claim_history_ui.dart';
import 'package:vcqru_bl/ui_view/e_kyc_ui/e_kyc_main_ui.dart';

import '../../providers_of_app/notification_provider/notification_provider.dart';
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  final List<Map<String, String>> notifications = [
    {'title': 'VCQRU has added one more product checkpoint scan detail.', 'time': 'July 2, 2020 3:29 PM'},
    {'title': 'VCQRU has added one more product checkpoint scan detail.', 'time': 'July 2, 2020 3:29 PM'},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NotificationsProvider>(context, listen: false).getNotificationList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height:double.infinity ,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF6F4FC),
              Color(0xFFE1D7FF),
              Color(0xFFFDE0E7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<NotificationsProvider>(
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
        
                        Container(
                          child: Image.asset(
                            'assets/notificatins.png',
                          ),
                        ),
                        Text(' ${valustate.errorMessage}'),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            valustate.retrygetNotificationList();
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

                  final notifications = valustate.notifiData?.data ?? [];
                  return notifications.isNotEmpty
                      ? ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];

                      return GestureDetector(
                        onTap: () {
                          // Validate and handle notification type
                          switch (notification.notiType) {
                            case 'KYC':
                            // Navigate to screen or perform action for TYPE_1
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KycMainScreen(), // Example screen
                                ),
                              );
                              break;

                            case 'Claim':
                            // Navigate to screen or perform action for TYPE_2
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClaimScreen(), // Example screen
                                ),
                              );
                              break;

                            case 'TYPE_3':
                            // Open a URL or handle TYPE_3
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KycMainScreen(), // Example screen
                                ),
                              );
                              break;

                            default:
                            // Handle unknown types

                              break;
                          }
                        },
                        child: NotificationTile(
                          avatar: CircleAvatar(
                            backgroundImage: NetworkImage(
                              notification.profileImage ??
                                  'https://via.placeholder.com/150', // Default image
                            ),
                          ),
                          title: Text(notification.messgae ?? "No message"),
                          time: notification.formattedCreatedAt ?? "No date",
                        ),
                      );
                    },
                  )
                      : Center(child: Text("No notifications available."));
                }
              }
            }),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final Widget avatar;
  final Widget title;
  final String time;

  NotificationTile({required this.avatar, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: avatar,
      title: title,
      subtitle: Text(time,style: GoogleFonts.roboto(fontSize: 12),),
    );
  }
}