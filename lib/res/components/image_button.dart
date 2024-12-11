import 'package:flutter/material.dart';
class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ImageProvider image;

  const ImageButton({
    Key? key,
    required this.onPressed,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Image(
        image: image,
        width: 32,
        height: 32,
        fit: BoxFit.cover,
      ),
    );
  }
}