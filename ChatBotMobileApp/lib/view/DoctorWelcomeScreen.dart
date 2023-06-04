import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'SearchMedicationScreen.dart';
import 'SearchPatientScreen.dart';


class DoctorWelcomeScreen extends StatefulWidget {
  final String email;
  final String username;
  const DoctorWelcomeScreen({Key? key,
    required this.email,
    required this.username}) : super(key: key);

  @override
  State<DoctorWelcomeScreen> createState() => _DoctorWelcomeScreenState();
}

class _DoctorWelcomeScreenState extends State<DoctorWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFc0c3c9).withOpacity(1.0),
                      spreadRadius: 5,
                      blurRadius: 30,
                      offset: Offset(0, 5),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage("lib/assets/firstscreenimage.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Positioned(
              top: 350,
              // bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                height: screenSize.height - 280,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children:[
                     UnicornOutlineButton(
                        color: const Color(0xFF15e0c3),
                        strokeWidth: 10,
                        radius: 24,
                        gradient: const LinearGradient(colors: [Color(0xFF53abef), Color(0xFF4a7ff8)]),
                        child: Text(
                          'Search Patient',
                          style: TextStyle(
                            fontFamily: 'coolvetica',
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            foreground: Paint()
                              ..color = Colors.white
                              ..strokeWidth = 1
                              ..style = PaintingStyle.fill,
                          ),
                        ),
                        onPressed: () {
                          Get.to(SearchPatientScreen());
                        }
                    ),
                      const SizedBox(height: 20),
                      UnicornOutlineButton(
                          color: const Color(0xFF15e0c3),
                          strokeWidth: 10,
                          radius: 24,
                          gradient: LinearGradient(colors: [Color(0xFFeb4eac), Color(0xFFf64377)]),
                          child: Text(
                            'Search Medication',
                            style: TextStyle(
                              fontFamily: 'coolvetica',
                              fontSize: 28,
                              fontWeight: FontWeight.w300,
                              foreground: Paint()
                                ..color = Colors.white
                                ..strokeWidth = 1
                                ..style = PaintingStyle.fill,
                            ),
                          ),
                          onPressed: () {
                            Get.to(SearchMedicationScreen());
                          }
                      ),
              ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    required double strokeWidth,
    required double radius,
    required Color color,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : this._painter = _GradientPainter(
    strokeWidth: strokeWidth,
    radius: radius,
    gradient: gradient,
    color: color,
  ),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: Container(
          constraints: BoxConstraints(minWidth: 350, minHeight: 170),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _child,
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Color color;
  final Gradient gradient;

  _GradientPainter({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Color color,
  })  : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient,
        this.color = color;

  @override
  void paint(Canvas canvas, Size size) {
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(
      outerRect,
      Radius.circular(radius),
    );

    _paint.shader = gradient.createShader(outerRect);
    _paint.strokeWidth = strokeWidth;
    _paint.style = PaintingStyle.fill;
    _paint.color = color;

    canvas.drawRRect(outerRRect, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}