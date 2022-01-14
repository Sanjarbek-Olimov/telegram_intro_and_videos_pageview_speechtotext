import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FifthLottie extends StatefulWidget {
  static const String id = "fifth_lottie";
  String lottie;
  FifthLottie({Key? key, required this.lottie}) : super(key: key);

  @override
  _FifthLottieState createState() => _FifthLottieState();
}

class _FifthLottieState extends State<FifthLottie>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      upperBound: 1.0,
    );
    _controller.forward(from: 0.5);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Lottie.asset(widget.lottie, repeat: false),
    );
  }
}
