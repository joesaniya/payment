

// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:payment_app/Screens/login/login_screen.dart';
import 'package:payment_app/Screens/pages/bill.dart';
import 'package:payment_app/Screens/pages/contact.dart';
import 'package:payment_app/Screens/pages/pay.dart';
import 'package:payment_app/Screens/pages/send_money.dart';
import 'package:payment_app/Screens/pages/shopping.dart';
import 'package:payment_app/Screens/pages/topup.dart';
import 'package:payment_app/helpers/dialog_helper.dart';
import 'package:payment_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // static const routeName = '/';
  late ScrollController _scrollController;
  bool _isScrolled = false;

final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloggedin = false;

  var amount;

  String? res;

  // var _image;
  // File _image;
  // final imagePicker = ImagePicker();

  // SharedPreferences logindata;
  String? username;
  String? email;

   checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        // Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    print('get user');
    User? firebaseUser = _auth.currentUser;
    await firebaseUser!.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  List<dynamic> _services = [
    ['Transfer', Iconsax.export_1, Colors.blue],
    ['Top-up', Iconsax.import, Colors.pink],
    ['Bill', Iconsax.wallet_3, Colors.orange],
    ['Shopping', Iconsax.shopping_bag, Colors.green],
  ];

  List<dynamic> _transactions = [
    ['Amazon', 'https://img.icons8.com/color/2x/amazon.png', '6:25pm', '\₹8.90'],
    ['Cash from ATM', 'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-atm-banking-and-finance-kiranshastry-lineal-color-kiranshastry.png', '5:50pm', '\₹200.00'],
    ['Netflix', 'https://img.icons8.com/color-glass/2x/netflix.png', '2:22pm', '\₹13.99'],
    ['Apple Store', 'https://img.icons8.com/color/2x/mac-os--v2.gif', '6:25pm', '\₹4.99'],
    ['Cash from ATM', 'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-atm-banking-and-finance-kiranshastry-lineal-color-kiranshastry.png', '5:50pm', '\₹200.00'],
    ['Netflix', 'https://img.icons8.com/color-glass/2x/netflix.png', '2:22pm', '\₹13.99']
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);

    super.initState();
    this.checkAuthentification();
    this.getUser();
    getData();
    // setAmount();
    getAmount();
    // Result();
  }
  
 setAmount() async
  {
    
    SharedPreferences setprefamt = await SharedPreferences.getInstance();
    var data=  setprefamt.getInt('initailamt' );
    data==0?  await setprefamt.setInt('initailamt',20000 ):"";
    amount= setprefamt .getInt('initailamt');
    print(setprefamt.getInt('initailamt' ).toString());
    print(amount);
    setState(() {
      
    });
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();

//     Future _signOut(BuildContext context) async {
//     print('future signout');
//     // await FirebaseAuth.instance.signOut();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//         // prefs.setString('email', _email.toString());
//     prefs.clear().then((value)async{ 
//       log(prefs.getString("email").toString())
// ;              await FirebaseAuth.instance.signOut();

//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//         (route) => false);}
//         );
//     // Navigator.of(context).pushAndRemoveUntil(
//     //     MaterialPageRoute(builder: (context) => LoginScreen()),
//     //     (route) => false);
//   }

  // Stream<List<User>> readUsers()=>
  // final docUser=FirebaseFirestore.instance.collection('data').doc('my-id');

  // final json=
  // {
  //   'amount':2000,
  //   'debtamt':200,
  // };

    dynamic data;

  Future<dynamic> getData() async {
    print('get data');

    final DocumentReference document =   FirebaseFirestore.instance.collection("data").doc('LhdQRCIB1DCyGGPi6O1C');

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       data =snapshot.data;
      //  print('data'+data);
     });
    });
 }
  

  // FirebaseAmount() async
  // {
  //   DocumentSnapshot variable = await Firebase.instance.collection('test').doc('').get();
  //   print(variable['field1']);
  // }

  var detamt;
  var Total;

  var tranfered;

