import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Shopping extends StatefulWidget {
  const Shopping({Key? key}) : super(key: key);

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
   @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Personal Care & Beauty', style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
      body: Center(child: Text('No Records found!!',style: TextStyle(color: Appcolor.secondary, fontWeight: FontWeight.w500, fontSize: 20))),
    );
    
  }
}