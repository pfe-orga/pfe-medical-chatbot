import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controllers/ChatBotController.dart';
import '../data/models/MedicationModel.dart';
import '../dependency_injection/service_locator.dart';

class SearchMedication extends StatefulWidget {
  @override
  _SearchMedicationState createState() => _SearchMedicationState();
}

class _SearchMedicationState extends State<SearchMedication> {
  final chatbotController = getIt<ChatbotController>();

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: Container(
            height: 300, // Fixed height for the bottom sheet
            child: SelectPhotoOptionsScreen(
              onTap: (ImageSource source) {
                _handleImageSelection(context, source);
              },
              chatbotController: chatbotController, // Pass the chatbotController instance
            ),
          ),
        );
      },
    );
  }

  void _handleImageSelection(BuildContext context, ImageSource source) {
    // Handle image selection here
  }

  @override
  Widget build(BuildContext context) {
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
            child: Center(
              child: Text(
                'Search Medication',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Upload an image of your medication to get information',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectPhotoOptionsScreen extends StatefulWidget {
  final Function(ImageSource source) onTap;
  final ChatbotController chatbotController; // Add this line

  const SelectPhotoOptionsScreen({
    Key? key,
    required this.onTap,
    required this.chatbotController, // Add this line
  }) : super(key: key);

  @override
  State<SelectPhotoOptionsScreen> createState() =>
      _SelectPhotoOptionsScreenState();
}

class _SelectPhotoOptionsScreenState extends State<SelectPhotoOptionsScreen> {
  File? _profilePicture;
  MedicationModel? _medication;

  Future<void> handleImageSelection(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
      try {
        _medication =
        await widget.chatbotController.GetMedicineInfoAsync(_profilePicture!);
      } catch (e) {
        // Handle error if any
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the _medication instance as needed
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => widget.onTap(ImageSource.camera),
            child: ListTile(
              leading: Icon(Icons.camera),
              title: Text('Take a Photo'),
            ),
          ),
          GestureDetector(
            onTap: () => widget.onTap(ImageSource.gallery),
            child: ListTile(
              leading: Icon(Icons.image),
              title: Text('Choose from Gallery'),
            ),
          ),
        ],
      ),
    );
  }
}
