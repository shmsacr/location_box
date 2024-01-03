import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieMarker extends StatelessWidget {
  final String lottiePath;
  final double width;
  final double height;

  LottieMarker({
    required this.lottiePath,
    this.width = 50,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Lottie.asset(lottiePath),
    );
  }
}