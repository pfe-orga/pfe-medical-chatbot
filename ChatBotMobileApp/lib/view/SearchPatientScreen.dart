import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPatientScreen extends StatefulWidget {
  const SearchPatientScreen({Key? key}) : super(key: key);

  @override
  State<SearchPatientScreen> createState() => _SearchPatientScreenState();
}

class _SearchPatientScreenState extends State<SearchPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
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
                  image: AssetImage("lib/assets/patient.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

          Positioned(
            top: 78,
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
                          // onChanged: (value) {
                          //   setState(() {
                          //     searchQuery = value;
                          //     filteredDoctorsList = doctorsList.where((doctor) {
                          //       final names = doctor.names?.toLowerCase() ?? '';
                          //       final place = doctor.place?.toLowerCase() ?? '';
                          //       final query = searchQuery.toLowerCase();
                          //       return names.contains(query) || place.contains(query) ;
                          //     }).toList();
                          //   });
                          // },
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
            top: 350,
            left: 0,
            right: 0,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF4d8cf5), Color(0xFF57bceb)]),
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
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Patient Name:',
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
                          'PatientName',
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
                                Icons.email,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Patient E-mail:',
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
                          'PatientE-mail',
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
                                Icons.history_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Patient Chat History:',
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
                          'PatientChatHistory',
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
    );
  }
}
class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFffffff),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}