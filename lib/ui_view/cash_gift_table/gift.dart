import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import 'cash_success.dart';

class CashGiftList extends StatefulWidget {
  const CashGiftList({super.key});

  @override
  State<CashGiftList> createState() => _my_GiftState();
}

class _my_GiftState extends State<CashGiftList> {
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gifts'),
        centerTitle: true,
        backgroundColor: splashProvider.color_bg,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: splashProvider.color_bg),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                     Image.asset('assets/coin.png'),
                                      Text(
                                        'Total Point Balance',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text('1000',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                ValueOfPoint() //SizedBox(width: 10,height: 10,)
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //   //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              //   child: ValueOfPoint(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class ValueOfPoint extends StatelessWidget {
  List<Map<String, dynamic>> giftList = [
    {'INR': 500, 'POINTS': 500},
    {'INR': 2000, 'POINTS': 1000},
    {'INR': 3500, 'POINTS': 1500},
    {'INR': 4500, 'POINTS': 2000},
    {'INR': 500, 'POINTS': 500},
    {'INR': 2000, 'POINTS': 1000},
    {'INR': 3500, 'POINTS': 1500},
    {'INR': 4500, 'POINTS': 2000}
  ];

  String? upi_id='9958644640@paytm';

  String? upi_id_name='AKASH KUMAR';
  bool is_upi_id_true=true;

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    void bottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Confirm Redeem",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff313034)),
                      ),
                      GestureDetector(onTap: () {
                        Navigator.pop(context);
                      },child: Icon(Icons.cancel,size: 20,color: Color(0xff6C757D),))
                    ],
                  ),
                  Text(
                    'Verify Your UPI ID. This ammount will be sent to your UPI ID.',
                    style: TextStyle(color: Color(0xff6C757D), fontSize: 14),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'UPI ID',
                    style: TextStyle(fontSize: 12, color: Color(0xff5F5E62),fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            upi_id!,
                            style: TextStyle(fontSize: 14),
                          ),
                          is_upi_id_true?Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ):Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 20,)
                        ],
                      ),
                    ),
                  ),
                  Text(
                    upi_id_name!,
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>CashSuccess()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              )),
            );
          });
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: giftList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 290,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(-0.6, -3.4),
                stops: [0.0, 0.3, 0.3, 0.6, 0.6, 1.0],
                // Adjusted stops
                colors: [
                  splashProvider.color_bg,
                  splashProvider.color_bg,
                  splashProvider.color_bg.withOpacity(0.6),
                  splashProvider.color_bg.withOpacity(0.6),
                  splashProvider.color_bg,
                  splashProvider.color_bg, //Color(0xFFA000F5),
                ],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        width: 65,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/Vector.svg',
                                    width: 8.9,
                                    height: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${giftList[index]['POINTS']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Value of Points',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10
                            ),
                          ),
                          Text(
                            "${giftList[index]['INR'].toString()} INR",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          )
                        ],
                      ),
                      Container(
                        height: 40,
                          margin: EdgeInsets.only(right: 30,top: 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.greenAccent.withOpacity(0.4)),
                          child: TextButton(
                              onPressed: () {
                                bottomSheet();
                              },
                              child: Text(
                                "Claim",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
