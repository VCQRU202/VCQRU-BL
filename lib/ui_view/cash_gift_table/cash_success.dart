import 'package:flutter/material.dart';

class CashSuccess extends StatefulWidget {
  const CashSuccess({super.key});

  @override
  State<CashSuccess> createState() => _CashSuccessState();
}

class _CashSuccessState extends State<CashSuccess> {
  @override
  Widget build(BuildContext context) {
    String? claim_date = '25 Feb 2023, 13:22';
    String? claim_point = '1,000 /';
    String? claim_point_rs = '₹205';
    String? claim_id = '000085752257';
    String? claim_available_point = '965';
    String? claim_type = 'Point Claim';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 600,
              child: Container(
                color: Colors.green,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.greenAccent,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Claim Redeem',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        claim_date!,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 10,
              right: 10,
              child: Container(
                // height: 300,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Claimed Points',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff474747),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            claim_point,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            claim_point_rs,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff3D2AE7),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Claim Id',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff707070)),
                                ),
                                Text(
                                  claim_id,
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  'Claim Type',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff707070)),
                                ),
                                Text(
                                  claim_type,
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Available Points',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff707070)),
                                ),
                                Text(
                                  claim_available_point,
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  'Gift Status',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff707070)),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff05AE251A)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
                                    child: Text(
                                      'Success',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      Divider(),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Claim History',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff3D2AE7)),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
