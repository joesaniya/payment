import 'package:flutter/material.dart';
import 'package:payment_app/theme/theme.dart';

class Topup extends StatefulWidget {
  const Topup({Key? key}) : super(key: key);

  @override
  State<Topup> createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Recharge Bills', style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
      body: Center(child: Text('No Records found!!',style: TextStyle(color: Appcolor.secondary, fontWeight: FontWeight.w500, fontSize: 20))),
    );
    
  }
}