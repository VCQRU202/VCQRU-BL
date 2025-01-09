import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';

class CodeDetail extends StatelessWidget {
  const CodeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Details",style: TextStyle(fontSize: 18,color: Colors.white),),
        backgroundColor: splashProvider.color_bg,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child:Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20,left: 16,right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFFFFFF).withOpacity(0.16),
                  ),
                  child: Consumer<DashboardProvider>(
                      builder: (context, valustate, child) {
                        if (valustate.isLoading_wallet) {
                          return Center(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.only(top: 10),
                                  child: CircularProgressIndicator()));
                        } else {
                          if (valustate.hasError_wallet) {
                            return Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                              // decoration: BoxDecoration(
                              //     gradient: LinearGradient(
                              //         colors: [
                              //           const Color(0xFF3366FF),
                              //           const Color(0xFF00CCFF),
                              //         ],
                              //         begin: const FractionalOffset(0.0, 0.0),
                              //         end: const FractionalOffset(1.0, 0.0),
                              //         stops: [0.0, 1.0],
                              //         tileMode: TileMode.clamp),
                              //     borderRadius:
                              //     BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(' ${valustate.errorMessage_wallet}'),
                                    ElevatedButton(
                                      onPressed: () {
                                        valustate.retryFetchWallet();
                                      },
                                      child: Text('Retry'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            String total_code = valustate.dashbaord!.totalCode ?? "0";
                            String succes_code = valustate.dashbaord!.successCode ?? "0";
                            var points;
                            if(total_code.isNotEmpty&&succes_code.isNotEmpty){
                              var e = double.parse(total_code);
                              var f = double.parse(succes_code);
                              var points1 = e - f;
                              //  points =points1.toString();
                              points =points1 % 1 == 0 ? points1.toInt().toString() : points1.toString();
                            }else{
                              points="0";
                            }
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20), color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/code_detail.jpg'),
                                    codeDetailContainer(
                                      totalCodeCheckTitle: 'Total Code Check',
                                      totalCodeCheck: int.parse(total_code),
                                      color1: Color(0xFF5B00E0),
                                      color2: Color(0xFF5B00E0),
                                      color3: Color(0xFF7D00E8),
                                      color4: Color(0xFF7D00E8),
                                      color5: Color(0xFFA000F5),
                                      color6: Color(0xFFA000F5),
                                    ),
                                    codeDetailContainer(
                                      totalCodeCheckTitle: 'Success Code',
                                      totalCodeCheck: int.parse(succes_code),
                                      // color1:  Color(0xFFFF0000),
                                      // color2:  Color(0xFFFF0000),
                                      // color3: Color(0xffF45B65),
                                      // color4: Color(0xFFF45B65),
                                      // color5: Color(0xFFFF0000),
                                      // color6: Color(0xFFFF0000),
                                      color1: Color(0xff009F4B),
                                      color2: Color(0xFF009F4B),
                                      color3: Color(0xFF00BA57),
                                      color4: Color(0xFF00BA57),
                                      color5: Color(0xFF00AB45),
                                      color6: Color(0xFF00AB45),
                                    ),
                                    codeDetailContainer(
                                      totalCodeCheckTitle: 'Unsuccess Code',
                                      totalCodeCheck: int.parse(points),
                                      color1: Color(0xFFFF0000),
                                      color2: Color(0xFFFF0000),
                                      color3: Color(0xffF45B65),
                                      color4: Color(0xFFF45B65),
                                      color5: Color(0xFFFF0000),
                                      color6: Color(0xFFFF0000),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                      }),
                ),


              ),
            ),
          ],
        ),
      ),
    );
  }
}

class codeDetailContainer extends StatelessWidget {
  late Color color1;
  late Color color2;
  late Color color3;
  late Color color4;
  late Color color5;
  late Color color6;

  String totalCodeCheckTitle;
  int totalCodeCheck;

  codeDetailContainer(
      {required this.totalCodeCheckTitle,
        required this.totalCodeCheck,
        required this.color1,
        required this.color2,
        required this.color3,
        required this.color4,
        required this.color5,
        required this.color6});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(-0.6, -2.8),
            stops: [0.0, 0.3, 0.3, 0.6, 0.6, 1.0],
            // Adjusted stops
            colors: [
              color1, //Color(0xFF5B00E0), // Dark blue
              color2, //Color(0xFF5B00E0), // Dark blue
              color3, //Color(0xFF7D00E8), // Purple
              color4, //Color(0xFF7D00E8), // Purple
              color5, //Color(0xFFA000F5), // Light purple
              color6, //Color(0xFFA000F5),
            ],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                totalCodeCheckTitle,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                totalCodeCheck.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
