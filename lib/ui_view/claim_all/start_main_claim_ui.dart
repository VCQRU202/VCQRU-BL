import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/claim_all/success_msg_claim.dart';

import '../../models/claim/final_submit_claim_model.dart';
import '../../models/gift/gift_model.dart';
import '../../providers_of_app/claim_providers/claim_main_provider.dart';
import '../../providers_of_app/gift_claim_provider/gift_claim_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/localization/localization_en.dart';
import '../../res/values/values.dart';
import '../claim_history_ui/claim_history_ui.dart';
import '../e_kyc_ui/account_verify/account_verify.dart';
import '../e_kyc_ui/upi_verify/upi_verify_ui.dart';
import '../gift_claim/gift_claim.dart';
import '../gift_claim/success_msg_claim.dart';
import '../report_issues/raised_issues_ui.dart';
import 'claim_ui_main_list.dart';
class ClaimStartMain extends StatefulWidget {
  const ClaimStartMain({super.key});

  @override
  State<ClaimStartMain> createState() => _ClaimStartMainState();
}

class _ClaimStartMainState extends State<ClaimStartMain> {
 // String? _selectedIconName;
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
        child:Consumer<GiftProvider>(
            builder: (context, valustate, child) {
              if (valustate.isloading_gift) {
                return Center(
                    child: Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.only(top: 10),
                        child: CircularProgressIndicator()));
              } else {
                if (valustate.hasError_gift) {
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
                          Text(' ${valustate.errorMessage_gift}'),
                          ElevatedButton(
                            onPressed: () {
                              valustate.retryGift();
                            },
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  final claimData = valustate.gift1?.data?.rows??[];
                  final cashData = valustate.gift1?.data?.cashData??[];
                  final bannerData = valustate.gift1?.data?.banners??[];

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15,top: 16),
                          child: Column(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias, // Ensures the child is clipped to match the card's shape
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Sets the border radius of the card
                                ), // Ensures the background image is clipped to the card's shape
                                child: Container(
                                  height: 116, // Set the height of the card
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(bannerData[0].value??""), // Replace with your image URL
                                      fit: BoxFit.cover, // Ensures the image covers the entire card
                                    ),
                                  ),
                                  child:Container(
                                    margin: EdgeInsets.only(left: 16,right: 15,top: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(bannerData[0].bannertext1??""
                                        ,style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w800
                                          ),),
                                        Row(
                                          children: [
                                            Text(bannerData[0].bannertext2??""),
                                            Text(bannerData[0].bannertext3??"",),
                                          ],
                                        ),
                                        Text(bannerData[0].bannertext4??"",style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w800
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(bannerData[0].text??"",
                                    textAlign: TextAlign.start,style: TextStyle(fontSize: 12),)
                              )
                            ],
                          ),
                        ),
                    
