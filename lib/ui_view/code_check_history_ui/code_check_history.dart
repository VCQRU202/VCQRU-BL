import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../res/values/values.dart';
import '../../providers_of_app/code_check_history_provider/code_check_history_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/app_colors.dart';
import '../report_issues/raised_issues_ui.dart';

class HistroyCodeCheck extends StatefulWidget {
  HistroyCodeCheck({super.key});

  @override
  State<HistroyCodeCheck> createState() => _HistroyCodeCheckState();
}

class _HistroyCodeCheckState extends State<HistroyCodeCheck> {
  bool success_setvalue = false;
  bool unsuccess_setvalue = false;
  bool failed_setvalue = false;

  bool anti_setvalue = false;
  bool loyal_setvalue = false;
  bool warr_setvalue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CodeCheckHistoryProvider>(context, listen: false).getCodeCheckHistory();
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "History",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: splashProvider.color_bg,
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     // Navigator.push(context,
          //     //     MaterialPageRoute(builder: (context) => SearchScreen()));
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.filter_alt),
          //   onPressed: () {
          //    // _presentBottomSheetFilter(context);
          //   },
          // )
        ],
      ),
      body: Consumer<CodeCheckHistoryProvider>(
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
                      valustate.retryFetchProfile();
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
              child: getBody(valustate),
            );
          }
        }
      }),
    );
  }

  Widget getBody(CodeCheckHistoryProvider historyProvider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height / 1.2,
              child: ListView.builder(
                  itemCount: historyProvider.historyData!.data!.length,
                  itemBuilder: (context, index) {
                    return getCard(index, historyProvider);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCard(int index, CodeCheckHistoryProvider historyProvider) {
    return GestureDetector(
      onTap: () async {
        _presentBottomSheet(context, historyProvider, index);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: historyProvider.historyData!.data![index].clr!
                                .toString()
                                .endsWith("Green")
                            ? Color(0xFFDFFAC9)
                            : Color(0xFFFACDC9),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Transform.rotate(
                        //angle: 2.35619, // Rotate the arrow by 45 degrees
                        angle: 5.49779, // Rotate the arrow by 45 degrees
                        child: Icon(
                          Icons.arrow_downward,
                          color: historyProvider.historyData!.data![index].clr!
                                  .toString()
                                  .endsWith("Green")
                              ? Colors.green
                              : Colors.red, // Arrow color
                          size: 20, // Arrow size
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Text(
                                    historyProvider
                                        .historyData!.data![index].trStatus!,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.roboto(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                    margin: EdgeInsets.only(left: 0, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "+",
                                          style: TextStyle(
                                            color: historyProvider.historyData!
                                                    .data![index].clr!
                                                    .toString()
                                                    .endsWith("Green")
                                                ? AppColors.green
                                                : AppColors.red,
                                          ),
                                        ),
                                        Text(
                                          historyProvider
                                              .historyData!.data![index].loyalty
                                              .toString(),
                                          style: TextStyle(
                                            color: historyProvider.historyData!
                                                    .data![index].clr!
                                                    .toString()
                                                    .endsWith("Green")
                                                ? AppColors.green
                                                : AppColors.red,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 0),
                                  child: Text(
                                    historyProvider
                                        .historyData!.data![index].compName
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xff7b7f83),
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 0),
                                  child: Text(
                                    historyProvider
                                        .historyData!.data![index].updt1
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xff7b7f83),
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              height: 1,
              color: AppColors.diveder_color,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  void _presentBottomSheet(BuildContext context, CodeCheckHistoryProvider historyProvider, index) {
    showModalBottomSheet(
      context: context,
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
                        "Code Check Details",
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
                  "Here is a detailed report for the code check.",
                  style: GoogleFonts.roboto(
                      fontSize: 12, color: AppColors.yellow_app),
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
                          "Code",
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
                          historyProvider.historyData!.data![index].code1
                                  .toString() +
                              historyProvider.historyData!.data![index].code2
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
                          "Code check Date",
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
                          historyProvider.historyData!.data![index].updt1
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
                margin: EdgeInsets.only(top: 10, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: Text(
                          "Points",
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "+",
                              style: TextStyle(
                                color: historyProvider
                                        .historyData!.data![index].clr!
                                        .toString()
                                        .endsWith("Green")
                                    ? AppColors.green
                                    : AppColors.red,
                              ),
                            ),
                            Text(
                                historyProvider
                                    .historyData!.data![index].currencySign
                                    .toString(),
                                style: TextStyle(
                                  color: historyProvider
                                          .historyData!.data![index].clr!
                                          .toString()
                                          .endsWith("Green")
                                      ? AppColors.green
                                      : AppColors.red,
                                )),
                            Text(
                              historyProvider.historyData!.data![index].loyalty
                                  .toString(),
                              style: TextStyle(
                                color: historyProvider
                                        .historyData!.data![index].clr!
                                        .toString()
                                        .endsWith("Green")
                                    ? AppColors.green
                                    : AppColors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
                          "Status",
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
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: historyProvider
                                              .historyData!.data![index].clr
                                              .toString() ==
                                          "Red"
                                      ? Colors.red
                                      : Colors.green),
                            ),
                            SizedBox(width: 5),
                            // Add some space between the circle and text
                            Text(
                              historyProvider.historyData!.data![index].trStatus
                                  .toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontStyle: FontStyle.normal,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
                          "Service Type",
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
                          historyProvider.historyData!.data![index].serviceName
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
                  color: Color(0xFFF3F5FC)

                ),
                padding: EdgeInsets.all(16),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: AppColors.yellow_app, fontSize: 12), // Default text style
                    children: [
                      TextSpan(
                        text: "If you have any support, please call this number: ",
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
                                (context)=>RaisedTicketScreen(
                                  ticketType: "Code Check History ${
                                      historyProvider.historyData!.data![index].code1
                                          .toString() +
                                          historyProvider.historyData!.data![index].code2
                                              .toString()
                                  }",
                                )));

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>RaisedTicketScreen(ticketType: "Code Check History ${
                              historyProvider.historyData!.data![index].code1
                                  .toString() +
                                  historyProvider.historyData!.data![index].code2
                                      .toString()
                          }",)));
                    },
                      child: Text("Issue Report",style: GoogleFonts.roboto(color: AppColor.app_btn_color),)
                  ),
                ],
              ),
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
