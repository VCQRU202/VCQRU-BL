import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';


class CustomListItem extends StatelessWidget {
  final String code;
  final String date;
  final String status;

  const CustomListItem({
    Key? key,
    required this.code,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(code),
              const SizedBox(
                height: 4,
              ),
              Text(date),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                status=="Unsuccess"?Icons.cancel_outlined: Icons.verified_outlined,
                color: status=="Unsuccess"?AppColor.red_color:AppColor.green_color,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(status),
            ],
          ),
        ],
      ),
    );
  }
}
