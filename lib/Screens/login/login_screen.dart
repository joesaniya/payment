import 'dart:developer';
// import 'dart:html';

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

  @override
  void dispose() {
    super.dispose();
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
        var maillogin=await _auth.signInWithEmailAndPassword(
            email: _email.toString(), password: _password.toString());
            log(maillogin.toString());
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
            backgroundColor: Appcolor.secondary,
            shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
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
         SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', googleUser.email.toString());
        // log(googleAuth.idToken.toString());
        // log(googleUser.email);
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
          // color: Colors.red,
          // padding: EdgeInsets.only(left: 16,right: 16),
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              Padding(
                padding: EdgeInsets.only(left: 25,right: 25),
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox
                          (
                            height: 200,
                          ),
                          SizedBox(height: 50,),
                          Align
                          (
                            alignment: Alignment.centerLeft,
                            child: Text("Welcome,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Appcolor.primary),)),
                          SizedBox(height: 6,),
                          Text("Sign in to continue!",style: TextStyle(fontSize: 20,color: Appcolor.secondary),),
                        ],
                      ),
              ),

              SizedBox
              (
                height: 30,
              ),

              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('UPay!',
                      textStyle:  TextStyle(
                        color: Appcolor.secondary,
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'inter',
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

                        emailInput(),
                        SizedBox(height: 16,),
                        passInput(),
                        // SizedBox(height: 12,),
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: Text("Forgot Password ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                        // ),
      
                        SizedBox(height: 30,),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: login,
                            padding: EdgeInsets.all(0),
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Appcolor.primary,
                                    Appcolor.secondary
                                    // Color(0xffff5f6d),
                                    // Color(0xffff5f6d),
                                    // Color(0xffffc371),
                                  ],
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
                                child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
      
                        SizedBox(height: 16,),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: googleSignIn,
                            color: Colors.indigo.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/google.png',height: 18,width: 18,),
                                SizedBox(width: 10,),
                                Text("Connect with Google",style: TextStyle(color: Appcolor.secondary,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                      
      
      
                      Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey.shade400),),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: navigateToSignUp,
                            child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,color: Appcolor.secondary),),
                          )
                        ],
                      ),
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
  // Widget build(BuildContext context) 
  // {
  //   return Scaffold
  //   (
  //     resizeToAvoidBottomInset: false,
  //     backgroundColor: Appcolor.background,
  //     body: SingleChildScrollView(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Container
  //           (
  //             padding: EdgeInsets.only(left: 16,right: 16),
  //             child: Form
  //             (
  //               key: _formKey,
  //               child: Column
  //               (
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: 
  //                 [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: <Widget>[
  //                       SizedBox(height: 50,),
  //                       Text("Welcome,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Appcolor.primary),),
  //                       SizedBox(height: 6,),
  //                       Text("Sign in to continue!",style: TextStyle(fontSize: 20,color: Appcolor.secondary),),
  //                     ],
  //                   ),
      
  //                   Column
  //                   (
  //                     children: 
  //                     [
      
                        
      
  //                       emailInput(),
  //                       SizedBox(height: 16,),
  //                       passInput(),
  //                       // SizedBox(height: 12,),
  //                       // Align(
  //                       //   alignment: Alignment.topRight,
  //                       //   child: Text("Forgot Password ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
  //                       // ),
      
  //                       SizedBox(height: 30,),
  //                       Container(
  //                         height: 50,
  //                         width: double.infinity,
  //                         child: FlatButton(
  //                           onPressed: login,
  //                           padding: EdgeInsets.all(0),
  //                           child: Ink(
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(6),
  //                               gradient: LinearGradient(
  //                                 begin: Alignment.centerLeft,
  //                                 end: Alignment.centerRight,
  //                                 colors: [
  //                                   Appcolor.primary,
  //                                   Appcolor.secondary
  //                                   // Color(0xffff5f6d),
  //                                   // Color(0xffff5f6d),
  //                                   // Color(0xffffc371),
  //                                 ],
  //                               ),
  //                             ),
  //                             child: Container(
  //                               alignment: Alignment.center,
  //                               constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
  //                               child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
  //                             ),
  //                           ),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(6),
  //                           ),
  //                         ),
  //                       ),
      
  //                       SizedBox(height: 16,),
  //                       Container(
  //                         height: 50,
  //                         width: double.infinity,
  //                         child: FlatButton(
  //                           onPressed: googleSignIn,
  //                           color: Colors.indigo.shade50,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(6),
  //                           ),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: <Widget>[
  //                               Image.asset('assets/images/google.png',height: 18,width: 18,),
  //                               SizedBox(width: 10,),
  //                               Text("Connect with Google",style: TextStyle(color: Appcolor.secondary,fontWeight: FontWeight.bold),),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: 16,),
                      
      
      
  //                     Padding(
  //                     padding: EdgeInsets.only(bottom: 10),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: <Widget>[
  //                         Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey.shade400),),
  //                         SizedBox(width: 5,),
  //                         GestureDetector(
  //                           onTap: navigateToSignUp,
  //                           child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,color: Appcolor.secondary),),
  //                         )
  //                       ],
  //                     ),
  //                   )


  //                     ],
  //                   )
                    
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  Widget emailInput(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email ID",
        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            // color: Colors.grey.shade300,
            color:Appcolor.secondary
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              // color: Colors.red,
              color: Appcolor.secondary
            )
        ),
      ),
      validator: (email) {
        if (email!.isEmpty)
          return 'Please Enter email ID';
        // else if (EmailValidator.validate(email))
        //   return 'Enter valid email address';
        else
          return null;
      },
      onSaved: (email)=> _email = email,
      textInputAction: TextInputAction.next,
    );
  }

  Widget passInput(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            // color: Colors.grey.shade300,
            color: Appcolor.secondary
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            // color: Colors.red,
            color: Appcolor.secondary
          )
        ),
        suffixIconColor:Appcolor.secondary,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggle,
        ),
      ),
      validator: (input) {
                            if (input!.length < 6)
                              return 'Provide Minimum 6 Character';
                          },
      // validator: (password){
      //   Pattern pattern =
      //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      //   RegExp regex = RegExp(pattern.toString());
      //   if (password!.isEmpty){
      //     return 'Please Enter Password';
      //   }else if (!regex.hasMatch(password))
      //     return 'Enter valid password';
      //   else
      //     return null;
      // },
      onSaved: (password)=> _password = password,
      textInputAction: TextInputAction.done,
      obscureText: _obscureText,
    );
  }

   bool _obscureText = true;
  
  void _toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }



}
