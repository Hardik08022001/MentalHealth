import 'package:MetaHelp/meta_app/src/ui/screen/mental_home_component.dart';
import 'package:MetaHelp/meta_app/src/ui/screen/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../mental_health_app.dart';




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyLogin(),
    );
  }
}
class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passcontroller = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(),
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                child: Text(
                  'Welcome\nBack',
                  style: TextStyle( color: Colors.white,fontSize: 33,fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value){
                                if(value!.isEmpty){
                                  return ("Please Enter Your Email");
                                }
                                if(!RegExp("^[a-zA-Z0-9+_.]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                  return("Please Enter a valid email");
                                }
                                return null;
                              },
                              onSaved: (value){
                                emailcontroller.text = value!;
                              },
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (value){
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return("Password is required for login");
                                }
                                if (!regex.hasMatch(value)){
                                  return ("Please Enter Valid Password(Min. 6 Character");
                                }
                              },
                              controller: passcontroller,
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27, fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        signIn(emailcontroller.text, passcontroller.text);
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyRegister()));
                                  },
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(String email, String pass) async
  {
    if(_formKey.currentState!.validate())
      {
        await _auth
            .signInWithEmailAndPassword(email: email, password: pass)
            .then((uid) => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MentalHealthApp())),
        }).catchError((e)
        {

        });
      }
  }
}