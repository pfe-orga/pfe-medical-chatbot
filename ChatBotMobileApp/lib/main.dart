import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pfemedicalchatbotapp/view/firstscreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dependency_injection/service_locator.dart';
import 'view/AdminWelcomePage.dart';
import 'view/ChatScreen.dart';
import 'view/DoctorsList.dart';
import 'view/EmergencyCallScreen.dart';
import 'view/List.dart';
import 'view/LoginScreen.dart';
import 'view/MedicationsReminderScreen.dart';
import 'view/OpeningScreen.dart';
import 'view/ProfileScreen.dart';
import 'view/RegisterScreen.dart';
import 'view/SearchMedicationScreen.dart';
import 'view/UsersList.dart';
import 'view/WelcomeScreen.dart';

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
        home:  SearchMedicationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}