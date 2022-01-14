import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SixthLottie extends StatefulWidget {
  static const String id = "sixth_lottie";
  String lottie;
  SixthLottie({Key? key, required this.lottie}) : super(key: key);

  @override
  _SixthLottieState createState() => _SixthLottieState();
}

class _SixthLottieState extends State<SixthLottie>
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