import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'dart:async';

import 'package:khizmat_new/feature/authorization/presentation/pages/main_enter_page.dart';

class SplashAnimationPage extends StatefulWidget {
  const SplashAnimationPage({super.key});

  @override
  State<SplashAnimationPage> createState() => _SplashAnimationPageState();
}

class _SplashAnimationPageState extends State<SplashAnimationPage>
    with TickerProviderStateMixin {
  late final AnimationController _bookController;
  late final Animation<double> _bookScale;
  late final Animation<double> _bookOpacity;
  late final AnimationController _rotationController;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  bool _showText = false;
  bool _showCenterIcon = false;
  bool _showCircleAnimation = false;
  double _rotationAngle = 0.0;

  @override
  void initState() {
    super.initState();

    _bookController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _bookScale = Tween(begin: 0.0, end: 1.2)
        .chain(CurveTween(curve: Curves.easeOutBack))
        .animate(
          CurvedAnimation(
            parent: _bookController,
            curve: const Interval(0.0, 0.7),
          ),
        );

    _bookOpacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _bookController, curve: const Interval(0.5, 1.0)),
    );

    // Initialize pulse animation AFTER all controllers are created
    _pulseAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.8,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.2,
          end: 0.8,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50.0,
      ),
    ]).animate(_pulseController);

    _startAnimations();
  }

  void _startAnimations() {
    _bookController.forward();

    _bookController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              _showCircleAnimation = true;
            });
            _startTextAnimation();
          }
        });
      }
    });

    _rotationController.addListener(() {
      if (mounted) {
        setState(() {
          _rotationAngle = -_rotationController.value * 2 * pi;
        });
      }
    });

   
  }

  void _startTextAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showText = true;
        });

        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              _showCenterIcon = true;
            });
            _rotationController.repeat();
            _pulseController.repeat();
          }
        });
      }
    });

     Future.delayed(
      Duration(seconds: 15),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainEnterPage()),
      ),
    );
  }

  @override
  void dispose() {
    _bookController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const greenColor = Color(0xFF61B783);
    const lightGreenColor = Color(0xFFA5D6A7);

    final letters = [
      "assets/splash_letters/h.svg",
      "assets/splash_letters/u.svg",
      "assets/splash_letters/k.svg",
      "assets/splash_letters/u1.svg",
      "assets/splash_letters/m.svg",
      "assets/splash_letters/a.svg",
      "assets/splash_letters/t.svg",
      // "assets/h.svg",
      // "assets/u.svg",
      // "assets/k.svg",
      // "assets/u1.svg",
      // "assets/m.svg",
      // "assets/a.svg",
      // "assets/t.svg",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_showCircleAnimation)
                Opacity(
                  opacity: _bookOpacity.value,
                  child: ScaleTransition(
                    scale: _bookScale,
                    child: SvgPicture.asset(
                      "assets/icons/imzo_icon1.svg",
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
          
              if (_showCircleAnimation) ...[
                const SizedBox(height: 40),
          
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 800),
                        opacity: _showCenterIcon ? 1.0 : 0.0,
                        child: CustomPaint(
                          painter: _CircleConnectionPainter(
                            angle: _rotationAngle,
                            dotCount: 36,
                            color: greenColor.withOpacity(0.3),
                          ),
                          size: const Size(280, 280),
                        ),
                      ),
          
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 800),
                        opacity: _showText ? 1.0 : 0.0,
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: greenColor.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            children: [
                              ...List.generate(letters.length, (index) {
                                final baseAngle =
                                    (2 * pi / letters.length) * index;
                                final angle = baseAngle + _rotationAngle;
                                final radius = 95.0;
          
                                final x = 110 + radius * cos(angle);
                                final y = 110 + radius * sin(angle);
          
                                return Positioned(
                                  left: x - 16,
                                  top: y - 16,
                                  child: SvgPicture.asset(
                                    letters[index],
                                    color: greenColor,
                                    width: 32,
                                    height: 32,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
          
                      // Центральная иконка с пульсацией
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 600),
                        opacity: _showCenterIcon ? 1.0 : 0.0,
                        child: ScaleTransition(
                          scale: _pulseAnimation,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: greenColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: greenColor.withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/imzo_icon1.svg",
                                width: 32,
                                height: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleConnectionPainter extends CustomPainter {
  final double angle;
  final int dotCount;
  final Color color;

  _CircleConnectionPainter({
    required this.angle,
    required this.dotCount,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 15;
    final dotPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    for (int i = 0; i < dotCount; i++) {
      final dotAngle = (2 * pi / dotCount) * i + angle;
      final dotRadius = radius;
      final waveEffect = (sin(dotAngle * 4 + angle * 3) + 1) / 2;
      final dotSize = 2.5 + waveEffect * 3;

      final dotX = center.dx + dotRadius * cos(dotAngle);
      final dotY = center.dy + dotRadius * sin(dotAngle);

      canvas.drawCircle(Offset(dotX, dotY), dotSize, dotPaint);
    }

    final innerRingPaint =
        Paint()
          ..color = color.withOpacity(0.15)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    canvas.drawCircle(center, radius, innerRingPaint);

    final outerRingPaint =
        Paint()
          ..color = color.withOpacity(0.1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    canvas.drawCircle(center, radius + 10, outerRingPaint);
  }

  @override
  bool shouldRepaint(covariant _CircleConnectionPainter oldDelegate) {
    return angle != oldDelegate.angle ||
        dotCount != oldDelegate.dotCount ||
        color != oldDelegate.color;
  }
}
