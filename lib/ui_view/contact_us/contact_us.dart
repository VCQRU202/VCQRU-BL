import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/contact_us_provider/contact_us_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Contact Us',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: splashProvider.color_bg,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        splashProvider.color_bg.withOpacity(1.0),
                        splashProvider.color_bg.withOpacity(1.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),Expanded(
                flex: 4,
                child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    )
                ),
              )
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset("assets/contact_us.png",height:
                orientation == Orientation.landscape ? 150 : 280 ,),
                Consumer<ContactDetailsProvider>(
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
                                    valustate.retryFetchContact();
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.white),
                            child:Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30), color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "GET IN TOUCH!",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Color(0xff474747),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(

                                      height: 10,
                                    ),
                                    Text(
                                      "Mobile Number",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    Text(
                                      valustate.historyContact?.data?.contactUsNo??"",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Divider(),
                                    Text(
                                      "Email",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    Text(
                                      valustate.historyContact?.data?.contactUsEmail??"",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Divider(),
                                    Text(
                                      "Location",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    Text(
                                      valustate.historyContact?.data?.contactUSAddress??"",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    })
              ],
            ),
            ),
          )
        ],
      ),
    );
  }
}
class GetInTouch extends StatelessWidget {
  const GetInTouch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "GET IN TOUCH!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff474747),
                  ),
                ),
              ],
            ),
            SizedBox(

              height: 10,
            ),
            Text(
              "Mobile Number",
              style: TextStyle(color: Colors.blueGrey),
            ),
            Text(
              "9958644640",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              "Email",
              style: TextStyle(color: Colors.blueGrey),
            ),
            Text(
              "vcqru@vcqru.com",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              "Location",
              style: TextStyle(color: Colors.blueGrey),
            ),
            Text(
              "Unit- 1502-1503, Tower 4, DLF CORPORATE GREENS, Sector74A, Narsinghpur, Gurugram, Haryana 122004",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
