import 'package:flutter/material.dart';

import '../../../res/app_colors/app_colors.dart';
class LoadingWidget extends StatefulWidget {
  final VoidCallback? onCompleted;
  final Color? backgroundColor;
  final Color? progressColor;

  const LoadingWidget({
    Key? key,
    this.onCompleted,
    this.backgroundColor,
    this.progressColor,
  }) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _controller.forward().whenComplete(() {
      if (widget.onCompleted != null) {
        widget.onCompleted!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return LinearProgressIndicator(
            backgroundColor: widget.backgroundColor ?? Colors.blue[100], // Dynamic or default background color
            valueColor: AlwaysStoppedAnimation<Color>(
              widget.progressColor ?? AppColor.gray_color, // Dynamic or default progress color
            ),
            value: _controller.value,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
