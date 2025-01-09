
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/report_issues/raised_issues_ui.dart';

import '../../providers_of_app/help_support_provider/faq_q_ans_provider.dart';

class FAQScreen extends StatefulWidget {
  String subI,subName;
   FAQScreen({super.key,required this.subI,required this.subName});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FAQProvider>(context, listen: false).gethelpSubQandAns(widget.subI);
  }
  @override
  Widget build(BuildContext context) {
    // Access FAQProvider using Provider.of
     final faqProvider = Provider.of<FAQProvider>(context);
    //
    // // Fetch FAQs when the screen is loaded
    // if (faqProvider.faqList.isEmpty) {
    //   faqProvider.fetchFAQs();
    // }

    return WillPopScope(
      onWillPop: ()async{
        // Clear the faqList in the FAQProvider
        Provider.of<FAQProvider>(context, listen: false).faqList.clear();

        // Optionally, reset the expanded states if needed
        //Provider.of<FAQProvider>(context, listen: false).isExpanded.clear();

        // Pop the current screen
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Help & Support'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Back arrow icon
            onPressed: () {
              // Handle the back arrow press (same as onWillPop)
              Provider.of<FAQProvider>(context, listen: false).faqList.clear();
             // Provider.of<FAQProvider>(context, listen: false).isExpanded.clear();

              Navigator.pop(context); // Pop the current screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Container for "Top Questions" and questions list
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Questions',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Questions list
                    Consumer<FAQProvider>(
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
                                        valustate.retrygethelpsupport(widget.subI);
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
                                child:Column(
                                  children: [
                                    ...faqProvider.faqList.map((faq) {
                                      int index = faqProvider.faqList.indexOf(faq);
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(faq['faqquestion'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                            trailing: Icon(
                                              faqProvider.isExpanded[index] ? Icons.remove : Icons.add,
                                            ),
                                            onTap: () {
                                              faqProvider.toggleExpansion(index); // Toggle the expansion state
                                            },
                                          ),
                                          if (faqProvider.isExpanded[index])
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Concern: ",
                                                      style: TextStyle(
                                                        color: Colors.black54, // Color for "Concern:" text
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: faq['faqanswer'],
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12// Color for the answer text
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          Divider(color: Colors.grey.shade300),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                ),
                              );
                            }
                          }
                        }),
                    SizedBox(height: 10),
                    // "Others" button
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Handle the button tap event here
                          print('Others button tapped');
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>RaisedTicketScreen(ticketType: widget.subName,)));
                        },
                        child: Text('Others'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


