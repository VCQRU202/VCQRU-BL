import 'package:flutter/material.dart';
class DynamicElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final Widget widget;
  final TextStyle? textStyle;
  final BorderRadiusGeometry borderRadius; // Add borderRadius parameter
  final Color borderColor; // Add borderColor parameter
  final double borderWidth; // Add borderWidth parameter

  const DynamicElevatedButton({
    Key? key,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
    required this.widget,
    this.textStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)), // Default border radius
    this.borderColor = Colors.transparent, // Default border color (transparent)
    this.borderWidth = 2.0, // Default border width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        elevation: MaterialStateProperty.all<double>(0), // Remove default elevation
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius, // Use dynamic borderRadius
            side: BorderSide(
              color: borderColor, // Use dynamic border color
              width: borderWidth, // Use dynamic border width
            ),
          ),
        ),
        overlayColor: MaterialStateProperty.all<Color>(textColor.withOpacity(0.2)),
      ),
      child: widget,
    );
  }
}
