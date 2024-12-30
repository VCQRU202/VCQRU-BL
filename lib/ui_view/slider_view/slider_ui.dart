import 'dart:async';

import 'package:flutter/material.dart';

import '../../providers_of_app/sliders_provider/slider_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/animation/animination_slider.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/components/dynamic_btn.dart';
import '../../res/localization/localization_en.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../e_kyc_ui/e_kyc_main_ui.dart';
import '../mobile_enter/mobile_enter_screen.dart';
import '../registration_ui/user_registration_ui.dart';
// Import your SliderProvider

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  @override
  void initState() {
    super.initState();
    // Start the slider when the screen is loaded
    Provider.of<SliderProvider>(context, listen: false).startSlider();
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<SliderProvider>( // Using Consumer to listen to changes
        builder: (context, sliderProvider, child) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(sliderProvider.image), // Correct way to use AssetImage
                fit: BoxFit.cover, // Adjust fit to your need (e.g., cover, contain, fill)
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                    child: Container(

                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1), // Half opacity background color
                      boxShadow: [
                        // Top shadow
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, -1),
                          blurRadius: 40,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, -4),
                          blurRadius: 20,
                          spreadRadius: 0,
                        ),
                        // Bottom shadow
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 4),
                          blurRadius: 50,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.0), // Half opacity background color
                            boxShadow: [
                              // Top shadow

                              BoxShadow(
                                color: Colors.black.withOpacity(1.0),
                                offset: Offset(0, -4),
                                blurRadius: 180,
                                spreadRadius: 0,
                              ),
                              // Bottom shadow
                              BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                offset: Offset(0, 4),
                                blurRadius: 150,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: CustomText(
                                  text: sliderProvider.title, // Using the title from SliderProvider
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 0),
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 10),
                                child: CustomText(
                                  text: sliderProvider.description, // Using the description from SliderProvider
                                  fontSize: 14,
                                  color: Colors.white,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(sliderProvider.introData.length, (index) {
                                  return AnimatedBullet(
                                    isSelected: index == sliderProvider.index, // Highlight the current bullet
                                  );
                                }),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15,bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 10),
                                        child: CustomElevatedButton(
                                          onPressed: () async {
                                            // Your button action here
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => MobileEnterScreen()));

                                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationFormPage(mobile: "9876554532",)));

                                            // Navigator.pushReplacement(context,
                                            //     MaterialPageRoute(builder: (context)=>KycMainScreen()));

                                          },
                                          buttonColor: splashProvider.color_bg,
                                          textColor: AppColor.black_color,
                                          borderRadius: BorderRadius.circular(8.0),
                                          widget: CustomText(
                                            text: LocalizationEN.GET_START,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: AppColor.white_color,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
