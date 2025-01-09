import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SvgNetworkImage extends StatelessWidget {
  final String imageUrl;

  SvgNetworkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    print("----icon url--${imageUrl}--");
    return Center(
      child:SvgPicture.network(
        imageUrl,
        placeholderBuilder: (context) => CircularProgressIndicator(),
        fit: BoxFit.contain,
        width: 40,
        height: 40,
      ),
    );
  }
}
