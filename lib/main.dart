import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/Screens/pages/homepage.dart';
import 'package:payment_app/onboard.dart';
import 'package:payment_app/payAmountdemo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initial();
  await Firebase.initializeApp();

  runApp(
    MyApp()
    // MaterialApp
    // (
    //   debugShowCheckedModeBanner: false,
    //   // home: PayAmountDemo(),
    //   home: const Onboard()
    // )
    );
}
late String? _email;
 initial() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     _email = preferences.getString("email");
    print('initialvoid');
    log(_email.toString());
  }

// final FirebaseAuth _auth = FirebaseAuth.instance;
// late  User? user;
//   bool isloggedin = false;
//   String? email;

  //  getUser() async {
  //   print('getuser');
  //   User? firebaseUser = _auth.currentUser;
  //   await firebaseUser?.reload();
  //   firebaseUser = _auth.currentUser;

  //   if (firebaseUser != null) {
      
  //       user = firebaseUser;
  //       isloggedin = true;
      
  //   }
  // }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> 
{
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // User? user;
  // bool isloggedin = false;
  // String? email;

  //  void initial() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? _email = preferences.getString("email");
  //   print('initial');
  // }
 
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getLoggedInState();
    // getUser();
    // initial();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Open Sans',
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: WelcomePage(),
      // initialRoute: '/',
      home: _email == null ? Onboard() : HomePage(),

      
    );
  }

}



