import 'package:flutter/material.dart';

import '../../res/components/custom_text.dart';
import '../../res/values/images_assets.dart';
import '../../res/values/values.dart';
class DashboardApp extends StatefulWidget {
  const DashboardApp({super.key});

  @override
  State<DashboardApp> createState() => _Dashboard_vcqruState();
}

class _Dashboard_vcqruState extends State<DashboardApp> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F9FAFF),
      extendBodyBehindAppBar: true,
      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex: _selectedIndex,
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
              isSelected: _selectedIndex == 1,
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithIndicator(
              icon: Icons.person,
              isSelected: _selectedIndex == 2,
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),

      body: SingleChildScrollView(
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
                height: 230,
                child: Stack(
                  children: [
                    // Background Container
                    Container(
                      width: double.infinity,
                      height: 173,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/polygon.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Foreground Content (Row with Name and Verified)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0), // Adjust as needed
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //CircleAvatar(),
                            Flexible(
                              flex: 2,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: 1.0, color: Colors.white),
                                    color: Color(0xFFFFFFFF)),
                                padding: EdgeInsets.all(5),
                                child: Center(child: Image.asset('assets/logo.png')),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Second Widget
                            Flexible(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Hello,Rohit",
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "Verified",
                                        color: AppColors.white,
                                        fontSize: 12,
                                      ),
                                      Icon(
                                        Icons.verified,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 50),
                            // Third Widget
                            Flexible(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    // Navigate to notification screen
                                  },
                                  icon: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bottom Positioned Container
                    Positioned(
                      bottom: -3,
                      left: 10,
                      right: 10,
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: dashboard_top(
                                  image_name: ImagesAssets.dashboard_loyalty_image,
                                  colour: AppColors.App_Loyalty_Color,
                                  title: StringConst.dashboard_loyalty,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: dashboard_top(
                                  colour: AppColors.App_Authenticity_Color,
                                  image_name: ImagesAssets.dashboard_medal_image,
                                  title: StringConst.dashboard_authenticity,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: dashboard_top(
                                  image_name: ImagesAssets.dashboard_ekyc_image,
                                  colour: Colors.pinkAccent,
                                  title: StringConst.dashboard_ekyc,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0,left: 10,right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      Colors.deepPurpleAccent,
                      Colors.lightBlueAccent
                    ])),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConst.dashboard_wallet_b,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(StringConst.dashboard_rs,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Text(StringConst.dashboard_update,
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                      ImagesAssets.coin_image
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 9,bottom: 9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white

                        ),
                        child: icon_contianer_middle(
                            title: StringConst.dashboard_warranty,
                            image_name: ImagesAssets.dashboard_warranty_image,
                            colour: Colors.lightGreenAccent),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 9,bottom: 9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white

                        ),
                        child: icon_contianer_middle(
                            title: StringConst.dashboard_fake_product,
                            image_name: ImagesAssets.dashboard_fake_product_image,
                            colour: Colors.pinkAccent),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white

                        ),
                        padding: EdgeInsets.only(top: 9,bottom: 9),
                        child: icon_contianer_middle(
                            title: StringConst.dashboard_wallet_title,
                            image_name: ImagesAssets.dashboard_wallet_image,
                            colour: Colors.blue),
                      ),
                    ),
                  ],
                ),),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 9,bottom: 9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white

                        ),
                        child: icon_contianer_middle(
                            title: StringConst.dashboard_history,
                            image_name: ImagesAssets.dashboard_history_image,
                            colour: AppColors.App_History_Color),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 9,bottom: 9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white

                        ),
                        child: icon_contianer_middle(
                            title: StringConst.dashboard_claim,
                            image_name: ImagesAssets.dashboard_loyality_imgage,
                            colour: AppColors.App_Claim_Color),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 9,bottom: 9),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white

                        ),
                        child: icon_contianer_middle(
                          title: StringConst.dashboard_claim_history,
                          image_name: ImagesAssets.dashboard_claim_image,
                          colour: AppColors.App_Claim_history_Color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             // slider_banner()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        label: Text("Scan",style: TextStyle(color: Colors.white),),
        icon: Icon(Icons.qr_code_rounded,color: Colors.white,),
        onPressed: (){},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Widget _buildIconWithIndicator
      (
      {required IconData icon, required bool isSelected}) {
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

