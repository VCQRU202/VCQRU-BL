import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/res/app_colors/app_colors.dart';

import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/profile_provider/profile_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/components/custom_text.dart';
import '../../res/values/values.dart';
import 'edit_profile_ui.dart';
class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getProfileDetail();
  }
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
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
            Container(
              width: 360,
              height: 166,
              padding: const EdgeInsets.only(
                top: 0,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: SweepGradient(
                  center: Alignment(0.11, 0.76),
                  startAngle: -0.78,
                  endAngle: -0.11,
                  colors: [
                    splashProvider.color_bg,
                    splashProvider.color_bg
                  ],
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30,),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back, color: Colors.white),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [Colors.black.withOpacity(0), Colors.black],
                                    ),
                                    shape: OvalBorder(
                                      side: BorderSide(width: 2, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(valustate.profile?.consumerName.toString().split(' ')[0]??"",style: TextStyle(fontSize: 18,color: Colors.white),),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "KYC : ${_getKYCStatusText(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0)}",
                                          color: _getKYCStatusColor(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                          fontSize: 12,
                                        ),
                                        SizedBox(width: 4), // Spacing between text and icon
                                        Icon(
                                          _getKYCStatusIcon(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                          color: _getKYCStatusColor1(int.tryParse(valustate.profile?.vrKblKYCStatus ?? "0") ?? 0),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    print("Edit Profile Clicked");
                                    // Add your edit profile functionality here
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileFormPage()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(color: Colors.white,width: 1)
                                    ),
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                    child:Text("Edit",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    }
                  }),
            ),
            Consumer<ProfileProvider>(
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
                                valustate.retryFetchProfileDetail();
                              },
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(child: getBody(valustate));
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
  Widget getBody(ProfileProvider historyProvider) {
    return Container(
        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        height: MediaQuery.of(context).size.height / 1.2,
        child: ListView.builder(
            itemCount: historyProvider.historyProfile!.data!.length,
            itemBuilder: (context, index) {
              return getCard(index, historyProvider);
            }),
      );
  }
  Widget getCard(int index, ProfileProvider historyProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text(historyProvider.historyProfile!.data![index].lableName??"",
            style: TextStyle(
              color: AppColor.app_btn_color_inactive,
              fontSize: 12
            ),),
        ),
        Container(
            margin: EdgeInsets.only(left: 15,bottom: 10),
            child: Text(historyProvider.historyProfile!.data![index].data?.isNotEmpty == true
                ? historyProvider.historyProfile!.data![index].data!
                : "NA",
              style: TextStyle(
                  color: AppColor.black_color,
                fontWeight: FontWeight.bold,
                fontSize: 14
              ),
            )
        ),
        Divider(
          height: 1,
          color: AppColors.diveder_color,
        ),
        SizedBox(
          height: 15,
        ),
      ],
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
        return Colors.white; // Verified - Green color
      case 2:
        return Colors.white; // Rejected - Red color
      default:
        return Colors.grey; // Unknown - Grey color
    }
  }
  Color _getKYCStatusColor1(int? status) {
    switch (status) {
      case 0:
        return Colors.orange; // Pending - Orange color
      case 1:
        return Colors.green; // Verified - Green color
      case 2:
        return Colors.white; // Rejected - Red color
      default:
        return Colors.grey; // Unknown - Grey color
    }
  }

  IconData _getKYCStatusIcon(int? status) {
    switch (status) {
      case 0:
        return Icons.error; // Pending
      case 1:
        return Icons.verified; // Verified
      case 2:
        return Icons.cancel; // Rejected
      default:
        return Icons.help_outline; // Unknown
    }
  }
}
