import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/gift_claim/gift_claim.dart';

import '../../providers_of_app/claim_providers/claim_main_provider.dart';
import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/values/values.dart';
// Import your provider class
class ClaimScreenSelect extends StatefulWidget {
  const ClaimScreenSelect({super.key});

  @override
  State<ClaimScreenSelect> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreenSelect> {
  String? _selectedIconName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CliamMainProvider>(context,listen: false).getClaimMainData();
  }
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Claim',style: TextStyle(color: Colors.white,fontSize: 18),),
        centerTitle: true,
        backgroundColor: splashProvider.color_bg,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE1D7FF), Color(0xFFFDE0E7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Header with Total Points Balance
            Consumer<DashboardProvider>(
                builder: (context, valustate, child) {
                  if (valustate.isLoading) {
                    return Center(
                        child: Container(
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.only(top: 10),
                            child: CircularProgressIndicator()));
                  } else {
                    if (valustate.hasError) {
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
                              Text(' ${valustate.errorMessage}'),
                              ElevatedButton(
                                onPressed: () {
                                  valustate.retryDashboardIName();
                                },
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final dashboardData = valustate.dashdynaData?.data?.additionalData;

                      return Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 20, left: 16, right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFFFFF).withOpacity(0.16),
                        ),
                        child:Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            color: AppColors.gift_green,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.card_giftcard,
                                      color: Colors.white),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Total Available Balance',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Text(
                                dashboardData?.avlaiblepoint??"NA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                }),
            // Payment Method List
            Expanded(
              child:Consumer<CliamMainProvider>(
                  builder: (context, valustate, child) {
                    if (valustate.isLoading) {
                      return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Please Wait"),
                              CircularProgressIndicator(),
                            ],
                          ));
                    } else {
                      if (valustate.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(' ${valustate.errorMessage}'),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  valustate.retryFetchClaimMainData();
                                },
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        var claimRequire=valustate.historyData?.data?.claimRequired??"";
                        var listData=valustate.historyData?.data?.icons??[];
                        return Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.white),
                          child:ListView.builder(
                            itemCount: listData.length,
                            itemBuilder: (context, index) {
                              final method = listData[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIconName = method.iconName ?? ""; // Update the selected value
                                  });
                                  if(method.id!=null&&(method.id??"").isNotEmpty){
                                    if((method.id??"").endsWith("gift")){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GiftClaimUI()));
                                    }
                                  }
                                },
                                child: Container(
                                 // margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  margin: EdgeInsets.only(top: 10.0, bottom: 8.0,left: 8,right: 8),
                                 padding: EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: _selectedIconName != null && _selectedIconName == method.iconName
                                          ? Colors.blue
                                          : Colors.grey,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Radio<String>(
                                                  value: method.iconName ?? "", // The value of this radio button
                                                  groupValue: _selectedIconName, // The selected value to compare with
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      _selectedIconName = value; // Update the selected value
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  method.iconName??"".toUpperCase(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Image.network(
                                            method.imagePath??"",
                                            width: 40,
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible:  _selectedIconName != null && _selectedIconName == method.iconName,
                                        child: Row(
                                          children: [
                                            Text("Note : ",
                                              style:GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 14),),
                                            Text(
                                              method.containts??"",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                  })
            ),
            Visibility(
              visible:  _selectedIconName != null,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Colors.white,
                ),
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gift_green,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Proceed',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            // Proceed Button
          ],
        ),
      ),
    );
  }

}
