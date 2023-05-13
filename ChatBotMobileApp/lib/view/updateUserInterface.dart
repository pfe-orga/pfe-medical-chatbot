import 'package:flutter/material.dart';
import '../controllers/HomeController.dart';
import '../dependency_injection/service_locator.dart';

class UpdateUser extends StatefulWidget {
  UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final homeController = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Form(
      child: Column(
         children:[
         TextFormField(


            // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: homeController.nameController,
              decoration: const InputDecoration(
                hintText: 'username',
              )
          ),
      TextFormField(


        // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: homeController.emailController,
          decoration: const InputDecoration(
            hintText: 'email',
          )
      ),
      ElevatedButton(
          onPressed: (){
            // homeController.updateUser(userModel: ) ;
            },
          child:
          Text("Update User"),
      )
      ]
       ),

    ),



    );
  }
}
