import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/Screens/pages/homepage.dart';
import 'package:payment_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_screen.dart';
// import 'package:auth_app_flutter/Utilities/routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


    FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name, _email, _password,_image;

  @override
  void initState()
  {
    super.initState();
  }


  RegisterModal() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email.toString(), password: _password.toString());
        if (user != null) {
          print('sign up');
          SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _email.toString());
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser!.updateProfile(displayName: _name);
          // await Navigator.pushReplacementNamed(context,'/') ;

          print('signup clicked');
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );

        }
      } catch (e) {
        showError(e.toString());
        // showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
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

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Appcolor.background,
      body: SingleChildScrollView
      (
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container
              (
                height: 400,
                child: Image
                (
                  image: AssetImage('assets/images/wallet.png'),
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
                child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter Name';
                            },
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onSaved: (input) => _name = input),
                      ),
                      Container(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter Email';
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input),
                      ),
                      Container(
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                            validator: (input) {
                              if (input!.length < 6)
                                return 'Provide Minimum 6 Character';
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input),
                      ),

                        Container(
                  margin: EdgeInsets.only(top: 32, bottom: 6),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: RegisterModal,
                    // onPressed: () {
                    //   Navigator.of(context).pop();
                    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSwitcher()));
                    // },
                    child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter')),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      primary: Appcolor.secondary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // showModalBottomSheet(
                    //   context: context,
                    //   backgroundColor: Colors.white,
                    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    //   isScrollControlled: true,
                    //   builder: (context) {
                    //     return LoginModal();
                    //   },
                    // );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Have an account? ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                            style: TextStyle(
                              color: Appcolor.secondary,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'inter',
                            ),
                            text: 'Log in')
                      ],
                    ),
                  ),
                ),
                
                    ],
                  ),
                ),
            ),
              ),
            ],
          ),
        ),
        
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     color: Colors.white,
  //     child: SafeArea(
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             // Image.asset(
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
  //             child:  Container(
  //             child: Form(
  //               key: _formKey,
  //               child: Column(
  //                 children: <Widget>[
  //                   Container(
  //                     child: TextFormField(
  //                         validator: (input) {
  //                           if (input!.isEmpty) return 'Enter Name';
  //                         },
  //                         decoration: InputDecoration(
  //                           labelText: 'Name',
  //                           prefixIcon: Icon(Icons.person),
  //                         ),
  //                         onSaved: (input) => _name = input),
  //                   ),
  //                   Container(
  //                     child: TextFormField(
  //                         validator: (input) {
  //                           if (input!.isEmpty) return 'Enter Email';
  //                         },
  //                         decoration: InputDecoration(
  //                             labelText: 'Email',
  //                             prefixIcon: Icon(Icons.email)),
  //                         onSaved: (input) => _email = input),
  //                   ),
  //                   Container(
  //                     child: TextFormField(
  //                         validator: (input) {
  //                           if (input!.length < 6)
  //                             return 'Provide Minimum 6 Character';
  //                         },
  //                         decoration: InputDecoration(
  //                           labelText: 'Password',
  //                           prefixIcon: Icon(Icons.lock),
  //                         ),
  //                         obscureText: true,
  //                         onSaved: (input) => _password = input),
  //                   ),

  //                     Container(
  //               margin: EdgeInsets.only(top: 32, bottom: 6),
  //               width: MediaQuery.of(context).size.width,
  //               height: 60,
  //               child: ElevatedButton(
  //                 onPressed: RegisterModal,
  //                 // onPressed: () {
  //                 //   Navigator.of(context).pop();
  //                 //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSwitcher()));
  //                 // },
  //                 child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'inter')),
  //                 style: ElevatedButton.styleFrom(
  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                   primary: Appcolor.secondary,
  //                 ),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 // showModalBottomSheet(
  //                 //   context: context,
  //                 //   backgroundColor: Colors.white,
  //                 //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  //                 //   isScrollControlled: true,
  //                 //   builder: (context) {
  //                 //     return LoginModal();
  //                 //   },
  //                 // );
  //               },
  //               style: TextButton.styleFrom(
  //                 primary: Colors.white,
  //               ),
  //               child: RichText(
  //                 text: TextSpan(
  //                   text: 'Have an account? ',
  //                   style: TextStyle(color: Colors.grey),
  //                   children: [
  //                     TextSpan(
  //                         style: TextStyle(
  //                           color: Appcolor.secondary,
  //                           fontWeight: FontWeight.w700,
  //                           fontFamily: 'inter',
  //                         ),
  //                         text: 'Log in')
  //                   ],
  //                 ),
  //               ),
  //             ),
              
  //                 ],
  //               ),
  //             ),
  //           ),
                
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
