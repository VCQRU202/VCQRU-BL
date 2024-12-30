import 'package:flutter/material.dart';

import '../../../res/app_colors/app_colors.dart';
import '../claim_history_ui/claim_history_ui.dart';

class ClaimMsgSuccessScreen extends StatelessWidget {
  String msg,giftName,claimType,giftValue,redeemP,availableP;
  ClaimMsgSuccessScreen({
    required this.msg,
    required this.giftName,
    required this.claimType,
    required this.giftValue,
    required this.redeemP,
    required this.availableP
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 6,
                  child: Container(
                    color: Color(0xFF05AE25),
                  )
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Color(0xFFE1D7FF), Color(
                            0xFFFDEBF0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  )
              )
            ],
          ),
          Column(
            children: [
              // Success Icon
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.check_circle, color: Colors.green, size: 40),
                    ),
                    // SizedBox(height: 16),
                    // Text(
                    //   msg,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        msg,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // Details Card
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Total Points Earn",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              redeemP,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 5,
                              child: _buildDetailRow("Gift Name", giftName)
                          ),
                          Expanded(flex: 5,child: _buildDetailRow("Code Type", "Claim Gift")),
                        ],
                      ),
                      // SizedBox(height: 8),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(flex: 5,child: _buildDetailRow("Status", status)),
                      //     Expanded(flex: 5,child: _buildDetailRow1("Code Check Date",codedate)),
                      //   ],
                      // ),
                      SizedBox(height: 16),
                      // Submit Button
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: AppColor.app_btn_color,
                      //       padding: EdgeInsets.symmetric(vertical: 14),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       "Submit",
                      //       style: TextStyle(fontSize: 12,color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      // Issue Report Link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ClaimScreen()));
                          },
                          child: Text(
                            "Claim History",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
  Widget _buildDetailRow1(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