getAmount() async
{
  print('getamount');
  DocumentSnapshot variable = await FirebaseFirestore.instance.collection('payment').doc
  (
    // 'f13LicFOzzfMeYtVzxfe'
    'payment_details'
    ).get();
  // doc('MzdflPYy2CCoJI2A2ZgL').get();//only one document value will be get
  print('Sample Data 2 : ${variable['deptamt']}');//de
  print('Sample Data 1 : ${variable['totamt']}');
  setState(() {
     detamt=variable['totamt'];
     Total=variable['deptamt'];
    print('dedamt:${detamt}');
    
    // tranfered=variable['totamt']-variable['deptamt'];
    // print('tranfered:${tranfered}');

    // int sum =(variable['totamt']) - (variable['totamt']);
    // res = sum.toString();
    // log('res+$res');
  });
}

// Result() sync*
// {
//   print('result');
//   int sum =detamt - Total;
//     res = sum.toString();
//     log('res+$res');
// }

  

  @override
  Widget build(BuildContext context) {
    return user == null
              ? Scaffold(
                backgroundColor: Appcolor.background,
                body: Center(
                    child: CircularProgressIndicator
                    (
                      color: Appcolor.background,
                    ),
                  ),
              ):
                WillPopScope(
                  onWillPop: () => _onWillPop(context),
                  child: AdvancedDrawer(
                      backdropColor:Appcolor.secondary,
                      // backdropColor: Colors.grey.shade900,
                      controller: _advancedDrawerController,
                      animationCurve: Curves.easeInOut,
                      animationDuration: const Duration(milliseconds: 300),
                      animateChildDecoration: true,
                      rtlOpening: false,
                      disabledGestures: false,
                      childDecoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Appcolor.secondary,
                            blurRadius: 20.0,
                            spreadRadius: 5.0,
                            offset: Offset(-20.0, 0.0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      drawer: SafeArea(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          child: ListTileTheme(
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    margin: EdgeInsets.only(
                      left: 20,
                      top: 24.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      shape: BoxShape.circle,
                    ),
                    child: 
                  
                              //     user == null
                              // ? const Center(
                              //     child: CircularProgressIndicator(),
                              //   )
                              CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  child: ClipOval(
                    child: SizedBox(
                        width: 80.0,
                        height: 80.0,
                        // child: Icon(Icons.account_circle, size: 70)),
                     child:(user!.photoURL != null)
                        ? Image.network(
                            user!.photoURL.toString(),
                            fit: BoxFit.cover,
                          )
                        : CircleAvatar(
                            backgroundColor: Appcolor.background,
                            child: Text(user!.displayName![0],style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Appcolor.secondary,
                                ),),
                          ),
                    // Image.network(user.displayName[0])
                  
                    // Text(username[1])
                    // Image(image: NetworkImage('$username[1])'),
                    // Image.network("https://wallpaper.dog/large/20469131.jpg",fit: BoxFit.cover,),
                  ),
                  )
                              ),
                  
                  
                  
                    // Image.asset('assets/images/avatar-1.png')
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(user!.email.toString(),
                      // "John Doe", 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                  ),
                  Spacer(),
                  Divider(color: Colors.grey.shade800,),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Iconsax.home),
                    title: Text
                    (
                      'Dashboard',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Iconsax.chart_2),
                    title: Text
                    (
                      'Analytics',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Iconsax.profile_2user),
                    title: Text
                    (
                      'Contacts',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
                    ),
                  ),
                  SizedBox(height: 50,),
                  Divider(color: Colors.grey.shade800),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Iconsax.setting_2),
                    title: Text
                    (
                      'Settings',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
                      ),
                  ),
                  ListTile(
                    onTap: () 
                    {
                      DialogHelper.exit(context);
                      // ShowDialog(
                      //   context:context,
                      //   Builder: (BuildContext context)
                      //   {
                  
                      //   }
                      //   child: AlertDialog(
                      //       title: new Text('Logout?'),
                      //       content: new Text('Are You Sur You want to logout?'),
                      //       backgroundColor: Appcolor.primary,
                      //       shape:
                      //           RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                      //       actions: <Widget>[
                      //         new FlatButton(
                      //           child: new Text('Yes'),
                      //           textColor: Colors.greenAccent,
                      //           onPressed: () {
                      //             _signOut(context);
                      //           },
                      //         ),
                      //         new FlatButton(
                      //           child: Text('no'),
                      //           textColor: Colors.redAccent,
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      // );
                    },
                    leading: Icon(Iconsax.logout),
                    title: Text('Log out',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Version 1.0.0', style: TextStyle(color: Colors.grey.shade500),),
                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: Scaffold(
                        backgroundColor: Appcolor.background,
                        body: CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverAppBar(
                              expandedHeight: 250.0,
                              elevation: 0,
                              pinned: true,
                              stretch: true,
                              toolbarHeight: 80,
                              backgroundColor: Colors.white,
                              leading: IconButton(
                  color: Appcolor.secondary,
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Iconsax.close_square : Iconsax.menu,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                              ),
                              actions: [
                  IconButton(
                    icon: Icon(Iconsax.notification, color:Appcolor.secondary),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Iconsax.more, color: Appcolor.secondary),
                    onPressed: () {},
                  ),
                              ],
                              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                              ),
                              centerTitle: true,
                              title: AnimatedOpacity(
                  opacity: _isScrolled ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\₹',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            // '\₹ 1,840.00',
                            // '\₹'+detamt??'',
                            detamt??'',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 30,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                              ),
                              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  titlePadding: const EdgeInsets.only(left: 20, right: 20),
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _isScrolled ? 0.0 : 1.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeIn(
                          duration: const Duration(milliseconds: 500),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\₹', style: TextStyle(color: Colors.grey.shade800, fontSize: 22),),
                              SizedBox(width: 3,),
                  
                              //initial
                              Text(
                              //  data['amount'],
                                // amount??'',
                                // data['deptamt'],
                                detamt??'',
                                // '${variable['deptamt']}',
                                // '1,840.00',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 9,),
                        FadeIn(
                          duration: const Duration(milliseconds: 500),
                          child: MaterialButton(
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                            onPressed: () 
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => 
                              SendMoney()
                              // PayMoney()
                              ));
                            },
                            child: Text('Send Money', style: TextStyle(color: Colors.black, fontSize: 10),),
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.shade300, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 30,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 8,),
                      ],
                    ),
                  ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate([
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    height: 115,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _services.length,
                      itemBuilder: (context, index) {
                        return FadeInDown(
                          duration: Duration(milliseconds: (index + 1) * 100),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: GestureDetector(
                              onTap: () {
                                if (_services[index][0] == 'Transfer') { 
                                  log('transfer');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
                                }
                                if (_services[index][0] == 'Top-up') { 
                                  log('Top-up');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Topup()));
                                }
                                if (_services[index][0] == 'Bill') { 
                                  log('Bill');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Bill()));
                                }
                                if (_services[index][0] == 'Shopping') { 
                                  log('Shopping');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Shopping()));
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Appcolor.secondary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Icon(_services[index][1], color: Colors.white, size: 25,),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(_services[index][0], style: TextStyle(color: Colors.grey.shade800, fontSize: 12),),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                              ])
                            ),
                            SliverFillRemaining(
                              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    children: [
                      FadeInDown(
                        duration: Duration(milliseconds: 500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Today', style: TextStyle(color: Colors.grey.shade800, fontSize: 14, fontWeight: FontWeight.w600),),
                            SizedBox(width: 10,),
                            Text('\₹${detamt}', 
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700,)),
                            
                          ]
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 20),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _transactions.length,
                          itemBuilder: (context, index) {
                            return FadeInDown(
                              duration: Duration(milliseconds: 500),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(_transactions[index][1], width: 50, height: 50,),
                                        SizedBox(width: 15,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(_transactions[index][0], style: TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w500, fontSize: 14),),
                                            SizedBox(height: 5,),
                                            Text(_transactions[index][2], style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(_transactions[index][3], style: TextStyle(color: Colors.grey.shade800, fontSize: 16, fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                              ),
                            )
                          ]
                        )
                      ),
                    ),
                );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
  
   Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await _showExitBottomSheet(context);
    return exitResult ?? false;
  }

  Future<bool?> _showExitBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration:  BoxDecoration(
            color: Appcolor.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: _buildBottomSheet(context),
        );
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          'Do you really want to exit the app?',
          style: TextStyle(
                                    color: Appcolor.todaybg,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'inter',
                                    fontSize: 20
                                  ),
          // style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('CANCEL',style: TextStyle(color: Appcolor.timetext, fontWeight: FontWeight.w400,fontFamily: 'inter',)),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('YES, EXIT',style: TextStyle(color: Appcolor.timetext, fontWeight: FontWeight.w400,fontFamily: 'inter',)),
            ),
          ],
        ),
      ],
    );
  }
}
