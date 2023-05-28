import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/GeolocationController.dart';
import '../data/models/GeoModel.dart';
import '../dependency_injection/service_locator.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  final _formKey = GlobalKey<FormState>();
  final geoLocationController = getIt<GeoLocationController>();
  List<GeoModel> doctorsList = [];
  String searchQuery = '';
  List<GeoModel> filteredDoctorsList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
                  image: AssetImage("lib/assets/doctorlistbackground.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 59,
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
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                              filteredDoctorsList = doctorsList.where((doctor) {
                                final names = doctor.names?.toLowerCase() ?? '';
                                final place = doctor.place?.toLowerCase() ?? '';
                                final query = searchQuery.toLowerCase();
                                return names.contains(query) || place.contains(query) ;
                              }).toList();
                            });
                          },
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
            top: 180,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  children: [
                    Container(
                      child: const Text(
                        'ID',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'coolvetica',
                          color: Color(0xFF93aece),
                        ),
                      ),

                    ),

                    const SizedBox(width:25 ),

                    Container(
                      child: const Text('Doctor',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'coolvetica',
                          color: Color(0xFF93aece),
                        ),
                      ),
                    ),
                    const SizedBox(width:170),
                    Container(
                      child: const Text('Location',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'coolvetica',
                          color: Color(0xFF93aece),
                        ),
                      ),
                    ),

                    const SizedBox(width:30),
                    Container(
                      child: const Text('call',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'coolvetica',
                          color: Color(0xFF93aece),
                        ),
                      ),
                    ),
                    Divider(color: Colors.black),
                  ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(top: 230),
            child: FutureBuilder<List<GeoModel>>(
              future: geoLocationController.getDoctorsList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  final error = snapshot.error;
                  return Center(
                    child: Text(
                      "Error: " + error.toString(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  doctorsList = snapshot.data!;
                  print(doctorsList);
                  if (doctorsList.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  }

                  final List<GeoModel> displayedUserList =
                  searchQuery.isEmpty ? doctorsList : filteredDoctorsList;

                  return ListView.builder(
                    itemCount: displayedUserList.length,
                    itemBuilder: (context, index) {
                      final doctor = displayedUserList[index];

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              geoLocationController.namesController.text = doctor.names ?? '';
                              geoLocationController.placeController.text = doctor.place ?? '';
                            },
                            child: ListTile(
                              leading: Text(
                                doctor.id.toString(),
                                style: const TextStyle(
                                  fontFamily: 'coolvetica',
                                  color: Color(0xFFa9bfd9),
                                ),
                              ),
                              title: Text(
                                doctor.names ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFa9bfd9),
                                ),
                              ),
                              // subtitle: Text(
                              //   doctor.place ?? '',
                              //   style: const TextStyle(
                              //     fontFamily: 'Poppins',
                              //     color: Color(0xFFa9bfd9),
                              //   ),
                              // ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        geoLocationController.placeController.text = doctor.place ?? '';
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context){
                                              return AlertDialog(
                                                title: const Text("Doctor's Location"),
                                                  content: TextField(
                                                    controller: geoLocationController.placeController,
                                                    decoration: const InputDecoration(
                                                      hintText: "Doctor's Location",
                                                    ),
                                                  )
                                              );

                                            }
                                            );
                                      },
                                    icon: Icon(Icons.location_on_outlined, color: Colors.red),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      geoLocationController.numeroController.text = doctor.numero ?? '';
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context){
                                            return AlertDialog(
                                                title: const Text("Doctor's phone number"),
                                                content: TextField(
                                                  controller: geoLocationController.numeroController,
                                                  decoration: const InputDecoration(
                                                    hintText: "Doctor's phone number",
                                                  ),
                                                ),
                                            );
                                          }
                                      );
                                    },
                                    icon: Icon(Icons.phone, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                        ],
                      );
                    },
                  );
                }
                return Container();
              },
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
