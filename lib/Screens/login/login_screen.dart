import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:payment_app/Screens/pages/homepage.dart';
import 'package:payment_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../signup/signup.dart';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:auth_app_flutter/Utilities/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

 final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email, _password;

  checkAuthentification() async {
    print("checkAuthentification");
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => PageSwitcher())
        // );
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //   this.checkAuthentification();
  }

  login() async {
    String email;
    List favouriteMeal;
    print('LoginModal');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _email.toString());

      try {
        print('try 1');
        await _auth.signInWithEmailAndPassword(
            email: _email.toString(), password: _password.toString());
        print('try 2');

        print('signin');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        // Navigator.pushReplacementNamed(context, "/");
      } catch (e) {
        showError(e.toString());
        print(e);
      }
    }
  }

  showError(String errormessage) {
    print('show error');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    print('navigateToSignUp');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  
  Future<UserCredential> googleSignIn() async {
    print('googe sign in');
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        // await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Appcolor.background,
      body: SingleChildScrollView
      (
        child: Container
        (
          child: Column
          (
            children: 
            [
              Container(
              height: 400,
              child: Image(
                image: AssetImage('assets/images/wallet.png',),
                fit: BoxFit.contain,
                ),
              ),

              SizedBox
              (
                height: 30,
              ),

              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Welcome!',
                      textStyle:  TextStyle(
                        color: Appcolor.secondary,
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.w500,
                      ),
                      speed: const Duration(
                        milliseconds: 450,
                      )),
                ],
                onTap: () {
                  debugPrint("Welcome back!");
                },
                isRepeatingAnimation: true,
                totalRepeatCount: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child:     Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter Email';
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input!),
                      ),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.length < 6)
                                return 'Provide Minimum 6 Character';
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input!),
                      ),
                      SizedBox(height: 20),

                       Container(
                margin: EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: login,
                  // onPressed: () {
                  //   Navigator.of(context).pop();
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSwitcher()));
                  // },
                  child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter')),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    primary: Appcolor.secondary,
                  ),
                ),
              ),
                      // RaisedButton(
                      //   padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      //   onPressed: () => login(),
                      //   // onPressed: Login(),
                      //   child: Text('LOGIN',
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.bold)),
                      //   color: Appcolor.secondary,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20.0),
                      //   ),
                      // ),

                      TextButton(
                        onPressed: navigateToSignUp,
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                  style: TextStyle(
                                    color: Appcolor.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'inter',
                                  ),
                                  text: 'Sign Up')
                            ],
                          ),
                        ),
                      ),

                      SizedBox
                      (
                        height: 20,
                      ),

                      SignInButton
                      (
                        Buttons.Google,
                        text: "Sign up with Google",
                        onPressed: googleSignIn
                      )
                      
                    ],
                  ),
                ),
              ),
             
              ),

            ]
          ),
        ),
      ),
    );
  }



  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     color: Appcolor.background,
  //     child: SafeArea(
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             // Container
  //             // (
  //             //   height: 200,
  //             //   width: 300,
  //             //   child: Image(image: AssetImage('assets/images/wallet.png',),fit: BoxFit.cover,),
  //             // ),

              
  //             // Image.asset(
  //             //   // 'assets/images/glogo.png',
  //             //   // color: Appcolor.secondary,
  //             //   'assets/images/wallet.png',
  //             //   fit: BoxFit.cover,
  //             // ),
  //             AnimatedTextKit(
  //               animatedTexts: [
  //                 TypewriterAnimatedText('Welcome!',
  //                     textStyle:  TextStyle(
  //                       color: Appcolor.secondary,
  //                       fontSize: 30,
  //                       fontStyle: FontStyle.italic,
  //                       fontFamily: 'Times New Roman',
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                     speed: const Duration(
  //                       milliseconds: 450,
  //                     )),
  //               ],
  //               onTap: () {
  //                 debugPrint("Welcome back!");
  //               },
  //               isRepeatingAnimation: true,
  //               totalRepeatCount: 2,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 vertical: 16,
  //                 horizontal: 32,
  //               ),
  //               child:     Container(
  //               child: Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   children: <Widget>[
  //                     Container(
  //                       child: TextFormField(
  //                           validator: (input) {
  //                             if (input!.isEmpty) return 'Enter Email';
  //                           },
  //                           decoration: InputDecoration(
  //                               labelText: 'Email',
  //                               prefixIcon: Icon(Icons.email)),
  //                           onSaved: (input) => _email = input!),
  //                     ),
  //                     Container(
  //                       child: TextFormField(
  //                           validator: (input) {
  //                             if (input!.length < 6)
  //                               return 'Provide Minimum 6 Character';
  //                           },
  //                           decoration: InputDecoration(
  //                             labelText: 'Password',
  //                             prefixIcon: Icon(Icons.lock),
  //                           ),
  //                           obscureText: true,
  //                           onSaved: (input) => _password = input!),
  //                     ),
  //                     SizedBox(height: 20),

  //                      Container(
  //               margin: EdgeInsets.only(top: 32, bottom: 6),
  //               width: MediaQuery.of(context).size.width,
  //               height: 60,
  //               child: ElevatedButton(
  //                 onPressed: login,
  //                 // onPressed: () {
  //                 //   Navigator.of(context).pop();
  //                 //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSwitcher()));
  //                 // },
  //                 child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter')),
  //                 style: ElevatedButton.styleFrom(
  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                   primary: Appcolor.secondary,
  //                 ),
  //               ),
  //             ),
  //                     // RaisedButton(
  //                     //   padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
  //                     //   onPressed: () => login(),
  //                     //   // onPressed: Login(),
  //                     //   child: Text('LOGIN',
  //                     //       style: TextStyle(
  //                     //           color: Colors.white,
  //                     //           fontSize: 20.0,
  //                     //           fontWeight: FontWeight.bold)),
  //                     //   color: Appcolor.secondary,
  //                     //   shape: RoundedRectangleBorder(
  //                     //     borderRadius: BorderRadius.circular(20.0),
  //                     //   ),
  //                     // ),

  //                     TextButton(
  //                       onPressed: navigateToSignUp,
  //                       style: TextButton.styleFrom(
  //                         primary: Colors.white,
  //                       ),
  //                       child: RichText(
  //                         text: TextSpan(
  //                           text: 'Don\'t have an account? ',
  //                           style: TextStyle(color: Colors.grey),
  //                           children: [
  //                             TextSpan(
  //                                 style: TextStyle(
  //                                   color: Appcolor.secondary,
  //                                   fontWeight: FontWeight.w700,
  //                                   fontFamily: 'inter',
  //                                 ),
  //                                 text: 'Sign Up')
  //                           ],
  //                         ),
  //                       ),
  //                     ),

  //                     SizedBox
  //                     (
  //                       height: 20,
  //                     ),

  //                     SignInButton
  //                     (
  //                       Buttons.Google,
  //                       text: "Sign up with Google",
  //                       onPressed: googleSignIn
  //                     )
                      
  //                   ],
  //                 ),
  //               ),
  //             ),
             
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
