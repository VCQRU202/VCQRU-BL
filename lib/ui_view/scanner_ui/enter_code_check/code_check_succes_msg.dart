import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../../providers_of_app/scanner_provider/scanner_provider.dart';
import '../../../res/app_colors/app_colors.dart';
import '../../report_issues/raised_issues_ui.dart';
class CodeCheckSuccessScreen extends StatefulWidget {
  String msg,point,status,codtype,code,codedate;
  CodeCheckSuccessScreen({
    required this.msg,
    required this.point,
    required this.status,
    required this.codtype,
    required this.code,
    required this.codedate
  });

  @override
  State<CodeCheckSuccessScreen> createState() => _CodeCheckSuccessScreenState();
}

class _CodeCheckSuccessScreenState extends State<CodeCheckSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DashboardProvider>(context, listen: false).fetchWallet();

  }
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
                              Provider.of<Scanner_provider>(context, listen: false).startCemra();
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
                    SizedBox(height: 16),
                    Text(
                      widget.status,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        widget. msg,
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
                              widget.point,
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
                              child: _buildDetailRow("Code Number", widget.code)
                          ),
                          Expanded(flex: 5,child: _buildDetailRow("Code Type", widget.codtype)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 5,child: _buildDetailRow("Status", widget.status)),
                          Expanded(flex: 5,child: _buildDetailRow1("Code Check Date",widget.codedate)),
                        ],
                      ),
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
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen()));
                          },
                          child: Text(
                            "Issue Report",
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


