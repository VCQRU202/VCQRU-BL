import 'package:flutter/material.dart';

import '../claim_history_ui/claim_history_ui.dart';
import '../code_check_history_ui/code_check_history.dart';
class ReportMainUI extends StatefulWidget {
  const ReportMainUI({super.key});

  @override
  State<ReportMainUI> createState() => _ReportMainUIState();
}

class _ReportMainUIState extends State<ReportMainUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Report'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(left: 10,right: 10,top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // buildMenuItem(Icons.settings, 'Setting', context),
                // Divider(color: Colors.grey.shade300),

                buildMenuItem(
                    Icons.language, 'Claim History', context,0),
                Divider(color: Colors.grey.shade300),
                buildMenuItem(
                    Icons.card_giftcard, 'Code Check', context,1),
                Divider(color: Colors.grey.shade300),
                buildMenuItem(
                    Icons.card_giftcard, 'Refer & Earn', context,2),

              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildMenuItem(IconData icon, String title, BuildContext context,int i) {
    return InkWell(
      onTap: () {
        // Navigate to a new screen or perform actions
        if(i==0){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ClaimScreen()));
        }
        if(i==1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HistroyCodeCheck()));
        }
        if(i==2){
         // Navigator.push(context, MaterialPageRoute(builder: (context)=>HistroyCodeCheck()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
