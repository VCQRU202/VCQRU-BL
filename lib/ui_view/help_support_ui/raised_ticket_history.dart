import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../providers_of_app/raised_ticket_history_provider/raised_ticket_history_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';



class RaisedTicketHistory extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<RaisedTicketHistory> {


  List<Map<String, dynamic>> questions = [
    {
      'question': "What condition should the item be in for a successful return or exchange?",
      'details': {
        'Concern': "How to create an account? I have an issue with my payments. It seems failure many times.",
        'Raised On': "Nov 07, 2024",
        'Ticket ID': "BL123456",
        'Updated On': "Nov 10, 2024",
        'Status': "Query Solved"
      },
      'expanded': false
    },
    {
      'question': "Can I return an item that has been opened/used?",
      'details': {
        'Concern': "How to return an opened item?",
        'Raised On': "Nov 08, 2024",
        'Ticket ID': "BL123457",
        'Updated On': "Nov 11, 2024",
        'Status': "Processing"
      },
      'expanded': false
    },
    {
      'question': "Do I need to include all original packaging and accessories when returning an item?",
      'details': {
        'Concern': "Do I need original packaging for returns?",
        'Raised On': "Nov 09, 2024",
        'Ticket ID': "BL123458",
        'Updated On': "Nov 12, 2024",
        'Status': "Pending"
      },
      'expanded': false
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RaisedTicketHistoryProvider>(context, listen: false).getRaisedHistory();
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<RaisedTicketHistoryProvider>(context, listen: false).setExpandedIndex(-1);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tickets',style: GoogleFonts.roboto(fontSize: 18,color: Colors.white),),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: splashProvider.color_bg,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffF5FAFF),
                Color(0xffEDD3FF),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<RaisedTicketHistoryProvider>(
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
                                      valustate.retrygetRaisedHistory();
                                    },
                                    child: Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            final tickets = valustate.helpData?.data ?? [];
                            return Container(
                              margin: EdgeInsets.only(bottom: 10,top: 10,left: 10,right: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white),
                              child:ListView.builder(
                                itemCount: tickets.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final ticket = tickets[index];
                                //  bool isExpanded = valustate.expandedIndex == index;
                                  bool isExpanded = valustate.expandedIndex == index || (index == 0 && valustate.expandedIndex == -1);


                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(ticket.description??"",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                        trailing: Icon(
                                          isExpanded ? Icons.remove : Icons.add,
                                        ),
                                        onTap: () {
                                          valustate.setExpandedIndex(index); // Toggle the expansion state
                                        },
                                      ),
                                      if (isExpanded)...[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 1,bottom: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft, // Ensures text starts from the left
                                            child: RichText(
                                              textAlign: TextAlign.start, // Align text to start
                                              text: TextSpan(
                                                children: [
                                                  // "Concern:" - Grey color
                                                  TextSpan(
                                                    text: "Concern: ",
                                                    style: TextStyle(
                                                        color: Color(0xff374151),         // Grey color
                                                        fontSize: 14,
                                                        // Font size
                                                        fontWeight: FontWeight.bold // Bold font
                                                    ),
                                                  ),
                                                  // Category value - Black color
                                                  TextSpan(
                                                    text: ticket.category ?? '', // Actual value
                                                    style: TextStyle(
                                                      color: Color(0xff6b7280),       // Black color
                                                      fontSize: 12,              // Font size
                                                      fontWeight: FontWeight.normal, // Normal weight
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Raised On",
                                                    style: TextStyle(
                                                      color: Color(0xff9ca3af),
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    ticket.createdAt ?? '',
                                                    style: TextStyle(
                                                      color: Color(0xff000102),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Ticket ID",
                                                    style: TextStyle(
                                                      color: Color(0xff9ca3af),
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    ticket.ticketId ?? '',
                                                    style: TextStyle(
                                                      color: Color(0xff000102),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Updated On",
                                                    style: TextStyle(
                                                      color: Color(0xff9ca3af),
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    (ticket.updatedDate?.isNotEmpty == true) ? ticket.updatedDate! : 'N/A',
                                                    style: TextStyle(
                                                      color: Color(0xff000102),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Status",
                                                    style: TextStyle(
                                                      color: Color(0xff9ca3af),
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    ticket.status ?? '',
                                                    style: TextStyle(
                                                      color: Color(0xff000102),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                      ]  ,

                                      Divider(color: Colors.grey.shade300),
                                    ],
                                  );
                                },
                              ),
                            );
                          }
                        }
                      }),
                  // "Others" butto
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


