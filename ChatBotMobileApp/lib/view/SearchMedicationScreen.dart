import 'package:flutter/material.dart';
import 'galleryScreen.dart';

class SearchMedicationScreen extends StatefulWidget {
  @override
  _SearchMedicationScreenState createState() => _SearchMedicationScreenState();
}

class _SearchMedicationScreenState extends State<SearchMedicationScreen> {
  String? medicineInfo;

  void _handleMedicineInfoReceived(String response) {
    setState(() {
      medicineInfo = response;
    });
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
            child: MedicationPhoto(onMedicineInfoReceived: _handleMedicineInfoReceived),
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
                            // Perform search if needed
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Text(
                medicineInfo ?? '', // Display the medicine information
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
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


