import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/gift_claim/success_msg_claim.dart';

import '../../providers_of_app/dashboard_provider/dashboard_provider.dart';
import '../../providers_of_app/gift_claim_provider/gift_claim_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/localization/localization_en.dart';
import '../../res/values/values.dart';
import '../report_issues/raised_issues_ui.dart';

class GiftClaimUI extends StatefulWidget {
  const GiftClaimUI({super.key});

  @override
  State<GiftClaimUI> createState() => _GiftClaimUIState();
}

class _GiftClaimUIState extends State<GiftClaimUI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<GiftProvider>(context, listen: false).getGift();
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gifts'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20, left: 16, right: 16),
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
                    String total_point = valustate.dashbaord!.totalPoint ?? "0";
                    String transferred_point =
                        valustate.dashbaord!.reedemPoint ?? "0";
                    var points;
                    if (total_point.isNotEmpty &&
                        transferred_point.isNotEmpty) {
                      var e = double.parse(total_point);
                      var f = double.parse(transferred_point);
                      // wallett = e - f;
                      points = total_point;
                    } else {
                      points = "0";
                    }
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: splashProvider.color_bg,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.card_giftcard, color: Colors.white),
                              SizedBox(width: 8.0),
                              Text(
                                'Total Point Balance',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          ),
                          Text(
                            total_point,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }),
            ),
            // GridView for Gifts
            Consumer<GiftProvider>(builder: (context, valustate, child) {
              if (valustate.isloading_gift) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please Wait"),
                    CircularProgressIndicator(),
                  ],
                ));
              } else {
                if (valustate.hasError_gift) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(' ${valustate.errorMessage_gift}'),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            valustate.retryGift();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))

                      ),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 90 / 100,
                        ),
                        itemCount: valustate.gift1!.data!.length,
                        itemBuilder: (context, index) {
                          return GiftCard(
                            image: valustate.gift1!.data![index].giftImage ?? "",
                            title: valustate.gift1!.data![index].giftName ?? "",
                            description:
                                valustate.gift1!.data![index].giftDesc ?? "",
                            price: valustate.gift1!.data![index].giftValue
                                .toString(),
                            provider: valustate,
                            index: index,
                          );
                        },
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

class GiftCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;
  final int index;
  final GiftProvider provider;

  const GiftCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.index,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _presentBottomSheet(context, provider, index);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Container(
          height: 100,
          child: Stack(
            children: [
              // Background Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(image,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill, errorBuilder: (BuildContext context,
                        Object error, StackTrace? stackTrace) {
                  // Handle the error (e.g., image not found, 404, etc.)
                  // Return a placeholder image or any fallback widget
                  return Image.asset(
                    'assets/place_ho.png', // Your placeholder image
                    fit: BoxFit.fill,
                  );
                }),
              ),
              // Gradient Overlay (optional, to improve text readability)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Content on top of the Image
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Gift Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    // Gift Description
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white70,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6.0),
                    // Price Badge

                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  margin: EdgeInsets.only(top: 10,right: 10),
                  decoration: BoxDecoration(
                    color: AppColors.gift_green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$price',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _presentBottomSheet(
      BuildContext context1, GiftProvider historyProvider, index) {
    showModalBottomSheet(
      context: context1,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) => Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 6, // 10%
                    child: Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 20, top: 0, right: 10),
                      child: const Text(
                        "Gift Details !",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                child: Text(
                  "Hey User, please check details before claiming.",
                  style: GoogleFonts.roboto(
                      fontSize: 12, color: AppColors.yellow_app),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 100, // Set a fixed height for the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      historyProvider.gift1!.data![index].giftImages!.length,
                  itemBuilder: (context, imageIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          historyProvider
                              .gift1!.data![index].giftImages![imageIndex],
                          height: 100,
                          width: 90,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              // You can add a loading spinner or any other placeholder here
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // Handle the error (e.g., image not found, 404, etc.)
                            // Return a placeholder image or any fallback widget
                            return Image.asset(
                              'assets/place_ho.png',
                              // Your placeholder image
                              height: 100,
                              width: 90,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: Text(
                          "Gift Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Text(
                      ":",
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          historyProvider.gift1!.data![index].giftName!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 11),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: Text(
                          "Gift Des",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Text(
                      ":",
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          historyProvider.gift1!.data![index].giftDesc
                              .toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 11),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: Text(
                          "Gift Points",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Text(
                      ":",
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          historyProvider.gift1!.data![index].giftValue
                              .toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 11),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFF3F5FC)),
                padding: EdgeInsets.all(16),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: AppColors.yellow_app, fontSize: 12),
                    // Default text style
                    children: [
                      TextSpan(
                        text:
                            "If you have any support, please call this number: ",
                      ),
                      TextSpan(
                        text: "+91 7353000903", // Phone number
                        style: TextStyle(
                          color: AppColor.app_btn_color, // Different color
                          fontWeight: FontWeight.bold, // Make it bold
                        ),
                      ),
                      TextSpan(
                        text: ". You can also send an email to ",
                      ),
                      TextSpan(
                        text: "supportteam@vcqru.com", // Email
                        style: TextStyle(
                          color: AppColor.app_btn_color, // Different color
                          fontStyle: FontStyle.italic, // Make it italic
                        ),
                      ),
                      TextSpan(
                        text: " or raise a ticket. Additionally, ",
                      ),
                      TextSpan(
                        text: "click here.",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen()));

                          },// "click here" text
                        style: TextStyle(
                          color: AppColor.app_btn_color, // Different color
                          decoration:
                          TextDecoration.underline, // Underline the text
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<GiftProvider>(builder: (context,claim_provider,child){
                return Visibility(
                  visible:historyProvider.gift1!.data![index].btnFlag==1?true:false,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: CustomElevatedButton(
                      onPressed: () async {
                        print("----------");

                        var serId="";
                        var pId=claim_provider.gift1!.data![index].giftId??"";
                        var PV=claim_provider.gift1!.data![index].giftValue??"";
                       var responce= await claim_provider.submitClaim(serId,pId,PV);
                        if (responce != null) {
                          var status = responce["success"] ?? false;
                          var msg = responce["message"] ?? "";
                          if (status) {
                            var userData = responce['data'];
                            if (userData != null) {
                              Navigator.push(context1, MaterialPageRoute(builder: (context)=>ClaimMsgSuccessScreen(
                                msg: responce['message']??"",
                                giftName:responce['data']['Gift_name']??"",
                                giftValue:(responce['data']['Gift_value'] ?? 0).toString(),
                                claimType:responce['data']['ClaimType']??"",
                                redeemP:responce['data']['RedeemPoint']??"",
                                availableP:responce['data']['AvailablePoint']??"",
                              )));
                            } else {
                              CustomAlert.showMessage(
                                  context,
                                  "Info",
                                  msg,
                                  AlertType.info);
                            }
                          } else {
                            CustomAlert.showMessage(
                                context,
                                "Info",
                                msg,
                                AlertType.info);
                          }
                        } else {
                          CustomAlert.showMessage(
                              context,
                              "Info",
                              "'Something Went Wrong' Please Try Again Later",
                              AlertType.info);
                        }
                      },
                      buttonColor: AppColors.gift_green,
                      textColor: AppColor.white_color,
                      widget: historyProvider.isloaing_claim ? CircularProgressIndicator(
                        color: AppColor.white_color,
                        strokeAlign: 0,
                        strokeWidth: 4,
                      ) :
                      CustomText(
                        text: LocalizationEN.CLAIM_NOW,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color:  AppColor.white_color,
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
