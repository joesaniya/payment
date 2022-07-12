import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:payment_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/login/login_screen.dart';

class Onboard extends StatefulWidget {
  const Onboard({ Key? key }) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with TickerProviderStateMixin{
   final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
   

  @override
  void initState() {
    super.initState();
  }

    _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        skipCallback: () {
          _storeOnboardInfo();
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()
          // HomePage()
          ));
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("Skip clicked"),
          // )
          // );
        },
        finishCallback: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()
          // HomePage()
          ));
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("Finish clicked"),
          // ));
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: Appcolor.secondary,
        imageAssetPath: 'assets/images/onBoarding_1.png',
        title: 'Easy Exchange',
        body: 'Send money to every one by on step and organize your wallet easier.',
        doAnimateImage: true),
    PageModel(
        color: Appcolor.secondary,
        imageAssetPath: 'assets/images/onBoarding_2.png',
        title: 'Easy to Use!',
        body: 'Organize your your expenses and secure your account by pin code every time you use the app.',
        doAnimateImage: true),
    PageModel(
        color: Appcolor.secondary,
        // color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/images/onBoarding_3.png',
        title: 'Connect With Others',
        body: 'Connect with the people from different places',
        doAnimateImage: true),
    // PageModel.withChild(
    //     child: Padding(
    //       padding: EdgeInsets.only(bottom: 25.0),
    //       child: Image.asset('assets/images/wallet_card.png', width: 300.0, height: 300.0),
    //     ),
    //     color: const Color(0xFF5886d6),
    //     doAnimateChild: true)
  ];
}