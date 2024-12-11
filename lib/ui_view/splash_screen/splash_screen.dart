import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/components/custom_text.dart';

import '../../res/values/values.dart';

import '../dashboard_ui/dashboard_ui.dart';
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
    Provider.of<SplashScreenProvider>(context, listen: false).getBrandSettingData();
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
                        Text(valustate.companyName,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)
                        ,Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: LoadingWidget(
                            backgroundColor:valustate.color_bg,
                            progressColor:valustate.color_bg,
                            onCompleted: () {
                              print('Loading completed');
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SliderScreen()));
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardApp()));

                              // splashProvider.checkLoginStatus().then((value) async {
                              //   if (value == true) {
                              //     String userType=await SharedPrefHelper().get("UserType")??"";
                              //
                              //   } else {
                              //     Navigator.pushReplacement(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => MobileEnterScreen()));
                              //     // Navigator.pushReplacement(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (context) => LoginWithPassword()));
                              //   }
                              // });
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
                              margin: const EdgeInsets.only(left: 40, right: 40),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(valustate.productImage),
                                  fit: BoxFit.cover, // Adjust the fit as needed: cover, contain, fitWidth, fitHeight, etc.
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
