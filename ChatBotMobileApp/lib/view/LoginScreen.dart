import 'package:flutter/material.dart';

import '../controllers/HomeController.dart';
import '../dependency_injection/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final homeController = getIt<HomeController>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    homeController.init();
  }

  @override
  Widget build(BuildContext context) {
    bool rememberMe = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<bool>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(
                "Error: " + error.toString(),
              ),
            );
          }
          final Size screenSize = MediaQuery.of(context).size;
          return SizedBox(
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
                  image: AssetImage("lib/assets/kawiiui-ai.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 420),
                      Align(
                        alignment: Alignment.center,
                        child: TextFieldContainer(
                          child: TextFormField(
                            controller: homeController.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,  // Remove underline
                              hintText: 'e-mail',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF93aece),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextFieldContainer(child: TextFormField(
                          controller: homeController.passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,  // Remove underline
                            hintText: 'password',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF93aece),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        )
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(left: 60),
                        child: Column(
                          children: [
                           Row(
                            children: [
                              ClipOval(
                                child: Material(
                                  color: Color(0xFF56f2ca),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        rememberMe = !rememberMe;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: rememberMe
                                          ? Image.asset(
                                        'lib/assets/remembermeicon.png',
                                        width: 20,
                                        height: 20,
                                        color: Colors.black,
                                      )
                                          : Container(),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: const Text(
                                  'Remember Me',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFbdc9db),
                                  ),
                                ),
                              ),
                            ],
                          ),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(right: 70),
                              child: UnicornOutlineButton(
                                color: const Color(0xFF15e0c3),
                                strokeWidth: 2,
                                radius: 24,
                                gradient: const LinearGradient(colors: [Color(0xFF15e0c3), Color(0xFF15e0c3)]),
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w100,
                                    foreground: Paint()
                                      ..color = Colors.white
                                      ..strokeWidth = 1
                                      ..style = PaintingStyle.fill,
                                  ),
                                ),
                                onPressed: () {
                                  homeController.login();
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Processing Data')),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Padding(
                              padding: EdgeInsets.only(right: 70),
                              child: const Text(
                                  'Sign up with social account',
                                   style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFa9bfd9),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(right: 70),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                      // Get.to(Login());
                                   },
                                   child: Image.asset('lib/assets/facebook.png',width: 60,height: 60),
                                ),
                               InkWell(
                                onTap: () {
                                 // Get.to(Login());
                                 },
                                 child: Image.asset('lib/assets/gmail.png',width: 60,height: 60),
                               )
                                ],
                              ),
                            )
                          ]
                        ),

                      ),

                      // Add more form fields or widgets here
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      margin:const  EdgeInsets.symmetric(vertical: 20),
      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // width: size.width * 0.8,
      width: 300,
      height: 50,

      decoration: BoxDecoration(
        color:const Color(0xFFffffff),
        borderRadius: BorderRadius.circular(20),

      ),
      child: child,
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
          constraints: BoxConstraints(minWidth: 200, minHeight: 55),
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
