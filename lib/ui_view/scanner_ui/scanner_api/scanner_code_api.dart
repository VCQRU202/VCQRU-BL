import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../../providers_of_app/scanner_provider/scanner_qr_provider/scanner_qr_provider.dart';
import '../../../res/api_url/api_url.dart';
import '../../../res/custom_alert_msg/custom_alert_msg.dart';
import '../enter_code_check/code_check_failed_msg.dart';
import '../enter_code_check/code_check_succes_msg.dart';
// Import your TimerQRProvider

class QRLoadingScreen extends StatefulWidget {
  final String code;
  final String lat;
  final String long;

  QRLoadingScreen({
    required this.code,
    required this.lat,
    required this.long,
  });

  @override
  State<QRLoadingScreen> createState() => _QRLoadingScreenState();
}

class _QRLoadingScreenState extends State<QRLoadingScreen> with  SingleTickerProviderStateMixin {
late AnimationController _controller;
late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 250.0).animate(_controller);
    // Trigger API call
   Future.microtask(() => _startCodeCheck());
  }
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
  void _startCodeCheck() async {
    final value1 = await Provider.of<TimerQRProvider>(context, listen: false)
        .appcodecheck(widget.code, widget.lat, widget.long);

    if (value1 != null) {
      var status = value1["success"] ?? false;
      var msg = value1["message"] ?? AppUrl.warningMSG;
      var data=value1['data'];
      if(data!=null){
        if (status) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context)=>CodeCheckSuccessScreen(
            msg: msg,
            code:value1['data']['codeNumber']??0,
            codedate:value1['data']['codecheckeddate']??"",
            point:value1['data']['points']??"",
            codtype:value1['data']['codeType']??"",
            status:value1['data']['status']??"",
          )));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context)=>CodeCheckFailedScreen(
            msg: msg,
            code:value1['data']['codeNumber']??0,
            codedate:value1['data']['codecheckeddate']??"",
            point:value1['data']['points']?.toString()?? "",
            codtype:value1['data']['codeType']??"",
            status:value1['data']['status']??"",
          )));

        }
      }else{
        CustomAlert.showMessage(
            context, "Info", msg.toString(), AlertType.info);
      }
    } else {
      Navigator.pop(context);
      // toastRedC(AppUrl.warningMSG);
    }
  }


  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerQRProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Code
          Stack(
          alignment: Alignment.center,
          children: [
            // QR Code Container
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 4),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/qr_f.png', // Your QR code asset
                fit: BoxFit.cover,
              ),
            ),
            // Moving Line Animation
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  top: _animation.value, // Use animation value
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 250,
                    height: 4, // Height of the scanning line
                    color: Colors.greenAccent, // Laser line color
                  ),
                );
              },
            ),
          ],
        ),
            const SizedBox(height: 20),
            // Loading and Countdown
            Text(
              timerProvider.isloaing_appcodeck
                  ? "Please wait for 5sec"
                  : "Please wait...",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your code will check wait for few seconds",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFEDE7F6), // Light purple gradient background
    );
  }
}
