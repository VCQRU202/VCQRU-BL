import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers_of_app/sliders_provider/slider_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/components/custom_text.dart';

import '../../res/values/values.dart';

import '../dashboard_ui/dashboard_ui.dart';
import '../e_kyc_ui/e_kyc_main_ui.dart';
import '../mobile_enter/mobile_enter_screen.dart';
import '../registration_ui/user_registration_ui.dart';
import '../slider_view/slider_ui.dart';
import 'loading_widget.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    // Fetch splash data when the screen is initialized
   // Provider.of<SplashScreenProvider>(context, listen: false).fetchSplashData();
    initialization();
    Provider.of<SplashScreenProvider>(context, listen: false).getBrandSettingData();
    Provider.of<SliderProvider>(context, listen: false).getIntruc();
  }
  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      body: Consumer<SplashScreenProvider>(builder: (context,valustate,child){
      if(valustate.isloading_brand){
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Text("Please Wait"),
                CircularProgressIndicator(),
              ],
            ));
      }else{
        if (valustate.hasError_brand) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(' ${valustate.errorMessage_brand}'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    valustate.retryFetchBrandsetting();
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }else{
          return Container(
            color: valustate.color_bg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Image.network(
                          valustate.logoUrlF, // Replace with your image URL
                          width: 130,
                          height: 130,
                          fit: BoxFit.contain, // Adjust fit as needed
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(), // Show a loader while the image is loading
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.error, // Fallback icon if the image fails to load
                              size: 50,
                              color: Colors.red,
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 24,right: 24,top: 15,bottom: 10),
                            child: Text(valustate.companyName,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),))
                        ,Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: LoadingWidget(
                            backgroundColor:valustate.color_bg,
                            progressColor:valustate.color_bg,
                            onCompleted: () {
                              print('Loading completed');
                             //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SliderScreen()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationFormPage(mobile: "9876554531",)));
// Navigator.pushReplacement(context,
//                                   MaterialPageRoute(builder: (context)=>KycMainScreen()));
                              splashProvider.checkLoginStatus().then((value) async {
                                if (value == true) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardApp()));
                                  // Navigator.pushReplacement(context,
                                  //     MaterialPageRoute(builder: (context)=>KycMainScreen()));
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SliderScreen()));
                                 //  Navigator.pushReplacement(context,
                                 //      MaterialPageRoute(builder: (context)=>RegistrationFormPage(mobile: "9876554531",)));

                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => LoginWithPassword()));
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    )
                ),
                Expanded(
                    flex: 5,
                    child: Container(
                      height: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 20, right: 20,top: 19),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(valustate.productImage),
                                  fit: BoxFit.fill, // Adjust the fit as needed: cover, contain, fitWidth, fitHeight, etc.
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          );}
      }}),
    );
  }
}
