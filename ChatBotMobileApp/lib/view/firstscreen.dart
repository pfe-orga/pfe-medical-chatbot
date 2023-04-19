import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pfemedicalchatbotapp/view/register.dart';
import 'package:http/http.dart' as http;

import 'login.dart';


class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage("lib/assets/GHOST.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 100),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    child: Image.asset('lib/assets/logokawaii.png'),
                    height: 100,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  height:460,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(1),
                      )
                    ],

                    image: DecorationImage(
                      image: AssetImage("lib/assets/image.png"),

                      fit: BoxFit.cover,

                    ),
                  ),


                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 110),
                        UnicornOutlineButton(
                          strokeWidth: 2,
                          radius: 24,
                          gradient: LinearGradient(colors: [Colors.white, Colors.white]),
                          child: Text('Login',

                            style: TextStyle(fontFamily: 'SofiaProLight',
                              fontSize: 22 ,
                              fontWeight: FontWeight.w300,
                              foreground: Paint()
                                ..color = Colors.white
                                ..strokeWidth = 1
                                ..style = PaintingStyle.stroke,
                            ),
                          ),
                          onPressed: () {
                            Get.to(Login());
                          },
                        ),

                        SizedBox(height: 40),
                        UnicornOutlineButton(
                          strokeWidth: 2,
                          radius: 24,
                          gradient: LinearGradient(colors: [Colors.white, Colors.white]),
                          child: Text('Register',

                            style: TextStyle(fontFamily: 'SofiaProLight',
                              fontSize: 22 ,
                              fontWeight: FontWeight.w300,
                              foreground: Paint()
                                ..color = Colors.white
                                ..strokeWidth = 1
                                ..style = PaintingStyle.stroke,
                            ),
                          ),
                          onPressed: () {
                            Get.to( Register());
                          },
                        ),
                        SizedBox(height: 20),
                        buildSignInWithText(),
                        SizedBox(height: 20),
                        buildSocialBtnRow(),
                      ]
                  ),

                )],
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
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : this._painter = _GradientPainter(strokeWidth: strokeWidth, radius: radius, gradient: gradient),
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
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: BoxConstraints(minWidth: 150, minHeight: 55),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _child,
              ],
            ),
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
  final Gradient gradient;

  _GradientPainter(
      {required double strokeWidth, required double radius, required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(
        outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(
        strokeWidth, strokeWidth, size.width - strokeWidth * 2,
        size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()
      ..addRRect(outerRRect);
    Path path2 = Path()
      ..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
buildSignInWithText() {
  return Column(
    children: <Widget>[
      Text('-OR-',

        style: TextStyle(fontFamily: 'SofiaProLight',
          fontSize: 15 ,
          fontWeight: FontWeight.w300,
          foreground: Paint()
            ..color = Colors.white
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
        ),
      ),
      SizedBox(height: 20.0),
      Text('Sign In With',

        style: TextStyle(fontFamily: 'SofiaProLight',
          fontSize: 18 ,
          fontWeight: FontWeight.w300,
          foreground: Paint()
            ..color = Colors.white
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
        ),
      ),
    ],
  );
}

buildSocialBtnRow() {
  return Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IconButton(onPressed: (){}, icon: Image.asset('lib/assets/fblogo.png'))
        // Image.asset('lib/assets/fblogo.png',width: 60,height: 60,),
        // Image.asset('lib/assets/googlelogo.png',width: 60,height: 60,),
        InkWell(
          onTap: () {

            Get.to(Login());
          },

          child: Image.asset('lib/assets/fblogo.png',width: 60,height: 60),

        ),
        InkWell(
          onTap: () {
            // Get.to(Login());
          },
          child: Image.asset('lib/assets/googlelogo.png',width: 60,height: 60),
        )
    ],
    ),
  );

  }
//
// Future<void> getWeatherForcast() async {
//   var client = new http.Client();
//   try {
//     print(await client.get(https://flutter.dev/"));
//   }
//   catch(ex) {
//     print(ex);
//   }finally {
//     client.close();
//   }
// }
