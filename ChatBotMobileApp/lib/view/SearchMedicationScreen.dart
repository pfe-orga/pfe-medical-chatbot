import 'package:flutter/material.dart';
import '../controllers/ChatBotController.dart';
import '../data/models/MedicamentModel.dart';
import '../dependency_injection/service_locator.dart';
import 'galleryScreen.dart';

class SearchMedicationScreen extends StatefulWidget {
  @override
  _SearchMedicationScreenState createState() => _SearchMedicationScreenState();
}

class _SearchMedicationScreenState extends State<SearchMedicationScreen> {
  final chatbotController = getIt<ChatbotController>();
  String? medicineName;
  String? medicinePrice;
  String? medicineDate;
  String? medicineInfo;

  void _handleMedicineInfoReceived(MedicamentModel medication) {
    setState(() {
      medicineName = medication.medicine_name;
      medicinePrice = medication.price;
      medicineDate = medication.date;
    });
  }

  void _handleMedicineInfo(String text) async {
    final response = await chatbotController.GetMedicineResponse(text);
    _handleMedicineInfoReceived(response);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            child: MedicationPhoto(onMedicineInfoReceived: _handleMedicineInfo),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                    image: AssetImage("lib/assets/_Group_.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 75,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: TextFieldContainer(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: chatbotController.medicine_nameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF93aece),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              isCollapsed: true,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search, color: Color(0xFF93aece)),
                          onPressed: () {
                            final String enteredMedicineName = chatbotController.medicine_nameController.text;
                            if (enteredMedicineName.isNotEmpty) {
                              _handleMedicineInfo(enteredMedicineName);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (medicineName != null && medicinePrice != null && medicineDate != null) Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFFeb4eac), Color(0xFFf64377)]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.medical_information,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Medication Name:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicineName!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.monetization_on,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'Medication Price:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            medicinePrice!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.expand_circle_down,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Expiration Date:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            medicineDate!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFf64375), // Change the color here
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          elevation: 4,
          backgroundColor: Color(0xFFf64375),
          child: const Icon(Icons.camera_alt_outlined),
          onPressed: () {
            _showBottomSheet(context);
          },
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: 230,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFffffff),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
