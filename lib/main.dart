import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/providers_of_app/banner_provider/banner_provider.dart';
import 'package:vcqru_bl/providers_of_app/blogs_provider/blogs_provider.dart';
import 'package:vcqru_bl/providers_of_app/claim_history/claim_history_provider.dart';
import 'package:vcqru_bl/providers_of_app/code_check_history_provider/code_check_history_provider.dart';
import 'package:vcqru_bl/providers_of_app/dashboard_provider/dashboard_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/aadhar_verify_provider/aadhar_verify_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/account_verify_provider/account_verify_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/dashboard_kyc/kyc_main_dashboard_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/kyc_details_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/kyc_main_page_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/pancard_verify_provider/pancard_verify_provider.dart';
import 'package:vcqru_bl/providers_of_app/ekyc_providers/upi_verify_provider/upi_verify_provider.dart';
import 'package:vcqru_bl/providers_of_app/enter_mobile_provider/enter_mobile_provider.dart';
import 'package:vcqru_bl/providers_of_app/gift_claim_provider/gift_claim_provider.dart';
import 'package:vcqru_bl/providers_of_app/mobile_pass_provider/mobile_login_password_provider.dart';
import 'package:vcqru_bl/providers_of_app/notification_provider/notification_provider.dart';
import 'package:vcqru_bl/providers_of_app/profile_provider/edit_profile_provider.dart';
import 'package:vcqru_bl/providers_of_app/profile_provider/profile_provider.dart';
import 'package:vcqru_bl/providers_of_app/raised_ticket_provider/raised_ticket_provider.dart';
import 'package:vcqru_bl/providers_of_app/registration_provider/registration_provider.dart';
import 'package:vcqru_bl/providers_of_app/scanner_provider/scanner_provider.dart';
import 'package:vcqru_bl/providers_of_app/scanner_provider/scanner_qr_provider/scanner_qr_provider.dart';
import 'package:vcqru_bl/providers_of_app/sliders_provider/slider_provider.dart';
import 'package:vcqru_bl/providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import 'package:vcqru_bl/ui_view/splash_screen/splash_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}
// 2dec sb branch 164
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// fisrt push
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => Scanner_provider()),
        ChangeNotifierProvider(create: (_) => LoginProviderPassword()),
        ChangeNotifierProvider(create: (_) => EnterMobileProvider()),
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationFormProvider()),
        ChangeNotifierProvider(create: (_) => PanVerificationProvider()),
        ChangeNotifierProvider(create: (_) => AadharVerifyProvider()),
        ChangeNotifierProvider(create: (_) => AccountVerifyProvider()),
        ChangeNotifierProvider(create: (_) => KYCMainProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => CodeCheckHistoryProvider()),
        ChangeNotifierProvider(create: (_) => KYCMainDashboardProvider()),
        ChangeNotifierProvider(create: (_) => GiftProvider()),
        ChangeNotifierProvider(create: (_) => TimerQRProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => ClaimHistoryProvider()),
        ChangeNotifierProvider(create: (_) => UPIVerifyProvider()),
        ChangeNotifierProvider(create: (_) => KycDetailsProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => RaisedTicketProvider()),
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