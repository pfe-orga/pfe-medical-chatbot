import 'package:flutter/material.dart';
import '../controllers/HomeController.dart';
import '../controllers/LoginController.dart';
import '../dependency_injection/service_locator.dart';

class Login extends StatefulWidget {
   const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = getIt<LoginController>();

  final homeController = getIt<HomeController>();

  final _formKey = GlobalKey<FormState>();

  // String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final loginController = getIt<LoginController>();
    loginController.init();

    // mainAxisAlignment: MainAxisAlignment.start;

    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<bool>(
        // future: loginController.login(),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
             final error = snapshot.error;
           return Center(
            child: Text(
              "Error: " + error.toString(),
            ),
          );
    }

          return Container(
            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage("lib/assets/GHOST.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Expanded(
                  child: Column(
                  children: [
                    SizedBox(height: 100),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            child: Image.asset('lib/assets/logokawaii.png'),
                            height: 100,
                          ),
                        ),
                        SizedBox(height: 40),

                        Text('Enter Your Account',

                          style: TextStyle(fontFamily: 'SofiaProLight',
                            fontSize: 22 ,
                            fontWeight: FontWeight.w300,
                            foreground: Paint()
                              ..color = Colors.white
                              ..strokeWidth = 1
                              ..style = PaintingStyle.stroke,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          height:460,
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(1),
                              )
                            ],

                            image: DecorationImage(
                              image: AssetImage("lib/assets/image.png"),

                              fit: BoxFit.cover,

                            ),
                          ),


                          child: Column(
                              children: [
                                SizedBox(height: 50),


                                Text('E-mail',

                                  style: TextStyle(fontFamily: 'SofiaProLight',
                                    fontSize: 18 ,
                                    fontWeight: FontWeight.w300,
                                    foreground: Paint()
                                      ..color = Colors.white
                                      ..strokeWidth = 1
                                      ..style = PaintingStyle.stroke,
                                  ),
                                ),

                                TextFieldContainer(child: TextFormField(
                                  controller: loginController.emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                )
                                ),
                                SizedBox(height: 10),

                                Text('Password',

                                  style: TextStyle(fontFamily: 'SofiaProLight',
                                    fontSize: 18 ,
                                    fontWeight: FontWeight.w300,
                                    foreground: Paint()
                                      ..color = Colors.white
                                      ..strokeWidth = 1
                                      ..style = PaintingStyle.stroke,
                                  ),
                                ),

                                TextFieldContainer(child: TextFormField(
                                  controller: loginController.passwordController,

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                )
                                ),
                                SizedBox(height: 40),
                                GestureDetector(
                                    onTap: (){
                                      loginController.login();
                                      if (_formKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Processing Data')),
                                        );
                                      }
                                    },
                                    onHorizontalDragEnd: (DragEndDetails details){
                                      if (details.primaryVelocity! > 0) {
                                        // User swiped Left
                                      }
                                      else if (details.primaryVelocity! < 0) {
                                        // User swiped Right
                                      }
                                    },
                                    child: Image.asset("lib/assets/swipelogo.png", height: 40,width: 40,)
                                ),
                                SizedBox(height: 10,),
                                Text('Swipe right to login',

                                  style: TextStyle(fontFamily: 'SofiaProLight',
                                    fontSize: 18 ,
                                    fontWeight: FontWeight.w300,
                                    foreground: Paint()
                                      ..color = Colors.white
                                      ..strokeWidth = 1
                                      ..style = PaintingStyle.stroke,
                                  ),
                                ),
                              ]
                          ),

                        )],



                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Size size = MediaQuery.of(context).size;


    return Container(
      margin:const  EdgeInsets.symmetric(vertical: 20),
      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // width: size.width * 0.8,
      width: 200,
      height: 40,

      decoration: BoxDecoration(
        color:const Color(0xFFbfd8cb),
        borderRadius: BorderRadius.circular(20),

      ),
      child: child,
    );
  }

}
