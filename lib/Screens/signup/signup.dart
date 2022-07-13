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
    print('show error');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Appcolor.card)),
            backgroundColor: Appcolor.secondary,
            shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)))
            ],
          );
        });
  }


  //custom
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

      Widget nameInput(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Name",
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
          return 'Please Enter username';
        // else if (EmailValidator.validate(email))
        //   return 'Enter valid email address';
        else
          return null;
      },
      onSaved: (name)=> _name = name,
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
                            child: Text("Register Your Walet,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Appcolor.primary),)),
                          SizedBox(height: 6,),
                          Text("Start Your Saving Account Wallet!",style: TextStyle(fontSize: 20,color: Appcolor.secondary),),
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

                        nameInput(),
                        SizedBox(height: 16,),
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
                            onPressed: RegisterModal,
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
                                child: Text("Register",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
      
                      
                        SizedBox(height: 16,),
                      
      
      
                      Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Have an account?",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey.shade400),),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: ()
                            {
                              Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                  );
                            },
                            child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Appcolor.secondary),),
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


    // return Scaffold
    // (
    //   backgroundColor: Appcolor.background,
    //   body: SingleChildScrollView
    //   (
    //     child: Container(
    //       child: Column(
    //         // mainAxisAlignment: MainAxisAlignment.center,
    //         // crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Container
    //           (
    //             height: 400,
    //             child: Image
    //             (
    //               image: AssetImage('assets/images/wallet.png'),
    //               fit: BoxFit.contain,
    //             ),
    //           ),
    //           SizedBox
    //           (
    //             height: 30,
    //           ),
    //           AnimatedTextKit(
    //             animatedTexts: [
    //               TypewriterAnimatedText('Welcome!',
    //                   textStyle:  TextStyle(
    //                     color: Appcolor.secondary,
    //                     fontSize: 30,
    //                     fontStyle: FontStyle.italic,
    //                     fontFamily: 'Times New Roman',
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                   speed: const Duration(
    //                     milliseconds: 450,
    //                   )),
    //             ],
    //             onTap: () {
    //               debugPrint("Welcome back!");
    //             },
    //             isRepeatingAnimation: true,
    //             totalRepeatCount: 2,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(
    //               vertical: 16,
    //               horizontal: 32,
    //             ),
    //             child: Container(
    //             child: Form(
    //               key: _formKey,
    //               child: Column(
    //                 children: <Widget>[
    //                   Container(
    //                     child: TextFormField(
    //                       textInputAction: TextInputAction.next,
    //                       keyboardType: TextInputType.emailAddress,
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
    //                       textInputAction: TextInputAction.next,
    //                       keyboardType: TextInputType.emailAddress,
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
    //                       textInputAction: TextInputAction.done,
    //                       keyboardType: TextInputType.number,
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
    //         ),
    //           ),
    //         ],
    //       ),
    //     ),
        
    //   ),
    // );
  }


}
