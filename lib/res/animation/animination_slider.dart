import 'package:flutter/material.dart';
import 'package:vcqru_bl/res/values/values.dart';

import '../app_colors/app_colors.dart';

class AnimatedBullet extends StatelessWidget {
  final bool isSelected;

  AnimatedBullet({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: isSelected ? 1.0 : 0.5,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.all(4),
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: AppColor.app_btn_color//                   <--- border width here
          ),
          color: isSelected ? AppColor.app_btn_color : Colors.white,
        ),
      ),
    );
  }
}