import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../controllers/ChatBotController.dart';
import '../dependency_injection/service_locator.dart';
import 'galleryScreen.dart';

class SearchMedication extends StatefulWidget {
  @override
  _SearchMedicationState createState() => _SearchMedicationState();
}

class _SearchMedicationState extends State<SearchMedication> {
  final chatbotController = getIt<ChatbotController>();

  File? _profilePicture;
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,

      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: 390, // Set the desired height here
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              child: SelectPhotoOptionsScreen(onTap: (ImageSource source) {
              },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    File? _profilePicture;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFf64376), Color(0xFFeb4eaa)],
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFF6F8FC),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: TopContainer(),
            ),
            SizedBox(height: 10),
            // Flexible(
            //   flex: 7,
            //   child: ListView.builder(
            //
            //
            //   ),
            // ),
          ],
        ),
      ),

      floatingActionButton: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf64376), Color(0xFFeb4eaa)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          elevation: 4,
          backgroundColor: Color(0xFFf64376),
          child: const Icon(Icons.camera_alt),
          onPressed: () {
            _showBottomSheet(context);
          },
        ),
      ),
    );
  }
}

class TopContainer extends StatefulWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFf64376), Color(0xFFeb4eaa)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 27),
          bottomRight: Radius.elliptical(50, 27),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
            offset: Offset(0, 3.5),
          ),
        ],
      ),
      width: double.infinity,
      height: 190,
      child: Column(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "search medication",
              style: TextStyle(
                fontFamily: "coolvetica",
                fontSize: 64,
                color: Colors.white,
              ),
            ),
          ),
          Divider(
            color: Color(0xFFf64376),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),


          ),
        ],
      ),

    );
  }
}