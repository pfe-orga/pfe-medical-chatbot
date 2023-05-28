import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/HomeController.dart';
import '../data/models/ListModel.dart';
import '../dependency_injection/service_locator.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final _formKey = GlobalKey<FormState>();
  final homeController = getIt<HomeController>();
  List<ListModel> userList = [];
  String searchQuery = '';
  List<ListModel> filteredUserList = [];

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
                image: DecorationImage(
                  image: AssetImage("lib/assets/usermanagementbackground.png"),
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
                              filteredUserList = userList.where((user) {
                                final name = user.name?.toLowerCase() ?? '';
                                final email = user.email?.toLowerCase() ?? '';
                                final query = searchQuery.toLowerCase();
                                return name.contains(query) || email.contains(query);
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
                      fontFamily: 'Poppins',
                      color: Color(0xFF93aece),
                    ),
                  ),

                ),
                  const SizedBox(width:25 ),
                  Container(
                    child: const Text('User',
                      style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      color: Color(0xFF93aece),
                    ),
                    ),
                  )
               ]
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(top: 230),
            child: FutureBuilder<List<ListModel>>(
              future: homeController.getList(),
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
                  userList = snapshot.data!;
                  print(userList);
                  if (userList.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  }

                  final List<ListModel> displayedUserList =
                  searchQuery.isEmpty ? userList : filteredUserList;

                  return ListView.builder(
                    itemCount: displayedUserList.length,
                    itemBuilder: (context, index) {
                      final user = displayedUserList[index];

                      return Column(
                        children: [

                          GestureDetector(
                            onTap: () {
                              homeController.nameController.text = user.name ?? '';
                              homeController.emailController.text = user.email ?? '';
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Edit User"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        TextFormField(
                                          controller: homeController.nameController,
                                          decoration: InputDecoration(
                                            hintText: "Name",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: homeController.emailController,
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text('Update user'),
                                        onPressed: () {
                                          final listModel = ListModel(
                                            id: user.id,
                                            name: homeController.nameController.text,
                                            email: homeController.emailController.text,
                                          );
                                          print(listModel);
                                          homeController.updateUser(listModel: listModel).then((_) {
                                            setState(() {
                                              userList[index] = listModel;
                                            });
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Delete user'),
                                        onPressed: () {
                                          print(user.id);
                                          homeController.deleteUser(user.id!).then((_) {
                                            setState(() {
                                              displayedUserList.removeAt(index);
                                            });
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              leading: Text(
                                user.id.toString(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFa9bfd9),
                                ),
                              ),
                              title: Text(
                                user.email ?? '',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFa9bfd9),
                                ),
                              ),
                              subtitle: Text(
                                user.name ?? '',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFa9bfd9),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      homeController.nameController.text = user.name ?? '';
                                      homeController.emailController.text = user.email ?? '';
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Edit User"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                TextFormField(
                                                  controller: homeController.nameController,
                                                  decoration: InputDecoration(
                                                    hintText: "Name",
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: homeController.emailController,
                                                  decoration: InputDecoration(
                                                    hintText: "Email",
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: Text('Update user'),
                                                onPressed: () {
                                                  final listModel = ListModel(
                                                    id: user.id,
                                                    name: homeController.nameController.text,
                                                    email: homeController.emailController.text,
                                                  );
                                                  print(listModel);
                                                  homeController.updateUser(listModel: listModel).then((_) {
                                                    setState(() {
                                                      userList[index] = listModel;
                                                    });
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      print(user.id);
                                      homeController.deleteUser(user.id!).then((_) {
                                        setState(() {
                                          displayedUserList.removeAt(index);
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black45,
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
