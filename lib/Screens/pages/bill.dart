import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Bill extends StatefulWidget {
  const Bill({Key? key}) : super(key: key);

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
   @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Transactions', style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
      body: Center(child: Text('No Records found!!',style: TextStyle(color: Appcolor.secondary, fontWeight: FontWeight.w500, fontSize: 20))),
    );
    
  }
}