import 'package:flutter/material.dart';

import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_text.dart';
class SuccessMsgSuccessfullyLogin extends StatefulWidget {
  String msg;
  SuccessMsgSuccessfullyLogin({Key? key,required this.msg}):super(key: key);

  @override
  State<SuccessMsgSuccessfullyLogin> createState() => _LoginSuccessfullyState();
}

class _LoginSuccessfullyState extends State<SuccessMsgSuccessfullyLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/success_gif.gif",
              height: 100,
              width: 100,
            ),
            //Icon(Icons.check_circle,color: Colors.green,size: 80,),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              width: double.infinity,
              child: CustomText(
                text: widget.msg,
                fontSize: 20,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 6),
              width: double.infinity,
              child: CustomText(
                text: "You are logged in successfully. Now you can check the code and claim your points.",
                fontSize: 14,
                textAlign: TextAlign.center,
                color: AppColor.otp_color,
              ),
            ),
            LoadingWidget(
              onCompleted: () {
                print('Loading completed');
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //     builder: (context) => DashboardAssistantScreen()));
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //     builder: (context) => OTPKYCScreen()));
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MobileEnterScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
class LoadingWidget extends StatefulWidget {
  final VoidCallback? onCompleted;

  const LoadingWidget({Key? key, this.onCompleted}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    );
    _controller.forward().whenComplete(() {
      if (widget.onCompleted != null) {
        widget.onCompleted!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return LinearProgressIndicator(
            backgroundColor: Colors.blue[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            value: _controller.value,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
