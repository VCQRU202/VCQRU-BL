import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/aadhar_verify_provider/aadhar_verify_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/account_verify_provider/account_verify_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/kyc_main_page_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/pancard_verify_provider/pancard_verify_provider.dart';
import 'package:vcqru_bl/providers_of_app/enter_mobile_provider/enter_mobile_provider.dart';
import 'package:vcqru_bl/providers_of_app/mobile_pass_provider/mobile_login_password_provider.dart';
import 'package:vcqru_bl/providers_of_app/registration_provider/registration_provider.dart';
import 'package:vcqru_bl/providers_of_app/scanner_provider/scanner_provider.dart';
import 'package:vcqru_bl/providers_of_app/sliders_provider/slider_provider.dart';
import 'package:vcqru_bl/providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import 'package:vcqru_bl/ui_view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}
// 2dec sb branch
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// fisrt push
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => Scanner_provider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => EnterMobileProvider()),
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationFormProvider()),
        ChangeNotifierProvider(create: (_) => PanVerificationProvider()),
        ChangeNotifierProvider(create: (_) => AadharVerifyProvider()),
        ChangeNotifierProvider(create: (_) => AccountVerifyProvider()),
        ChangeNotifierProvider(create: (_) => KYCMainProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}