                        cashData.length>0? Container(
                          margin: EdgeInsets.only(top: 16, bottom: 0, left: 16, right: 16),
                          child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Text(cashData[0].key??"Cash",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                    ),
                                  )
                              ),
                              GestureDetector(
                                onTap: (){
                                  print("----Avaible bl---${bannerData[0].bannertext3}");
                                  //valustate.retryFetchClaimMainData();
                                  _showBottomSheet(context,bannerData[0].bannertext3??"");
                                  //_showFullScreenBottomSheet(context);
                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>ClaimScreenSelect()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 0, bottom: 16,),
                                  height: 50,
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            padding: const EdgeInsets.only(left: 10,right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft: Radius.circular(4)
                                              ),
                                              color: AppColors.white,
                                            ),
                                            child: Icon(Icons.card_giftcard,size: 34, color: Colors.black54)
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                      Expanded(
                                          flex: 8,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(4),
                                                  bottomRight: Radius.circular(4)
                                              ),
                                              color: AppColors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      (cashData[0].value??"Points convert to cash"),
                                                      maxLines: 2,
                                                      softWrap: true,
                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                                                  ),
                                                  Icon(Icons.arrow_forward_ios_outlined,size: 24, color:Colors.grey,),
                                                ],
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ):Container(),
                        claimData.length>0?Column(
                          children: [
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 16,right: 16),
                                child: Text("My Gift",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                  ),
                                )
                            ),
                            ListView.builder(
                                itemCount:claimData.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:(context, index){
                                  bool isUnlocked=true;
                                  double pers = 0.0;
                                  if (claimData.length > 0) {
                                    int v = claimData[index].giftPoint ?? 0; // Gift points
                                    int av = int.tryParse(claimData[index].availablePoint ?? "0") ?? 0; // Available points

                                    if (v > 0) {
                                      pers = (av / v) * 100; // Calculate percentage
                                    } else {
                                      pers = 0.0; // Avoid division by zero
                                    }
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      _presentBottomSheet1(context, claimData, index);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 10),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 74,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft: Radius.circular(4)
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: claimData[index].giftImage != null && claimData[index].giftImage!.isNotEmpty
                                                ? Image.network(claimData[index].giftImage!)
                                                : Icon(
                                              Icons.image_not_supported, // Placeholder icon
                                              size: 50, // Adjust the size as needed
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 1,),
                                          Expanded(
                                            child: Container(
                                              height: 74,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(4),
                                                    bottomRight: Radius.circular(4)
                                                ),
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.only(left: 8,top: 4,right: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    claimData[index].giftName??"",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                  SizedBox(height: 8),
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: LinearProgressIndicator(
                                                      value: pers / 100, // Convert percentage to a fraction (0.0 to 1.0)
                                                      color: isUnlocked
                                                          ? Colors.green
                                                          : Colors.orange,
                                                      backgroundColor: Colors.grey[300],
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Text('${(index + 1) * 100} Points'),
                                                      Spacer(),
                                                      pers >= 100 ? Icon(Icons.lock_open,  color: Colors.green) // Open lock for 100%
                                                          : Icon(Icons.lock,  color: Colors.grey)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ],
                        ):Container()
                      ],
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
  void _presentBottomSheet(
      BuildContext context1, List<Rows>? rows, index) {
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
                margin: EdgeInsets.only(top: 10),
                height: 100, // Set a fixed height for the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: rows?[index].giftImages!.length,
                  itemBuilder: (context, imageIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          rows?[index].giftImages?[imageIndex]??"",
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
                          rows![index].giftName!,
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
                          rows![index].giftDesc
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
                          rows![index].giftPoint.toString(),
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
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context)=>RaisedTicketScreen(ticketType: "Claim",)));

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
                  visible:rows![index].btnFlag==1?true:false,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: CustomElevatedButton(
                      onPressed: () async {
                        print("----------");

                        var serId="";
                        var pId=claim_provider.gift1!.data!.rows![index].giftId??"";
                        var PV=claim_provider.gift1!.data!.rows![index].giftValue??"";
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
                      widget: claim_provider.isloaing_claim ? CircularProgressIndicator(
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
  void _presentBottomSheet1(BuildContext context1, List<Rows>? rows, index) {
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
      builder: (context)
      {

        bool isUnlocked=true;
        double pers = 0.0;
        if (rows!.length > 0) {
          int v = rows[index].giftPoint ?? 0; // Gift points
          int av = int.tryParse(rows![index].availablePoint ?? "0") ?? 0; // Available points

          if (v > 0) {
            pers = (av / v) * 100; // Calculate percentage
          } else {
            pers = 0.0; // Avoid division by zero
          }
        }
        return Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  margin: EdgeInsets.only(left: 10,right: 16),
                  height: 100, // Set a fixed height for the horizontal list
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: rows?[index].giftImages!.length,
                    itemBuilder: (context, imageIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            rows?[index].giftImages?[imageIndex] ?? "",
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
                                        ? loadingProgress
                                        .cumulativeBytesLoaded /
                                        (loadingProgress
                                            .expectedTotalBytes ??
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
                SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    rows![index].giftName!,
                    textAlign: TextAlign.left,
                    style:  GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 14),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16,right: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: pers / 100, // Convert percentage to a fraction (0.0 to 1.0)
                      color: isUnlocked
                          ? Colors.green
                          : Colors.orange,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            rows![index].giftPoint.toString(),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 12),
                          ),
                          Text(
                            ' Points',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 12),
                          ),
                        ],
                      ),
              pers >= 100 ? Icon(Icons.lock_open,  color: Colors.green) // Open lock for 100%
                : Icon(Icons.lock,  color: Colors.red)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 14, right: 10),
                  child: Text(
                    rows![index].giftDesc.toString(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontStyle: FontStyle.normal,
                        fontSize: 14),
                  ),
                ),
                Consumer<GiftProvider>(builder: (context,claim_provider,child){
                  return Visibility(
                    visible:rows![index].btnFlag==1?true:false,
                   // visible:true,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 10),
                      child: CustomElevatedButton(
                        onPressed: () async {
                          print("----------");

                          var serId="";
                          var pId=claim_provider.gift1!.data!.rows![index].giftId??"";
                          var PV=claim_provider.gift1!.data!.rows![index].giftValue??"";
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
                        widget: claim_provider.isloaing_claim ? CircularProgressIndicator(
                          color: AppColor.white_color,
                          strokeAlign: 0,
                          strokeWidth: 4,
                        ) :
                        CustomText(
                          text:"Redeem for ${claim_provider.gift1!.data!.rows![index].giftPoint??""} Points",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:  AppColor.white_color,
                        ),
                      ),
                    ),
                  );
                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Available Points: ${rows![index].availablePoint??""}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                // Consumer<GiftProvider>(
                //     builder: (context, claim_provider, child) {
                //       return Visibility(
                //         visible: rows![index].btnFlag == 1 ? true : false,
                //         child: Container(
                //           width: double.infinity,
                //           margin: EdgeInsets.only(left: 20, right: 20),
                //           child: CustomElevatedButton(
                //             onPressed: () async {
                //               print("----------");
                //
                //               var serId = "";
                //               var pId =
                //                   claim_provider.gift1!.data!.rows![index].giftId ??
                //                       "";
                //               var PV = claim_provider
                //                   .gift1!.data!.rows![index].giftValue ??
                //                   "";
                //               var responce =
                //               await claim_provider.submitClaim(serId, pId, PV);
                //               if (responce != null) {
                //                 var status = responce["success"] ?? false;
                //                 var msg = responce["message"] ?? "";
                //                 if (status) {
                //                   var userData = responce['data'];
                //                   if (userData != null) {
                //                     Navigator.push(
                //                         context1,
                //                         MaterialPageRoute(
                //                             builder: (context) =>
                //                                 ClaimMsgSuccessScreen(
                //                                   msg: responce['message'] ?? "",
                //                                   giftName: responce['data']
                //                                   ['Gift_name'] ??
                //                                       "",
                //                                   giftValue: (responce['data']
                //                                   ['Gift_value'] ??
                //                                       0)
                //                                       .toString(),
                //                                   claimType: responce['data']
                //                                   ['ClaimType'] ??
                //                                       "",
                //                                   redeemP: responce['data']
                //                                   ['RedeemPoint'] ??
                //                                       "",
                //                                   availableP: responce['data']
                //                                   ['AvailablePoint'] ??
                //                                       "",
                //                                 )));
                //                   } else {
                //                     CustomAlert.showMessage(
                //                         context, "Info", msg, AlertType.info);
                //                   }
                //                 } else {
                //                   CustomAlert.showMessage(
                //                       context, "Info", msg, AlertType.info);
                //                 }
                //               } else {
                //                 CustomAlert.showMessage(
                //                     context,
                //                     "Info",
                //                     "'Something Went Wrong' Please Try Again Later",
                //                     AlertType.info);
                //               }
                //             },
                //             buttonColor: AppColors.gift_green,
                //             textColor: AppColor.white_color,
                //             widget: claim_provider.isloaing_claim
                //                 ? CircularProgressIndicator(
                //               color: AppColor.white_color,
                //               strokeAlign: 0,
                //               strokeWidth: 4,
                //             )
                //                 : CustomText(
                //               text: LocalizationEN.CLAIM_NOW,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 14,
                //               color: AppColor.white_color,
                //             ),
                //           ),
                //         ),
                //       );
                //     }),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }
  void _showBottomSheet(BuildContext context,String avail) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      useSafeArea: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer<CliamMainProvider>(
              builder: (context, valustate, child) {
                if (valustate.isLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Please Wait"),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else if (valustate.hasError) {
                  return SingleChildScrollView(
                    child: Center(
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
                    ),
                  );
                } else {
                  var claimRequire = valustate.historyData?.data?.claimRequired ?? "";
                  var listData = valustate.historyData?.data?.icons ?? [];
                  return SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Convert to cash',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () {
                                    valustate.setSelectedIconName(null);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.cancel, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16),
                            child: Text(
                                "Please choose one of your converted payment options.",
                              style: GoogleFonts.roboto(fontSize: 14),
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              itemCount: listData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final method = listData[index];
                                return GestureDetector(
                                  onTap: () {
                                      valustate.setSelectedIconName(method.iconName);
                                      print("-------method----${method.id}");
                                      valustate.setselectedTypeMethod(method.id);// Update the selected value
                                    if (method.id != null && (method.id ?? "").isNotEmpty) {
                                      if ((method.id ?? "").endsWith("gift")) {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => GiftClaimUI()));
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 16,right: 16,bottom: 10),
                                    decoration: BoxDecoration(
                                        color: (valustate.selectedIconName != null && valustate.selectedIconName == method.iconName)?Colors.green.withOpacity(0.05):Colors.white
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
                                                  Container(
                                                    width: 40, // Ensure the container is large enough for the image and border
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle, // Make the border circular
                                                      border: Border.all(
                                                        color: Color(0xFFE7E7E7), // Circle border color
                                                        width: 1, // Border width
                                                      ),
                                                    ),
                                                    child: ClipOval(
                                                      child: Image.network(
                                                        method.imagePath ?? "",
                                                        width: 40,
                                                        height: 24,
                                                        fit: BoxFit.contain, // Ensures the image fits within the circle
                                                      ),
                                                    ),
                                                  ),
                                              SizedBox(width: 8,),
                                                  Text(
                                                    method.iconName ?? "".toUpperCase(),
                                                    style: GoogleFonts.roboto(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 4.0),
                                            Radio<String>(
                                              value: method.iconName ?? "", // The value of this radio button
                                              groupValue: valustate.selectedIconName, // The selected value to compare with
                                              onChanged: (String? value) {
                                                  valustate.setSelectedIconName(value);// Update the selected value
                                              },
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: valustate.selectedIconName != null && valustate.selectedIconName == method.iconName,
                                          child: Row(
                                            children: [
                                              Text(
                                                method.containts ?? "",
                                                style: GoogleFonts.roboto(
                                                  color: Color(0xFF6C757D),
                                                  fontSize: 12,
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
                          ),
                          // Visibility(
                          //   visible:valustate.selectedIconName != null,
                          //   child: Container(
                          //     width: double.infinity,
                          //     padding: EdgeInsets.all(10),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(8),
                          //         topRight: Radius.circular(8),
                          //       ),
                          //       color: Colors.white,
                          //     ),
                          //     child: ElevatedButton(
                          //       onPressed: () {
                          //
                          //       },
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: AppColors.gift_green,
                          //         padding: EdgeInsets.symmetric(vertical: 10),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //       ),
                          //       child: Text(
                          //         'Proceed',
                          //         style: TextStyle(fontSize: 16, color: Colors.white),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Visibility(
                            visible:valustate.selectedIconName != null,
                            child: Consumer<CliamMainProvider>(
                              builder: (context, valueProvider, child) {
                                print("------valueProvider--${valueProvider.isLoading_confirm}");
                                return Container(
                                  margin: EdgeInsets.only(left: 10, right: 10,bottom: 20),
                                  width: double.infinity,
                                  child: CustomElevatedButton(
                                    onPressed: () async {
                                      print(valustate.selectedIconName);
                                      var value1 = await valueProvider.getDataForClaimConfirm(valueProvider.selectedTypeMethod);
                                      if (value1 != null) {
                                        var status = value1["success"] ?? false;
                                        var msg = value1["message"] ?? "";
                                        if (status) {
                                          var data=value1['data'];
                                          if(data!=null){
                                            var datacofirm_detail=data['consumerdetails'];
                                            var datacofirm=data['confirmdata'];
                                            if(datacofirm!=null){
                                              var confirmDataVa= valueProvider.historyData_confirm;
                                              bool flag=confirmDataVa?.data?.confirmdata?.flag??false;
                                              print("--not add details upi${flag}");
                                              if(flag){
                                                Navigator.pop(context);
                                                valustate.setSelectedIconName(null);
                                                ConfirmWithoutUpi(context,valueProvider);
                                              }else{
                                                Navigator.pop(context);
                                                valustate.setSelectedIconName(null);
                                                ConfirmExistDetails(context,valueProvider,avail);
                                              }
                                            }else{
                                              CustomAlert.showMessage(
                                                  context,
                                                  "Info",
                                                  "'Something Went Wrong' Please Try Again Later",
                                                  AlertType.info);
                                            }
                                          }else{
                                            CustomAlert.showMessage(
                                                context,
                                                "Info",
                                                "'Something Went Wrong' Please Try Again Later",
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
                                    buttonColor:AppColors.gift_green,
                                    textColor: AppColor.white_color,
                                    widget: valueProvider.isLoading_confirm
                                        ? CircularProgressIndicator(
                                      color: AppColor.white_color,
                                      strokeAlign: 0,
                                      strokeWidth: 4,
                                    )
                                        : CustomText(
                                      text: LocalizationEN.CLAIM_NOW,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColor.white_color,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
  void ConfirmWithoutUpi(BuildContext context,CliamMainProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Color(0xff697179),
                      ))
                ],
              ),
              Text(
                provider.historyData_confirm?.data?.confirmdata?.heading??"",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8,),
              Text(
                provider.historyData_confirm?.data?.confirmdata?.alternatedata??"",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16,),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xff5545EB),
                  shape: RoundedRectangleBorder( // Use RoundedRectangleBorder for rounded corners
                    borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if(provider.selectedTypeMethod!=null&&provider.selectedTypeMethod!.endsWith("upi")){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UpiIdVerifyUI()));
                  }
                  if(provider.selectedTypeMethod!=null&&provider.selectedTypeMethod!.endsWith("imps")){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AccountVerifyUI()));
                  }
                },
                child: Text(
                  "Click to add ${provider.historyData_confirm?.data?.confirmdata?.methodname ?? ""}",
                  style: TextStyle(fontSize: 12),
                ),
              )

            ],
          ),
        );
      },
    );
  }
  void ConfirmExistDetails(BuildContext context,CliamMainProvider provider,String availBl) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Color(0xff697179),
                      ),
                    )
                  ],
                ),
                Text(
                  provider.historyData_confirm?.data?.confirmdata?.heading??"",
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                ),
                Text(
                    provider.historyData_confirm?.data?.confirmdata?.headingparagraph??"",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,
                        color: Color(0xff6c757d))),
                SizedBox(
                  height: 10,
                ),
                Text(provider.historyData_confirm?.data?.confirmdata?.methodname??"",
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: Color(
                        0xff5f5e62))),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(provider.historyData_confirm?.data?.confirmdata?.paymentDetails??"",
                            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
                        Icon(
                          Icons.check_circle,
                          color: Color(0xff4EA829),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  provider.historyData_confirm?.data?.confirmdata?.payeeName??"",
                  style: TextStyle(color: Color(0xff4EA829),fontSize: 12,fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ConfirmUpiCLIAMWithDetail(context,provider,availBl);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xff5545EB),
                      shape: RoundedRectangleBorder( // Use RoundedRectangleBorder for rounded corners
                        borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                      ),
                    ),
                    child: Text('Confirm'))
              ],
            ),
          ),
        );
      },
    );
  }
  void ConfirmUpiCLIAMWithDetail(BuildContext context,CliamMainProvider provider,String avaiBL) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding:
            const EdgeInsets.only(top: 25, left: 12, right: 12, bottom: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.historyData_confirm?.data?.message?[0].key??"",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Color(0xff697179),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text( provider.historyData_confirm?.data?.message?[0].value??""),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.historyData_confirm?.data?.consumerdetails?.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                                provider.historyData_confirm?.data?.consumerdetails?[index].key??"",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Text(":"),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child:Text(provider.historyData_confirm?.data?.consumerdetails?[index].value??""))),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // FilledButton(
                  //     style: FilledButton.styleFrom(
                  //         backgroundColor: Color(0xff4EA829),
                  //         shape: BeveledRectangleBorder(
                  //             borderRadius: BorderRadius.circular(5))),
                  //     onPressed: () {
                  //     print("---Avaible--${avaiBL}");
                  //     },
                  //     child: Text('Claim')),

                  Consumer<CliamMainProvider>(
                    builder: (context, valueProvider, child) {
                      print("------valueProvider--${valueProvider.isLoading_subclaim}");
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10,bottom: 20),
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: () async {
                            print("---Avaible--${avaiBL}");
                            DateTime now = DateTime.now();

                            // Format the date and time
                            String formattedDate = DateFormat('yyyy-MM-dd').format(now); // Example: 2025-01-22
                            String formattedTime = DateFormat('HH:mm:ss').format(now);

                            var value1 = await valueProvider.getSubmitClaimForCash(
                                valueProvider.selectedTypeMethod,
                                avaiBL
                            );
                            if (value1 != null) {
                              var status = value1["success"] ?? false;
                              var msg = value1["message"] ?? "";
                              if (status) {
                                var data=value1['data'];
                                if(data!=null){
                                  Navigator.pop(context);
                                  SubmitClaimFinalModel subData=SubmitClaimFinalModel.fromJson(value1);
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context)=>SubmitClaimFinalSuccessScreen(
                                    cash: subData.data?.claimedcash??"",
                                    msg: subData.message??"",
                                    point: (subData.data?.claimedpoint).toString(),
                                    codedate: formattedDate+formattedTime,
                                        claimDetails:subData.data?.claimDetails??[],
                                  )));
                                }else{
                                  CustomAlert.showMessage(
                                      context,
                                      "Info",
                                      "'Something Went Wrong' Please Try Again Later",
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
                          buttonColor:AppColors.gift_green,
                          textColor: AppColor.white_color,
                          widget: valueProvider.isLoading_subclaim
                              ? CircularProgressIndicator(
                            color: AppColor.white_color,
                            strokeAlign: 0,
                            strokeWidth: 4,
                          )
                              : CustomText(
                            text: LocalizationEN.CLAIM_NOW,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColor.white_color,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

}
