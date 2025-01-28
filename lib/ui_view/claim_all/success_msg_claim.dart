import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../../providers_of_app/scanner_provider/scanner_provider.dart';
import '../../models/claim/final_submit_claim_model.dart';

class SubmitClaimFinalSuccessScreen extends StatefulWidget {
  String codedate;
  String point;
  String cash;
  String msg;
  List<ClaimDetails>? claimDetails;
  SubmitClaimFinalSuccessScreen({
    required this.codedate,
    required this.point,
    required this.cash,
    required this.msg,
    required this.claimDetails
  });

  @override
  State<SubmitClaimFinalSuccessScreen> createState() => _CodeCheckSuccessScreenState();
}

class _CodeCheckSuccessScreenState extends State<SubmitClaimFinalSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16),
                      child: Text(
                       widget.msg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: Text(
                        widget.codedate,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // Details Card
              Card(
                margin: EdgeInsets.only(left: 16,right: 16),
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
                              "Claimed Points",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.point,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("/"),
                                Text(
                                  widget.cash,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3, // Adjust ratio for card height
                        ),
                        itemCount: widget.claimDetails!.length,
                        shrinkWrap: true, // Makes ListView take only the required height
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = widget.claimDetails?[index];
                          final key = item?.key??"";
                          final value = item?.value??"";

                          return Container(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    key,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: key == "Status" && value == "Success"
                                          ? Colors.green
                                          : Colors.black
                              
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen(ticketType: "Code Check Success${widget.code}")));
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


