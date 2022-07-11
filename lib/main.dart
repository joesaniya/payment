import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/onboard.dart';
import 'package:payment_app/payAmountdemo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp
    (
      debugShowCheckedModeBanner: false,
      // home: PayAmountDemo(),
      home: const Onboard()
    ));
}



