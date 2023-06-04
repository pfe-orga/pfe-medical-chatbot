import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controllers/ChatBotController.dart';
import '../dependency_injection/service_locator.dart';
class MedicationPhoto extends StatefulWidget {
  final Function(String) onMedicineInfoReceived; // Callback function

  const MedicationPhoto({Key? key, required this.onMedicineInfoReceived}) : super(key: key);


  @override
  State<MedicationPhoto> createState() => _MedicationPhotoState();
}

class _MedicationPhotoState extends State<MedicationPhoto> {
  final chatbotController = getIt<ChatbotController>();
  late File imageFile;
  List<String> medicineList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          children: [

            Positioned(
              top: 10,
                child: Container(
              width: 80,
              height: 7,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,

                  ),
            )),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Button background color
                  elevation: 7, // Add shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 100),
                ),
                onPressed: () {
                  _getFromCamera();
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                label: Text(
                  'Take a Photo',
                  style: TextStyle(
                    color: Colors.black,
                      fontFamily: 'Poppins'
                  ),
                ),
              ),


              SizedBox(height: 15),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 70),
                ),
                onPressed: () {
                  _getFromGallery();
                },
                icon: const Icon(Icons.photo_library,
                  color: Colors.black, // Icon color
                ),
                label: const Text('Choose from Gallery',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins'
                  ),
                ),
              ),
            ],
          ),
          ]
        ),
      ),
    );

  }
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
       imageFile = File(pickedFile.path);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print('imageFile: ${imageFile}');
      });
      final medicineInfo = await chatbotController.GetMedicineInfoAsync(
          imageFile);
      final response = '${medicineInfo.medicine_name ?? ''}, ${medicineInfo
          .price ?? ''}, ${medicineInfo.date ?? ''}';
      print('response: ${response}');
      widget.onMedicineInfoReceived(
          response); // Call the callback function with the response    }
    }
  }

}
