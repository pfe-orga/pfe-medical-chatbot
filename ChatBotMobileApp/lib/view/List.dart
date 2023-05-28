// // import 'package:flutter/material.dart';
// // import 'package:pfemedicalchatbotapp/controllers/ListController.dart';
// // import 'package:pfemedicalchatbotapp/data/models/ListModel.dart';
// // import '../controllers/DeleteController.dart';
// // import '../dependency_injection/service_locator.dart';
// //
// //
// // class HomePage extends StatefulWidget {
// //   HomePage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }
// //
// // class _HomePageState extends State<HomePage> {
// //   final listController = getIt<ListController>();
// //
// //   final deleteController = getIt<DeleteController>();
// //
// //   var userList;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: FutureBuilder<List<ListModel>>(
// //         future: listController.getList(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             final error = snapshot.error;
// //             return Center(
// //               child: Text(
// //                 "Error: " + error.toString(),
// //               ),
// //             );
// //           } else if (snapshot.hasData) {
// //             userList = snapshot.data;
// //             print(userList);
// //             if (userList.isEmpty) {
// //               return const Center(
// //                 child: Text('No data'),
// //               );
// //             }
// //             return GestureDetector(
// //               onLongPress: () {
// //               },
// //               child: ListView.builder(
// //                 itemCount: userList.length,
// //                 itemBuilder: (context, index) {
// //                   return GestureDetector(
// //                     onTap: () {
// //                       showDialog(
// //                         context: context,
// //                         builder: (BuildContext context) {
// //                           return AlertDialog(
// //                             title: Text(userList[index].name ?? ''),
// //                             content: Text(userList[index].email ?? ''),
// //                             actions: <Widget>[
// //                               ElevatedButton(
// //                                 child: Text('Update user'),
// //                                 onPressed: () {
// //
// //                                 },
// //                               ),
// //                               ElevatedButton(
// //                                 child: Text('Delete user'),
// //                                 onPressed: () {
// //                                   print(userList[index].id);
// //                                   deleteController.deleteUser(userList[index].id);
// //                                   setState((){
// //                                     (userList as List<ListModel>).removeAt(index);
// //                                   });
// //                                   Navigator.pop(context);
// //                                 },
// //                               ),
// //                             ],
// //                           );
// //                         },
// //                       );
// //                     },
// //                     child: ListTile(
// //                       title: Text(userList[index].email ?? ''),
// //                       subtitle: Text(userList[index].name ?? ''),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             );
// //           }
// //           return Container();
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:pfemedicalchatbotapp/data/models/ListModel.dart';
// import '../controllers/HomeController.dart';
// import '../data/models/UserModel.dart';
// import '../dependency_injection/service_locator.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // final listController = getIt<ListController>();
//   final homeController = getIt<HomeController>();
//   // final deleteController = getIt<DeleteController>();
//
//   var userList;
//
//   // TextEditingController _nameController = TextEditingController();
//   // TextEditingController _emailController = TextEditingController();
//
//   @override
//   // void dispose() {
//   //   _nameController.dispose();
//   //   _emailController.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<ListModel>>(
//         future: homeController.getList(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             final error = snapshot.error;
//             return Center(
//               child: Text(
//                 "Error: " + error.toString(),
//               ),
//             );
//           } else if (snapshot.hasData) {
//             userList = snapshot.data;
//             print(userList);
//             if (userList.isEmpty) {
//               return const Center(
//                 child: Text('No data'),
//               );
//             }
//             return GestureDetector(
//               onLongPress: () {},
//               child: ListView.builder(
//                 itemCount: userList.length,
//                 itemBuilder: (context, index) {
//
//                   return GestureDetector(
//                     onTap: () {
//                       homeController.nameController.text = userList[index].name ?? '';
//                       homeController.emailController.text = userList[index].email ?? '';
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text("Edit User"),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 TextFormField(
//                                   controller: homeController.nameController,
//                                   decoration: InputDecoration(
//                                     hintText: "Name",
//                                   ),
//                                 ),
//                                 TextFormField(
//                                   controller: homeController.emailController,
//                                   decoration: InputDecoration(
//                                     hintText: "Email",
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             actions: <Widget>[
//                               ElevatedButton(
//                                 child: Text('Update user'),
//                                 onPressed: () {
//                                   final userModel = UserModel(
//                                     id: userList[index].id,
//                                     Name: homeController.nameController.text,
//                                     Email: homeController.emailController.text,
//                                   );
//                                   print(userModel);
//                                   homeController.updateUser(userModel: userModel);
//                                   print('context: ${context}');
//                                   Navigator.pop(context);
//                                   setState(() {
//                                     // Update the user list with the updated user
//                                     userList[index] = userModel;
//                                   });
//                                 },
//                               ),
//                               ElevatedButton(
//                                 child: Text('Delete user'),
//                                 onPressed: () {
//                                   print('THE ID: $userList[index].id');
//                                   homeController.deleteUser(userList[index].id);
//
//                                   Navigator.pop(context);
//                                   setState(() {
//                                     (userList as List<ListModel>)
//                                         .removeAt(index);
//                                   });
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: ListTile(
//                       title: Text(userList[index].email ?? ''),
//                       subtitle: Text(userList[index].name ?? ''),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }