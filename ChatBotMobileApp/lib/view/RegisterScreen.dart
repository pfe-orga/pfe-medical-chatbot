import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../controllers/HomeController.dart';
import '../dependency_injection/service_locator.dart';
import 'ChatScreen.dart';
import 'WelcomeScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final homeController = getIt<HomeController>();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  String? selectedOption;
  @override
  void initState() {
    super.initState();
    selectedOption = 'patient';
  }

  @override
  Widget build(BuildContext context) {
    final homeController = getIt<HomeController>();
    bool rememberMe = false;
    String _errorMessage = '';

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
                "Error: $error",
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
                image: const DecorationImage(
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
                            controller: homeController.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,  // Remove underline
                              hintText: 'username',
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
                        child: TextFieldContainer(
                          child: TextFormField(
                            controller: homeController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val){
                              validateEmail(val);
                            },
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your username';
                            //   }
                            //   return null;
                            // },
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
                      Align(
                        alignment: Alignment.center,
                        child: TextFieldContainer(
                          child: DropdownButtonFormField<String>(
                            value: selectedOption,
                            onChanged: (newValue) {
                              setState(() {
                                selectedOption = newValue;
                                homeController.roleController.text = newValue.toString();
                              });
                              print("Selected Option: $selectedOption");
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Select an option',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF93aece),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'patient',
                                child: Text('Patient'),
                              ),
                              DropdownMenuItem(
                                value: 'doctor',
                                child: Text('Doctor'),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 60),
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
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Remember Me',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFbdc9db),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(right: 70),
                                child: UnicornOutlineButton(
                                  color: const Color(0xFF15e0c3),
                                  strokeWidth: 2,
                                  radius: 24,
                                  gradient: const LinearGradient(colors: [Color(0xFF15e0c3), Color(0xFF15e0c3)]),
                                  child: Text(
                                    'Sign Up',
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
                                    print("Selected Option: $selectedOption");
                                    homeController.register().then((value) => homeController.login().then((_){
                                      if (selectedOption == 'patient') {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WelcomeScreen(),
                                          ),
                                        );
                                      } else if (selectedOption == 'doctor') {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreenn(),
                                          ),
                                        );
                                      }
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                      // );
                                    }
                                    )
                                    );
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Processing Data')),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 30),
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
  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    }else if(!EmailValidator.validate(val, true)){
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    }else{
      setState(() {
        _errorMessage = "";
      });
    }
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
