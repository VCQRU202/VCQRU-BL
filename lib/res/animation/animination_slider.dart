import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/res/values/values.dart';

import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../app_colors/app_colors.dart';

class AnimatedBullet extends StatelessWidget {
  final bool isSelected;

  AnimatedBullet({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
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
            color: Colors.white//                   <--- border width here
          ),
          color: isSelected ? splashProvider.color_bg : Colors.white,
        ),
      ),
    );
  }
}