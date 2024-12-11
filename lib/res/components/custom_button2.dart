
import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';
import '../values/values.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.title,
    this.onPressed,
    this.height = Sizes.HEIGHT_50,
    this.elevation = Sizes.ELEVATION_1,
    this.borderRadius = Sizes.RADIUS_24,
    this.color = AppColors.blackShade5,
    this.borderSide = Borders.defaultPrimaryBorder,
    this.textStyle,
    this.textFormFieldMargin,
    this.text_color,
    this.icon,
    this.radias,
    this.hasIcon = false,
  }) : assert((hasIcon == true && icon != null) ||
      (hasIcon == false && icon == null));

  final VoidCallback? onPressed;
  final double height;
  final double elevation;
  final double borderRadius;
  final String? title;
  final Color color;
  final Color? text_color;
  final double? radias;
  final BorderSide borderSide;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool hasIcon;
  final EdgeInsetsGeometry? textFormFieldMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: textFormFieldMargin,
      width: double.infinity,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radias!)),
          gradient: LinearGradient(
            colors: <Color>[
              AppColors.dashboard_color, AppColors.dashboard_color
            ],
          )),
      child: MaterialButton(
        child:  Text(
          title!,
          style: TextStyle(
              color: text_color,
              fontWeight: FontWeight.bold
          ),
        ),
        onPressed:onPressed,
      ),
    );
  }
}
