import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FirtsLottie extends StatefulWidget {
  static const String id = "first_lottie";
  String lottie;

  FirtsLottie({Key? key, required this.lottie}) : super(key: key);

  @override
  _FirtsLottieState createState() => _FirtsLottieState();
}

class _FirtsLottieState extends State<FirtsLottie>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
      key: ObjectKey(_controller.forward(from: 0.5)),
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Lottie.asset(widget.lottie, repeat: false),
    );
  }
}
