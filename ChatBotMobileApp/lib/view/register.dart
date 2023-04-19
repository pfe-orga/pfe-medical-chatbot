import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    // mainAxisAlignment: MainAxisAlignment.start;

    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [Container(
            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage("lib/assets/GHOST.jpg",

                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Form(
              key: _formKey,

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

                      Text('Create Your Account',

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
                              SizedBox(height: 40),

                              Text('Username',

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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              )),
                              SizedBox(height: 5),

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
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (val){
                                  validateEmail(val);
                                },

                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your e-mail address';
                                //   }
                                //   return null;
                                // },
                              )
                              ),
                              SizedBox(height: 5),

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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                              )
                              ),
                              GestureDetector(
                                onTap: (){
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
                              Text('Swipe right to register',

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
          )],
        ),

    );
  }
  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    }else if(!EmailValidator.validate(val, true)){
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    }else{
      setState(() {

        _errorMessage = "";
      });
    }
  }
}


class TextFieldContainer extends StatefulWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
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
      child: widget.child,
    );
  }
}
