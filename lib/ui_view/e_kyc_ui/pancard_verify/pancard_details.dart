import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/ekyc_providers/kyc_details_provider.dart';
import '../../../res/app_colors/app_colors.dart';
class PanCardDetails extends StatefulWidget {
  const PanCardDetails({super.key});

  @override
  State<PanCardDetails> createState() => _PanCardDetailsState();
}

class _PanCardDetailsState extends State<PanCardDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<KycDetailsProvider>(context, listen: false).getKYCDetail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(
          "PanCard",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ Color(0xFFF9F8FC), Color(0xFFE1D7FF), Color(0xFFFDE0E7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<KycDetailsProvider>(
                  builder: (context, valustate, child) {
                    if (valustate.isloading_kycs) {
                      return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Please Wait"),
                              CircularProgressIndicator(),
                            ],
                          ));
                    } else {
                      if (valustate.hasError_kycs) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(' ${valustate.errorMessage_kycs}'),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  valustate.retryFetchKYCDetail();
                                },
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          // Background color
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(8)) ,
                              color: Colors.white
                          ),
                          // Wrap ListView with IntrinsicHeight
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pan Number",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  valustate.kycData?.data?.panCardNumber??"",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                                ),
                                Divider(),

                                // Name
                                SizedBox(height: 10),
                                Text(
                                  "Name",
                                  style: TextStyle(

                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  valustate.kycData?.data?.panName??"",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                                ),
                                Divider(),

                                // DOB
                                SizedBox(height: 10),

                              ],
                            ),
                          ),
                        );
                      }
                    }
                  }),
            ],
          ),
    ),
    );
  }
}