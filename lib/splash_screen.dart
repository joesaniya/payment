// import 'package:flutter/material.dart';
// import 'package:payment_app/Screens/login/login_screen.dart';
// import 'package:payment_app/Screens/pages/homepage.dart';
// import 'dart:async';
// import 'package:shimmer/shimmer.dart';



// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   @override
//   void initState(){
//     super.initState();

//     _mockCheckForSession().then(
//         (status) {
//           if (status) {
//             _navigateToHome();
//           } else {
//             _navigateToLogin();
//           }
//         }
//     );
//   }


//   Future<bool> _mockCheckForSession() async {
//     await Future.delayed(Duration(milliseconds: 6000), () {});

//     return true;
//   }

//   void _navigateToHome(){
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (BuildContext context) => HomePage()
//       )
//     );
//   }

//   void _navigateToLogin(){
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//             builder: (BuildContext context) => LoginScreen()
//         )
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           child: Stack(
//             alignment: Alignment.center,
//             children: <Widget>[
//               Opacity(
//                   opacity: 0.5,
//                   child: Image.asset('assets/img/bg.png')
//               ),
    
//               Shimmer.fromColors(
//                 period: Duration(milliseconds: 1500),
//                 baseColor: Color(0xff7f00ff),
//                 highlightColor: Color(0xffe100ff),
//                 child: Container(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     "Vicon",
//                     style: TextStyle(
//                       fontSize: 90.0,
//                       fontFamily: 'Pacifico',
//                       shadows: <Shadow>[
//                         Shadow(
//                           blurRadius: 18.0,
//                           color: Colors.black87,
//                           offset: Offset.fromDirection(120, 12)
//                         )
//                       ]
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }


// }




// // import 'dart:async';
// // import 'dart:developer';

// // import 'package:flutter/material.dart';
// // import 'package:payment_app/main.dart';

// // class SplashScreen extends StatefulWidget {
// //   @override
// //   SplashScreenState createState() => new SplashScreenState();
// // }

// // class SplashScreenState extends State<SplashScreen>
// //     with SingleTickerProviderStateMixin {
// //   var _visible = true;

// //   late AnimationController animationController;
// //   late Animation<double> animation;

// //   // SplashPage(BuildContext context) {
// //   //   log('splash');
// //   //   Future.delayed(const Duration(seconds: 3), () {
// //   //     log('message');
// //   //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
// //   //   });
// //   // }

// //   startTime() async {
// //     log('startTime');
// //     var _duration = new Duration(seconds: 3);
// //     return new Timer(_duration, navigationPage);
// //   }

// //   void navigationPage() {
// //     log('navigator');
// //     // Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
// //     // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
// //     Navigator.pushNamed(context, "/");
// //   }

// // @override
// // dispose() {
// //   animationController.dispose();  
// //   super.dispose();
// // }

// //   @override
// //   void initState() {
// //     super.initState();
// //     animationController = new AnimationController(
// //       vsync: this,
// //       duration: new Duration(seconds: 2),
// //     );
// //     animation =
// //         CurvedAnimation(parent: animationController, curve: Curves.easeOut);

// //     animation.addListener(() => this.setState(() {}));
// //     animationController.forward();

// //     setState(() {
// //       _visible = !_visible;
// //     });
// //     startTime();
// //     // SplashPage(context);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Scaffold(
// //         body: Stack(
// //           fit: StackFit.expand,
// //           children: <Widget>[
// //             new Column(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               mainAxisSize: MainAxisSize.min,
// //               children: <Widget>[
// //                 Padding(
// //                   padding: EdgeInsets.only(bottom: 30.0),
// //                   // child: new Image.asset(
// //                   //   'assets/images/powered_by.png',
// //                   //   height: 25.0,
// //                   //   fit: BoxFit.scaleDown,
// //                   // ),
// //                   child: CircularProgressIndicator(),
// //                 )
// //               ],
// //             ),
// //             new Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: <Widget>[
// //                 new Image.asset(
// //                   'assets/images/onBoarding_1.png',
// //                   width: animation.value * 250,
// //                   height: animation.value * 250,
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }