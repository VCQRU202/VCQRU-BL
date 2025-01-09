import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/res/app_colors/Checksun_encry.dart';
import 'package:vcqru_bl/res/app_colors/app_colors.dart';

import '../../providers_of_app/raised_ticket_provider/raised_ticket_provider.dart';

class RaisedTicketScreen extends StatefulWidget {
  final String ticketType; // Example required parameter

  // Constructor with required parameter
  const RaisedTicketScreen({Key? key, required this.ticketType}) : super(key: key);

  @override
  State<RaisedTicketScreen> createState() => _RaisedTicketScreenState();
}

class _RaisedTicketScreenState extends State<RaisedTicketScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _issueController = TextEditingController();
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_animationController!);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<RaisedTicketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Raised Ticket',style: GoogleFonts.roboto(fontSize: 18),),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF6F4FC),
              Color(0xFFE1D7FF),
              Color(0xFFFDE0E7)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Contact Info
                        Row(
                          children: [
                            Icon(Icons.phone,size: 20,color: AppColor.app_btn_color_inactive,),
                            SizedBox(width: 10),
                            Text('+91 7353000903', style: TextStyle(fontSize: 12,color: AppColor.app_btn_color_inactive)),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.email,size: 20,color: AppColor.app_btn_color_inactive,),
                            SizedBox(width: 10),
                            Text('supportteam@vcqru.com', style: TextStyle(fontSize: 12,color: AppColor.app_btn_color_inactive)),
                          ],
                        ),
                        SizedBox(height: 15),

                        // Text Area for Message
                        Text("Add your message", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        SizedBox(height: 5),
                        TextField(
                          controller: _issueController,
                          decoration: InputDecoration(
                            hintText: 'Describe your issue in details',
                            hintStyle: TextStyle(fontSize: 14,color: AppColor.app_btn_color_inactive),
                            border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder( // Border when not focused
                                borderSide: BorderSide(
                                  color: Colors.grey, // Set border color
                                  width: 1.0,        // Border width
                                ),
                              ),
                            focusedBorder: OutlineInputBorder( // Border when focused
                              borderSide: BorderSide(
                                color: Colors.black54, // Highlight color when focused
                                width: 1.0,
                              ),
                            ),
                          ),
                          maxLines: 5,
                        ),
                        SizedBox(height: 10),

                        // Attachments Preview
                        Wrap(
                          spacing: 10, // Horizontal spacing between items
                          runSpacing: 10, // Vertical spacing if wrapped
                          children: [
                            // Existing Attachments
                            ...ticketProvider.images.map((image) {
                              return Stack(
                                clipBehavior: Clip.none, // Allows elements to overflow
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15), // Rounded corners
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Shadow effect
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8), // Clip image corners
                                      child: Image.file(
                                        File(image!.path),
                                        width: 75,
                                        height: 75,
                                        fit: BoxFit.cover, // Proper image scaling
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 2, // Close button position
                                    top: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        ticketProvider.removeImage(image); // Remove logic
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black54, // White background
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 15, // Icon size
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),

                            // Add Attachment Button
                            if (ticketProvider.images.length < 3) // Max limit 3
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextButton(
                                  onPressed: () => ticketProvider.addImage(), // Add image logic
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero, // No padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.link, color: Colors.blue), // Icon color
                                      SizedBox(height: 4), // Space between icon and text
                                      Text(
                                        "Add",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        "Attachment",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),

                        // // Error Message
                        // if (ticketProvider.hasError)
                        //   Padding(
                        //     padding: const EdgeInsets.only(top: 10.0),
                        //     child: Text(
                        //       ticketProvider.errorMessage,
                        //       style: TextStyle(color: Colors.red),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Submit Button
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ticketProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                  ),
                  onPressed: () async {
                    if (_issueController.text.isEmpty) {
                      toastRedC("Please description your issue...");
                      return;
                    }
                    await ticketProvider.submitTicket(_issueController.text,widget.ticketType);
                    if (!ticketProvider.hasError) {
                      _issueController.clear();
                      _showBottomSheet(context); // Show success animation
                    }else{
                      toastRedC(ticketProvider.errorMessage);
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Success Bottom Sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Close the BottomSheet
            Navigator.of(context).pop(); // Close the BottomSheet
          }
        });
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: ScaleTransition(
                  scale: _animation!,
                  child: Container(
                    width: 50, // Set the width of the circle container to 50
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Icon(Icons.check, size: 30, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Success!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Your request has been submitted successfully.",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14,color:Color(0xff6c757d) )),
            ],
          ),
        );
      },
    );
  }
}
// //for ios setting
//
// /*
// android manifest
//
// <uses-permission android:name="android.permission.CAMERA" />
// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
//
// plist file
//
// <key>NSCameraUsageDescription</key>
// <string>We need access to the camera to take photos for attachments.</string>
// <key>NSPhotoLibraryUsageDescription</key>
// <string>We need access to your photo library to select photos for attachments.</string>
//
// uncomment platform from podfile
//
//  */
//