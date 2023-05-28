import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pfemedicalchatbotapp/view/firstscreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dependency_injection/service_locator.dart';
import 'AdminWelcomePage.dart';
import 'ChatScreen.dart';
import 'DoctorsList.dart';
import 'EmergencyCallScreen.dart';
import 'List.dart';
import 'LoginScreen.dart';
import 'MedicationsReminderScreen.dart';
import 'OpeningScreen.dart';
import 'ProfileScreen.dart';
import 'RegisterScreen.dart';
import 'UsersList.dart';
import 'WelcomeScreen.dart';

Future<void> main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
        home:  FirstScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}