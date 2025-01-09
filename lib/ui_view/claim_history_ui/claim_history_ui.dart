import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/claim/claim_history_model.dart';
import '../../providers_of_app/claim_history/claim_history_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/values/values.dart';
import '../report_issues/raised_issues_ui.dart';

class ClaimScreen extends StatefulWidget {
  const ClaimScreen({super.key});

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ClaimHistoryProvider>(context, listen: false).getClaimHistory(false);
  }
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Claim History'),
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
          children: [
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: FilterButton(label: 'All', status: null)),
                  Expanded(child: FilterButton(label: 'Pending', status: 0)),
                  Expanded(child: FilterButton(label: 'Approved', status: 1)),
                  Expanded(child: FilterButton(label: 'Rejected', status: 2)),
                ],
              ),
            ),
            // Claim List
            Expanded(
              child: Consumer<ClaimHistoryProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (provider.hasError) {
                    return Center(
                      child: Text(
                        provider.errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: buildClaimList(
                      data1: provider.filteredClaims,
                      provider: provider,
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

  Widget buildClaimList({List<ClaimData>? data1, required ClaimHistoryProvider provider}) {
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: data1?.length ?? 0,
      itemBuilder: (context, index) {
        final item = data1![index];
        return GestureDetector(
          onTap: (){
            _presentBottomSheet(context,provider,index,data1);
          },
          child: Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 8),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.giftImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/placeholder.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.giftName!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${item.giftValue.toString()} Points",
                            style: TextStyle(
                              color: determineColor(item.isapproved??0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildStatusBadge(item.isapproved??0),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFDEE2E6),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _presentBottomSheet(BuildContext context1, ClaimHistoryProvider historyProvider, index,List<ClaimData>? data1) {
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
                  margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                  child: Text("Gallery",style: GoogleFonts.roboto(fontSize: 16),)
              ),
              Container(
                margin: EdgeInsets.only(top: 10,left: 20, right: 10),
                height: 100, // Set a fixed height for the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                  data1![index].giftImages!.length,
                  itemBuilder: (context, imageIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          data1![index].giftImages![imageIndex],
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
                          data1![index].giftName!,
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
                          "Claim Des",
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
                          data1![index].giftDesc
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
                          "Claim Points",
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
                          data1![index].giftValue
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
                          "Claim Date",
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
                          data1![index].claimDate.toString(),
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
                          "Claim Id",
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
                          data1![index].giftId.toString(),
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
                          "Claim Status",
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
                      child:Row(
                        children: [
                          buildStatusBadge(data1![index].isapproved??0)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                  child: Visibility(
                    visible: (data1![index].message??"").toString().isEmpty?false:true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Message:",style: TextStyle(fontWeight: FontWeight.bold),),
                          Flexible(child: Text("${data1![index].message??""}")),
                        ],
                      )
                  )
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RaisedTicketScreen(ticketType: "Claim",)));

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
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
  Color determineColor(int status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 0:
        return Colors.orange;
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget buildStatusBadge(int status) {
    String statusText = status == 1
        ? 'Approved'
        : status == 0
        ? 'Pending'
        : 'Rejected';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: determineColor(status).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: determineColor(status),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
class FilterButton extends StatelessWidget {
  final String label;
  final int? status;

  const FilterButton({required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    final currentFilter = context.watch<ClaimHistoryProvider>().currentFilter;
    final isSelected = currentFilter == status;
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? splashProvider.color_bg : Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      height: 40,
      child: TextButton(
        onPressed: () {
          context.read<ClaimHistoryProvider>().applyFilter(status);
        },
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
            color: isSelected ? Colors.white : Colors.black, // Text color
          ),
        ),
      ),
    );
  }
}

