import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/res/app_colors/app_colors.dart';

import '../../res/components/custom_text.dart';
import '../e_kyc_ui/e_kyc_main_ui.dart';


class SuccessMsgSuccessfully extends StatefulWidget {
  String msg;
  SuccessMsgSuccessfully({Key? key,required this.msg}):super(key: key);

  @override
  State<SuccessMsgSuccessfully> createState() => _LoginSuccessfullyState();
}

class _LoginSuccessfullyState extends State<SuccessMsgSuccessfully> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFEEEAFD), Color(0xFFFDE0E7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
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
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: CustomText(
                  text: widget.msg,
                  fontSize: 24,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
              ), Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                width: double.infinity,
                child: CustomText(
                  text: "Your account has been successfully created!",
                  fontSize: 14,
                  color: AppColor.app_btn_color_inactive,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LoadingWidget(
                onCompleted: () {
                  print('Loading completed');
                  // Navigator.pushReplacement(context, MaterialPageRoute(
                  //     builder: (context) => DashboardAssistantScreen()));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder:
                              (context) =>
                              KycMainScreen()));
                },
              ),
            ],
          ),
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
