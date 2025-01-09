import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../providers_of_app/referral_provider/referral_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
class RefferelReport extends StatefulWidget {
  const RefferelReport({super.key});

  @override
  State<RefferelReport> createState() => _RefferelReportState();
}

class _RefferelReportState extends State<RefferelReport> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ReferralProvider>(context, listen: false).getNotificationList();
  }
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Invited Friends',style: GoogleFonts.roboto(fontSize: 18,color: Colors.white,),),
        backgroundColor: splashProvider.color_bg,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
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
                margin: EdgeInsets.all(10),
                padding:EdgeInsets.all(10) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Consumer<ReferralProvider>(
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
                          final notifications = valustate.notifiData?.data ?? [];
                          return notifications.isNotEmpty
                              ? ListView.builder(
                            itemCount: notifications.length,
                            shrinkWrap: true, // Makes ListView take only the required height
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final notification = notifications[index];
                              return Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.purple,
                                      child: Text(
                                        getInitials(notifications[index].consumerName??"U"),
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    title: Text(notifications[index].consumerName??"", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                    subtitle: Text(notifications[index].entryDate??"",style: GoogleFonts.roboto(fontSize: 12,color: Color(0xFF6B7280)),),
                                    trailing: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(notifications[index].status??"").withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: getStatusColor(notifications[index].status??"")),
                                      ),
                                      child: Text(
                                        notifications[index].status??"",
                                        style: TextStyle(color: getStatusColor(notifications[index].status??""), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1.0,
                                    indent: 5.0,
                                    endIndent: 10.0,
                                  ),
                                ],
                              );
                            },
                          )
                              : Center(child: Text("No Data available."));
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
Color getStatusColor(String status) {
  switch (status) {
    case 'Rejected':
      return Colors.red;
    case 'Pending':
      return Colors.orange;
    case 'Success':
      return Colors.green;
    default:
      return Colors.grey;
  }
}
String getInitials(String name) {
  List<String> names = name.split(" ");
  String initials = "";
  if (names.isNotEmpty) {
    initials += names[0][0];
    if (names.length > 1) {
      initials += names[1][0];
    }
  }
  return initials.toUpperCase();
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