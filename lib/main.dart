//
//  FootballAnimationFlutterUI
//
//  Created by Abubakir Ro'ziboyev on 11/10/23.
//
//  MARK: Instagram
//  AppMaster
//  MARK: appmaster3101
//
//

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: FootballAnimation(),
      ),
    );
  }
}

class FootballAnimation extends StatefulWidget {
  const FootballAnimation({super.key});

  @override
  State<FootballAnimation> createState() => _FootballAnimationState();
}

class _FootballAnimationState extends State<FootballAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation _anim;
  @override
  void initState() {
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _anim = CurvedAnimation(
      parent: _ctrl,
      curve: Curves.fastOutSlowIn,
    );
    _ctrl.forward();
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _ctrl.reset();
        _ctrl.forward();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _anim,
        child: Container(),
        builder: (context, child) {
          return CustomPaint(
            painter: ClockAnimation(animValue: _anim.value),
            child: child,
          );
        });
  }
}

class ClockAnimation extends CustomPainter {
  final double animValue;
  ClockAnimation({required this.animValue});

  final mainCirclePaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke
    ..strokeWidth = 24.0;
  final circlePaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final angle = 2 * pi * animValue - pi / 3;
    canvas.drawCircle(center, 92, mainCirclePaint);
    canvas.drawCircle(
        center.translate(cos(angle) * 128, sin(angle) * 128), 12, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
