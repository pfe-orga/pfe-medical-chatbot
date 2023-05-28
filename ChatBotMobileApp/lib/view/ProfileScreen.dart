import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controllers/HomeController.dart';
import '../dependency_injection/service_locator.dart';

class ProfileScreen extends StatefulWidget {
  final String email;
  final String username;

  const ProfileScreen({
    Key? key,
    required this.email,
    required this.username,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final homeController = getIt<HomeController>();

  @override
  void initState() {
    super.initState();
    homeController.init();
  }

  @override
  Widget build(BuildContext context) {
    print("Username: ${widget.username}");
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
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
              image: AssetImage("lib/assets/profilebackground.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 40,
                            fontWeight: FontWeight.w300,
                            foreground: Paint()
                              ..color = Colors.white
                              ..strokeWidth = 1
                              ..style = PaintingStyle.fill,
                          ),
                        ),
                        SizedBox(height: 1), // Add some spacing between text and image
                        Image.asset(
                          "lib/assets/image_3.png",
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          '${widget.username}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 23,
                            fontWeight: FontWeight.w300,
                            foreground: Paint()
                              ..color = Colors.white
                              ..strokeWidth = 1
                              ..style = PaintingStyle.fill,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          '${widget.email}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            foreground: Paint()
                              ..color = Colors.white
                              ..strokeWidth = 1
                              ..style = PaintingStyle.fill,
                          ),
                        ),
                        SizedBox(height: 60),
                        Text(
                          'history',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 35,
                            fontWeight: FontWeight.w300,
                            foreground: Paint()
                              ..color = Color(0xFFc65af8)
                              ..strokeWidth = 1
                              ..style = PaintingStyle.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
